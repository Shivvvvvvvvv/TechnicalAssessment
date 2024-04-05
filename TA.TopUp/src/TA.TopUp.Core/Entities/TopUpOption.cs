namespace TA.TopUp.Core.Entities
{
    public partial class TopUpOption
    {
        public long Uid { get; set; }

        public int? Amount { get; set; }

        public long? CurrencyId { get; set; }

        public virtual Currency? Currency { get; set; }
    }
}
