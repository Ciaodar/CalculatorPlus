using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using calculatorApi.Models;
using calculatorApi.Services;

namespace calculatorApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : ControllerBase
    {
        private readonly UserService _userService;

        public UserController(UserService userService)
        {
            _userService = userService;
        }

        [HttpPost]
        public async Task<IActionResult> RegisterUser([FromBody] UserModel user)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var result = await _userService.RegisterUserAsync(user);

                if (result == null)
                {
                    return BadRequest("Kullanıcı kaydı oluşturulamadı.");
                }

                return Ok(result);
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                return StatusCode(500, "Sunucu hatası. Lütfen daha sonra tekrar deneyin.");
            }
        }
    }
}
