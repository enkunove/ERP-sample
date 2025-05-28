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

        public NewsController(NewsService newsService)
        {
            _newsService = newsService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllNews()
        {
            var news = await _newsService.GetAsync();
            return Ok(new { news});
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
                    return BadRequest();


                News news = new News() { Title = title.ToString(), Payload = payload.ToString(), DatePublished = DateTime.UtcNow};

                await _newsService.CreateAsync(news);
                return Ok();
            }
            catch (Exception e)
            {
                Console.WriteLine($"Error: {e}");
                return BadRequest();
            }
        }

        [HttpDelete]
        public async Task<IActionResult> DeleteNews([FromBody] Dictionary<string, object> data)
        {
            try
            {
                if (
                    !data.TryGetValue("id", out var id) 
                    )
                    return BadRequest();

                await _newsService.RemoveAsync(id.ToString());
                return Ok();
            }
            catch (Exception e)
            {
                Console.WriteLine($"Error: {e}");
                return BadRequest();
            }
        }

    }
}
