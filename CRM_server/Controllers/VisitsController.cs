using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Server.Services;
using System.Security.Claims;

namespace Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class VisitsController : ControllerBase
    {
        private readonly VisitsService _visitsService;

        public VisitsController(VisitsService visitsService)
        {
            _visitsService = visitsService;
        }

        [Authorize]
        [HttpGet]
        public async Task<IActionResult> getAllUserHistory()
        {
            try
            {
                var userId = User.FindFirstValue(System.Security.Claims.ClaimTypes.NameIdentifier);
                if (userId == null)
                {
                    return Unauthorized();
                }
                var activities = await _visitsService.GetByUserIdAsync(userId);

                if (activities is null)
                    return NotFound();
                Console.WriteLine(activities.ToString);
                return Ok(new { activities });
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                return Forbid();
            }
        }
    }
}
