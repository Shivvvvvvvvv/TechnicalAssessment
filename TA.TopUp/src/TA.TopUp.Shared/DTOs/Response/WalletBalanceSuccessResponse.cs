namespace TA.TopUp.Shared.DTOs.Response
{
    public class WalletBalanceSuccessResponse
    {
        public long WalletId { get; set; }
        public decimal? Amount { get; set; }
        public string Currency { get; set; }
    }
}
