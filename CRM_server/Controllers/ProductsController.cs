using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Server.Models;
using Server.Services;

namespace Server.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ProductsController : ControllerBase
{
    private readonly ProductService _productService;

    public ProductsController(ProductService productService) =>
        _productService = productService;

    //НУЖНА ЛИ ЭТА ХУЙНЯ
    //[Authorize]
    //[HttpGet("my")]
    //public async Task<ActionResult<List<Product>>> GetMyProducts()
    //{
    //    var login = User.FindFirst("login")?.Value;

    //    if (login == null)
    //        return Unauthorized();

    //    var products = await _productService.GetByOwnerAsync(login);
    //    return Ok(products);
    //}

    [HttpPost("{id}/upload")] //что-то понять не могу что тут делается некая параша
    public async Task<IActionResult> UploadImage(string id, IFormFile file)
    {
        if (file == null || file.Length == 0)
            return BadRequest("Файл не выбран");

        var product = await _productService.GetByIdAsync(id);
        if (product == null)
            return NotFound();

        var fileName = $"{Guid.NewGuid()}_{file.FileName}";
        var imagePath = Path.Combine("wwwroot", "images", fileName);

        // Сохраняем файл
        using (var stream = System.IO.File.Create(imagePath))
        {
            await file.CopyToAsync(stream);
        }

        // Обновляем товар
        product.ImageUrl = $"/images/{fileName}";
        await _productService.UpdateAsync(id, product);

        return Ok(new { imageUrl = product.ImageUrl });
    }

    [HttpGet]
    public async Task<List<Product>> Get() =>
        await _productService.GetAsync();

    [HttpGet("{id:length(24)}")]
    public async Task<ActionResult<Product>> GetById(string id)
    {
        var product = await _productService.GetByIdAsync(id);

        if (product is null)
            return NotFound();

        return product;
    }

    [HttpPost]
    public async Task<IActionResult> Post(Product newProduct)
    {
        await _productService.CreateAsync(newProduct);
        return CreatedAtAction(nameof(GetById), new { id = newProduct.Id }, newProduct);
    }

    [HttpPut("{id:length(24)}")]
    public async Task<IActionResult> Update(string id, Product updatedProduct)
    {
        var product = await _productService.GetByIdAsync(id);

        if (product is null)
            return NotFound();

        updatedProduct.Id = product.Id;

        await _productService.UpdateAsync(id, updatedProduct);

        return NoContent();
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
