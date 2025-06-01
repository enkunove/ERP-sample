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
        private readonly LogService _logService;

        public VisitsController(VisitsService visitsService, LogService logService)
        {
            _visitsService = visitsService;
            _logService = logService;
        }

        [Authorize]
        [HttpGet]
        public async Task<IActionResult> GetAllUserHistory()
        {
            try
            {
                var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
                if (userId == null)
                {
                    _logService.LogAllFormats("GET user visit history failed", "Unauthorized access");
                    return Unauthorized();
                }

                var activities = await _visitsService.GetByUserIdAsync(userId);

                if (activities is null)
                {
                    _logService.LogAllFormats("GET user visit history", $"No visits found for user {userId}");
                    return NotFound();
                }

                _logService.LogAllFormats("GET user visit history", new { userId, visitsCount = activities.Count() });
                return Ok(new { activities });
            }
            catch (Exception e)
            {
                _logService.LogAllFormats("GET user visit history error", e.ToString());
                return Forbid();
            }
        }
    }
}
