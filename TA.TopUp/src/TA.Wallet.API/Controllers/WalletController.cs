using Microsoft.AspNetCore.Mvc;
using TA.Wallet.API.Interfaces;

namespace TA.Wallet.API.Controllers
{
    [Route("wallet")]
    [ApiController]
    public class WalletController : ControllerBase
    {
        private readonly IWalletService _walletService;

        public WalletController(IWalletService walletService) 
        {
            _walletService = walletService;
        }

       [HttpGet("user-balance")]
       public async Task<IActionResult> FetchWalletBalance([FromHeader(Name = "UserId")] int userId)
        {
            
            var result = await _walletService.GetWallentBalanceByUser(userId);
            return Ok(result);
        }
    }
}
