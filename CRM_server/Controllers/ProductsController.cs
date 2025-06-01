using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using QRCoder;
using Server.Models;
using Server.Services;
using System.Drawing.Imaging;
using System.Security.Claims;

namespace Server.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ProductsController : ControllerBase
{
    private readonly ProductService _productService;
    private readonly SubscriptionsService _subscriptionsService;
    private readonly QrService _qrService;
    private readonly LogService _logService;

    public ProductsController(
        ProductService productService,
        SubscriptionsService subscriptionsService,
        QrService qrService,
        LogService logService)
    {
        _productService = productService;
        _subscriptionsService = subscriptionsService;
        _qrService = qrService;
        _logService = logService;
    }

    [HttpGet]
    public async Task<List<Subscription>> Get()
    {
        var result = await _productService.GetAsync();
        _logService.LogAllFormats("GET products", result);
        return result;
    }

    [HttpGet("{id:length(24)}")]
    public async Task<ActionResult<Subscription>> GetById(string id)
    {
        var product = await _productService.GetByIdAsync(id);
        _logService.LogAllFormats("GET product by id", product);

        if (product is null)
            return NotFound();

        return product;
    }

    [HttpDelete("{id:length(24)}")]
    public async Task<IActionResult> Delete(string id)
    {
        var product = await _productService.GetByIdAsync(id);
        if (product is null)
        {
            _logService.LogAllFormats("DELETE product failed", $"Not found: {id}");
            return NotFound();
        }

        await _productService.RemoveAsync(id);
        _logService.LogAllFormats("DELETE product", id);
        return NoContent();
    }

    [Authorize]
    [HttpPost("buy/{id:length(24)}")]
    public async Task<ActionResult<Subscription>> BuyById(string id)
    {
        var product = await _productService.GetByIdAsync(id);
        if (product is null)
        {
            _logService.LogAllFormats("BUY product failed", $"Not found: {id}");
            return NotFound();
        }

        try
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (userId == null)
                return Unauthorized();

            product.Id = null;
            product.UserId = userId;

            DateTime now = DateTime.UtcNow;
            TimeSpan? duration = product.ExpirationDate - product.StartDate;
            product.StartDate = now;
            product.ExpirationDate = now.Add(duration ?? TimeSpan.Zero);

            await _subscriptionsService.CreateAsync(product);

            _logService.LogAllFormats("BUY product", product);
            return Ok();
        }
        catch (Exception e)
        {
            _logService.LogAllFormats("BUY product error", e.ToString());
            return Forbid();
        }
    }

    [Authorize]
    [HttpGet("user")]
    public async Task<ActionResult<List<Subscription>>> GetUserProducts()
    {
        try
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (userId == null)
                return Unauthorized();

            var products = await _subscriptionsService.GetByUserIdAsync(userId);

            if (products is null)
                return NotFound();

            _logService.LogAllFormats("GET user products", new { userId, products });
            return Ok(new { products });
        }
        catch (Exception e)
        {
            _logService.LogAllFormats("GET user products error", e.ToString());
            return Forbid();
        }
    }

    [Authorize]
    [HttpDelete("user")]
    public async Task<ActionResult> DeleteUserProduct([FromBody] Dictionary<string, string> data)
    {
        try
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (userId == null)
                return Unauthorized();

            if (!data.TryGetValue("id", out var id))
            {
                _logService.LogAllFormats("DELETE user product failed", "Missing id");
                return BadRequest();
            }

            var products = await _subscriptionsService.GetByUserIdAsync(userId);
            var removing = products.FirstOrDefault(e => e.Id == id);
            if (removing == null)
                return NotFound();

            await _subscriptionsService.RemoveAsync(removing.Id);
            _logService.LogAllFormats("DELETE user product", new { userId, productId = removing.Id });
            return Ok();
        }
        catch (Exception e)
        {
            _logService.LogAllFormats("DELETE user product error", e.ToString());
            return Forbid();
        }
    }

    [Authorize]
    [HttpGet("user/qr")]
    public async Task<ActionResult> GetQr([FromBody] Dictionary<string, string> data)
    {
        if (!data.TryGetValue("id", out var id))
        {
            _logService.LogAllFormats("GET QR failed", "Missing id");
            return BadRequest();
        }

        try
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (userId == null)
                return Unauthorized();

            var subscription = await _subscriptionsService.GetByIdAsync(id);
            if (subscription == null)
                return NotFound();

            var qrText = $"SubscriptionId:{subscription.Id}; User:{userId}";

            Qr qr = new Qr { Data = qrText, ValidUntill = DateTime.Now.AddMinutes(15) };
            await _qrService.CreateAsync(qr);

            using var qrGenerator = new QRCodeGenerator();
            using var qrCodeData = qrGenerator.CreateQrCode(qrText, QRCodeGenerator.ECCLevel.Q);
            var qrCode = new PngByteQRCode(qrCodeData);
            byte[] qrBytes = qrCode.GetGraphic(20);

            _logService.LogAllFormats("GET QR", new { userId, subscriptionId = subscription.Id });
            return File(qrBytes, "image/png");
        }
        catch (Exception e)
        {
            _logService.LogAllFormats("GET QR error", e.ToString());
            return Forbid();
        }
    }
}
