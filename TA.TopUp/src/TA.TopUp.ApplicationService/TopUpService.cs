using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using TA.TopUp.Core.Entities;
using TA.TopUp.Core.Interfaces.Services;
using TA.TopUp.Infrastructure.DataAccessAbstractions;
using TA.TopUp.Infrastructure.ExternalServices;
using TA.TopUp.Shared.DTOs.Request;
using TA.TopUp.Shared.DTOs.Response;
using TA.TopUp.Shared.Options;

namespace TA.TopUp.ApplicationService
{
    public class TopUpService : ITopUPService
    {
        private readonly ILogger<TopUpService> _logger;
        private readonly IUnitOfWork _unitOfWork;
        private readonly BeneficiariesTopUpValidation _beneficiariesTopUpValidation;
        private readonly WalletService _walletService;
        public TopUpService(WalletService walletService, ILogger<TopUpService> logger, IUnitOfWork unitOfWork, IOptionsMonitor<BeneficiariesTopUpValidation> beneficiariesTopUpValidation)
        {
            _walletService = walletService;
            _logger = logger;
            _unitOfWork = unitOfWork;
            _beneficiariesTopUpValidation = beneficiariesTopUpValidation.CurrentValue;
        }

        private static UserTransaction InsertUserTransaction(int userId, TopUpBeneficiaryRequest request)
        {
            UserTransaction userTransaction = new UserTransaction
            {
                UserId = userId,
                BeneficiaryId = request.BeneficiaryId,
                Amount = request.Amount,
                TransactionType = "Debit",
                CurrencyId = 1,
                CreatedAt = DateTime.UtcNow,
                CreatedBy = userId.ToString()
            };
            return userTransaction;
        }
        public async Task<IEnumerable<TopUpOptionResponse>> GetTopUpOptions(int userId)
        {
            var topUpOptions = (await _unitOfWork.TopUpOptionsRepository.GetAsync(x => x.Amount != null))
                               .Select(s => new TopUpOptionResponse
                               {
                                   UId = s.Uid,
                                   Amount = s.Amount,
                                   Currency = s.Currency?.Currency1 ?? "AED"
                               });
            return topUpOptions;
        }
        public async Task<TopUpResponse> TopUpBeneficiary(int userId, TopUpBeneficiaryRequest request)
        {
            TopUpResponse topUpResponse = new TopUpResponse();
            try
            {
                var beneficiary = (await _unitOfWork.BeneficiaryRepository.GetAsync(x => x.UserId == userId && x.Uid == request.BeneficiaryId, y => y.User)).FirstOrDefault();
                if (beneficiary != null)
                {
                    //maximum beneficiary amount
                    int maxBeneficiaryAmountPerMonth = beneficiary.User?.IsVerified == true ? _beneficiariesTopUpValidation.MaxTopUpPerVerifiedUserPerBenAmt : _beneficiariesTopUpValidation.MaxTopUpPerUnVerifiedUserPerBenAmt;

                    //Maximum Topup Cap per user
                    int maxTopUpAmountPerMonth = _beneficiariesTopUpValidation.MaxTopUpPerBenPerMonth;//need to be renamed

                    //Getting Startdate and end date of current month
                    DateTime now = DateTime.Now;
                    var startDate = new DateTime(now.Year, now.Month, 1);
                    var endDate = startDate.AddMonths(1).AddDays(-1);

                    //Reading permonth total topup based on beneficiary
                    var topUpTransactionPer = (await _unitOfWork.UserTransactionsRepository.GetAsync(x => x.TransactionType == "Debit" && x.CreatedAt >= startDate && x.CreatedAt <= endDate && x.UserId == userId)).ToList();

                    //Total transaction per month
                    decimal? totalTransactionPerMonth = topUpTransactionPer.Sum(y => y.Amount) + request.Amount;

                    //Total Transaction per month based on beneficiary
                    decimal? totalTransactionPerBeneficiary = topUpTransactionPer.Where(x => x.BeneficiaryId == beneficiary.Uid).Sum(y => y.Amount) + request.Amount;

                    //Validating - Refactor below method
                    if (totalTransactionPerMonth <= maxTopUpAmountPerMonth && totalTransactionPerBeneficiary <= maxBeneficiaryAmountPerMonth && maxBeneficiaryAmountPerMonth >= request.Amount)
                    {
                        //Check topup amount
                        var verifyTopUpOption = (await _unitOfWork.TopUpOptionsRepository.GetAsync(x => x.Amount == request.Amount)).FirstOrDefault();

                        //Refract below methos
                        if (verifyTopUpOption != null)
                        {
                            var walletBalance = await _walletService.GetWalletBalance(userId);
                            //user Balance
                            decimal? topUpBalance = walletBalance.Amount;
                            long walletId = walletBalance.WalletId;

                            //Checking enough balance
                            decimal? totalDebit = request.Amount + _beneficiariesTopUpValidation.TopUpCharge;
                            if (totalDebit <= topUpBalance)
                            {
                                //Debit from wallet balance
                                decimal? newBalance = topUpBalance - totalDebit;
                                UserWalletBalance userWalletBalance = UpdateUserWalletBalance(userId,  newBalance , walletId);

                                _unitOfWork.UserWalletBalancesRepository.Update(userWalletBalance);

                                //Insert into transaction table
                                UserTransaction userTransaction = InsertUserTransaction(userId, request);
                                _unitOfWork.UserTransactionsRepository.Insert(userTransaction);

                                //Insert into transaction table
                                UserTransaction userTransactionCharge = InsertUserTransaction(userId, new TopUpBeneficiaryRequest { BeneficiaryId = request.BeneficiaryId, Amount = _beneficiariesTopUpValidation.TopUpCharge });

                                _unitOfWork.UserTransactionsRepository.Insert(userTransactionCharge);

                                topUpResponse.IsSuccess = await _unitOfWork.SaveEntitiesAsync();
                                topUpResponse.Message = "Topup succeed";
                            }
                            else
                            {
                                topUpResponse.IsSuccess = false;
                                topUpResponse.Message = "Insufficient balance";
                            }
                        }
                        else
                        {
                            topUpResponse.IsSuccess = false;
                            topUpResponse.Message = "Invalid topup amount";
                        }
                    }
                    else
                    {
                        topUpResponse.IsSuccess = false;
                        topUpResponse.Message = "Maximum limit exceed";
                    }
                }
                else
                {
                    topUpResponse.IsSuccess = false;
                    topUpResponse.Message = "Beneficiary not Found";
                }

            }
            catch (Exception ex)
            {
                string message = "TopUp service failed unexpectedly";
                _logger.LogError(ex, message);
                topUpResponse.IsSuccess = false;
                topUpResponse.Message = message;

            }
            return topUpResponse;
        }

        private static UserWalletBalance UpdateUserWalletBalance(int userId, decimal? newBalance, long walletId)
        {
            UserWalletBalance userWalletBalance = new UserWalletBalance
            {
                Uid = walletId,
                UserId = userId,
                Balance = newBalance,
                CurrencyId = 1,                
                LastUpdatedAt = DateTime.UtcNow,
                LastUpdatedBy = userId.ToString()
        };
            
            return userWalletBalance;
        }
    }
}
