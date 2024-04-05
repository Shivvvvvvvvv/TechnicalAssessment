using TA.TopUp.Shared.DTOs.Request;
using TA.TopUp.Shared.DTOs.Response;

namespace TA.TopUp.Core.Interfaces.Services
{
    public interface ITopUPService
    {
        Task<TopUpResponse> TopUpBeneficiary(int userId, TopUpBeneficiaryRequest request);
        Task<IEnumerable<TopUpOptionResponse>> GetTopUpOptions(int userId);

    }
}
