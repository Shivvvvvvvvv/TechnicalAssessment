namespace TA.TopUp.Shared.DTOs.Request
{
    public class TopUpBeneficiaryRequest
    {
        public decimal Amount { get; set; }
        public int BeneficiaryId { get; set; }
        public string Currency { get; set; }
    }
}
