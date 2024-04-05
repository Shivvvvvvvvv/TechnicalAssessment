namespace TA.TopUp.Shared.DTOs.Response
{
    public class WalletBalanceFailureResponse
    {
        public string? Message { get; set; }
        public string? Code { get; set; }
        public DateTime TimeStamp { get; set; }
    }
}
