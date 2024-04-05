using TA.TopUp.Core.Interfaces.Repositories;

namespace TA.TopUp.Infrastructure.DataAccessAbstractions
{
    public interface IUnitOfWork
    {
        Task<bool> SaveEntitiesAsync(CancellationToken ct = default);
        IBeneficiaryRepository BeneficiaryRepository { get; }
        ITopUpOptionsRepository TopUpOptionsRepository { get; }
        IUserTransactionsRepository UserTransactionsRepository { get; }
        IUserWalletBalancesRepository UserWalletBalancesRepository { get; }

    }
}
