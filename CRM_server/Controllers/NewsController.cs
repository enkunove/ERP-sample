using Microsoft.AspNetCore.Mvc;
using Server.Models;
using Server.Services;
using SerializerLib;

namespace Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NewsController : ControllerBase
    {
        private readonly NewsService _newsService;
        private readonly LogService _logService;

        public NewsController(NewsService newsService, LogService logService)
        {
            _newsService = newsService;
            _logService = logService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllNews()
        {
            var news = await _newsService.GetAsync();
            return Ok(new { news });
        }

        [HttpPost]
        public async Task<IActionResult> PostNews([FromBody] Dictionary<string, object> data)
        {
            try
            {
                if (
                    !data.TryGetValue("title", out var title) ||
                    !data.TryGetValue("payload", out var payload)
                )
                {
                    _logService.LogAllFormats("POST news failed", "Missing title or payload");
                    return BadRequest();
                }

                News news = new News()
                {
                    Title = title.ToString(),
                    Payload = payload.ToString(),
                    DatePublished = DateTime.UtcNow
                };

                _logService.LogAllFormats("POST news", news);

                await _newsService.CreateAsync(news);
                return Ok();
            }
            catch (Exception e)
            {
                _logService.LogAllFormats("POST news error", e.ToString());
                return BadRequest();
            }
        }

        [HttpDelete]
        public async Task<IActionResult> DeleteNews([FromBody] Dictionary<string, object> data)
        {
            try
            {
                if (!data.TryGetValue("id", out var id))
                {
                    _logService.LogAllFormats("DELETE news failed", "Missing id");
                    return BadRequest();
                }

                _logService.LogAllFormats("DELETE news", $"Deleting news with id = {id}");

                await _newsService.RemoveAsync(id.ToString());
                return Ok();
            }
            catch (Exception e)
            {
                _logService.LogAllFormats("DELETE news error", e.ToString());
                return BadRequest();
            }
        }
    }
}
