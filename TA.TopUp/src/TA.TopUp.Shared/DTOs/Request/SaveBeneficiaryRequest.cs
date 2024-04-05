using System.ComponentModel.DataAnnotations;

namespace TA.TopUp.Shared.DTOs.Request
{
    public class SaveBeneficiaryRequest
    {        
        [Required]
        [MaxLength(20)]
        public string? NickName { get; set; }
        [Required]
        [RegularExpression("^([0-9]{10})$", ErrorMessage = "Invalid Mobile Number.")]
        public string MobileNumber { get; set; }
        [Required]
        public string? CountryCode { get; set; }
    }
}
