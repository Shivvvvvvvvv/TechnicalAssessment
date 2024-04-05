namespace TA.TopUp.Shared.Options
{
    public class BeneficiariesTopUpValidation
    {
        public int MaxBeneficiaryPerUser { get; set; }
        public int MaxTopUpPerVerifiedUserPerBenAmt { get; set; }
        public int MaxTopUpPerUnVerifiedUserPerBenAmt { get; set; }
        public int MaxTopUpPerBenPerMonth { get; set; }
        public int TopUpCharge { get; set; }
    }
}
