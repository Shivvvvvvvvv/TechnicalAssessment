using Microsoft.AspNetCore.Mvc;
using TA.TopUp.Core.Interfaces.Services;
using TA.TopUp.Shared.DTOs.Request;

namespace TA.TopUp.API.Controllers
{
    [Route("beneficiary")]
    [ApiController]
    public class BeneficiaryController : ControllerBase
    {
        private readonly IBeneficiaryService _beneficiaryService;
        private readonly ILogger<BeneficiaryController> _log;

        public BeneficiaryController(IBeneficiaryService beneficiaryService, ILogger<BeneficiaryController> log)
        {
            _beneficiaryService = beneficiaryService;
            _log = log;

        }

        /// <summary>
        /// To get User Beneficiary.
        /// </summary>
        /// <remarks>
        /// Sample request:
        /// 
        ///     Header:
        ///         userId = 1
        ///         
        /// </remarks>
        /// <param name="request">User Beneficiary request data.</param>
        [HttpGet("user-beneficiary")]
        public async Task<IResult> FetchBeneficiaries([FromHeader(Name = "UserId")] int userId)
        {
            _log.LogInformation("Fetch Beneficiary");
            var result = await _beneficiaryService.FetchBeneficiary(userId);
            return Results.Ok(result);
        }

        /// <summary>
        /// To add User Beneficiary.
        /// </summary>
        /// <remarks>
        /// Sample request:
        /// 
        ///     Header:
        ///         userId = 1
        ///         
        ///     Post /beneficiary/add-beneficiary
        ///     {
        ///          "nickName": Tom,
        ///          "mobileNumber": 0544000000,
        ///          "countryCode": "+971"
        ///         }
        ///
        /// </remarks>
        /// <param name="request">add beneficiary request data.</param>

        [HttpPost("add-beneficiary")]
        public async Task<IResult> SaveBeneficiary([FromHeader(Name = "UserId")] int userId, SaveBeneficiaryRequest req)
        {
            _log.LogInformation("Add Beneficiary");
            var result = await _beneficiaryService.SaveBeneficiary(userId,req);
            return Results.Ok(result);

        }

        /// <summary>
        /// To delete User Beneficiary.
        /// </summary>
        /// <remarks>
        /// Sample request:
        /// 
        ///     Header:
        ///         userId = 1
        ///         
        ///     Get /beneficiary/add-beneficiary?beneficiaryId=4'
        ///
        /// </remarks>
        /// <param name="request">delete beneficiary request data.</param>

        [HttpGet("delete-beneficiary")]
        public async Task<IResult> DeleteBeneficiary([FromHeader(Name = "UserId")] int userId, int beneficiaryId)
        {
            _log.LogInformation("Delete Beneficiary");
            var result = await _beneficiaryService.DeleteBeneficiary(userId, beneficiaryId);
            return Results.Ok(result);

        }

        /// <summary>
        /// To update User Beneficiary.
        /// </summary>
        /// <remarks>
        /// Sample request:
        /// 
        ///     Header:
        ///         userId = 1
        ///         
        ///     Post /beneficiary/update-beneficiary
        ///     {
        ///         "id":4
        ///         "nickName": Tomy,
        ///         "mobileNumber": 0544000000,
        ///         "countryCode": "+971"
        ///     }
        ///
        /// </remarks>
        /// <param name="request">update beneficiary request data.</param>
        
        [HttpPost("update-beneficiary")]
        public async Task<IResult> UpdateBeneficiary([FromHeader(Name = "UserId")] int userId, UpdateBeneficiaryRequest req)
        {
            _log.LogInformation("Delete Beneficiary");
            var result = await _beneficiaryService.UpdateBeneficiary(userId, req);
            return Results.Ok(result);

        }
    }
}
