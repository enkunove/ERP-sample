using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http.HttpResults;
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

    public ProductsController(ProductService productService, SubscriptionsService subscriptionsService, QrService qrService)
    {
        _productService = productService;
        _subscriptionsService = subscriptionsService;
        _qrService = qrService;
    }


    [HttpGet]
    public async Task<List<Subscription>> Get() =>
        await _productService.GetAsync();

    [Authorize]
    [HttpPost("buy/{id:length(24)}")]
    public async Task<ActionResult<Subscription>> BuyById(string id)
    {
        var product = await _productService.GetByIdAsync(id);

        if (product is null)
            return NotFound();

        try
        {
            var userId = User.FindFirstValue(System.Security.Claims.ClaimTypes.NameIdentifier);

            if (userId == null)
            {
                return Unauthorized();
            }
            product.UserId = userId;
            DateTime now = DateTime.Now;
            TimeSpan? duration = product.ExpirationDate - product.StartDate;
            product.StartDate = now;
            product.ExpirationDate = now.Add(duration ?? TimeSpan.Zero);
            await _subscriptionsService.CreateAsync(product);

            return Ok();
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            return Forbid();
        }
    }

    [Authorize]
    [HttpGet("user")]
    public async Task<ActionResult<List<Subscription>>> GetUserProducts()
    {

        try
        {
            var userId = User.FindFirstValue(System.Security.Claims.ClaimTypes.NameIdentifier);
            if (userId == null)
            {
                return Unauthorized();
            }
            var products = await _subscriptionsService.GetByUserIdAsync(userId);

            if (products is null)
                return NotFound();
            Console.WriteLine(products);
            return Ok(new { products});
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            return Forbid();
        }
    }

    [Authorize]
    [HttpGet("user/qr")]
    public async Task<ActionResult> GetQr([FromBody] Dictionary<string, string> data)
    {
        if (!data.TryGetValue("id", out var id))
            return BadRequest();
        try
        {
            var userId = User.FindFirstValue(System.Security.Claims.ClaimTypes.NameIdentifier);
            if (userId == null)
            {
                return Unauthorized();
            }

            var subscription = await _subscriptionsService.GetByIdAsync(id);

            if (subscription == null)
                return NotFound();

            var qrText = $"SubscriptionId:{subscription.Id}; User:{userId}";

            Qr qr = new Qr { Data = qrText, ValidUntill = DateTime.Now.AddMinutes(15) };
            await _qrService.CreateAsync(qr);

            using (var qrGenerator = new QRCodeGenerator())
            using (var qrCodeData = qrGenerator.CreateQrCode(qrText, QRCodeGenerator.ECCLevel.Q))
            {
                var qrCode = new PngByteQRCode(qrCodeData);
                byte[] qrBytes = qrCode.GetGraphic(20); 

                return File(qrBytes, "image/png");
            }
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            return Forbid();
        }
    }

    [HttpGet("{id:length(24)}")]
    public async Task<ActionResult<Subscription>> GetById(string id)
    {
        var product = await _productService.GetByIdAsync(id);

        if (product is null)
            return NotFound();

        return product;
    }

    [HttpDelete("{id:length(24)}")]
    public async Task<IActionResult> Delete(string id)
    {
        var product = await _productService.GetByIdAsync(id);

        if (product is null)
            return NotFound();

        await _productService.RemoveAsync(id);

        return NoContent();
    }
}
