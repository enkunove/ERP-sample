using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Server.Core;
using Server.Models;
using Server.Services;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace Server.Controllers;

[ApiController]
[Route("api/[controller]")]
public class AuthController : ControllerBase
{
    private readonly PersonService _userService;
    private readonly JwtSettings _jwtSettings;

    public AuthController(PersonService userService, IOptions<JwtSettings> jwtSettings)
    {
        _userService = userService;
        _jwtSettings = jwtSettings.Value;
    }

    [HttpPost("register")]
    public async Task<IActionResult> Register([FromBody] Person user)
    {
        Console.WriteLine($"INCOMING: {System.Text.Json.JsonSerializer.Serialize(user)}");
        var existing = await _userService.GetByPhoneAsync(user.Phone);
        if (existing != null)
            return BadRequest("Пользователь с таким логином уже существует");

        await _userService.CreateAsync(user);

        var token = GenerateJwtToken(user);

        return Ok(new { token });
    }
    [Authorize]
    [HttpGet("profile")]
    public async Task<IActionResult> GetProfile()
    {

        var userId = User.FindFirstValue(System.Security.Claims.ClaimTypes.NameIdentifier);

        if (userId == null)
        {
            return Unauthorized("Токен некорректен или истек");
        }

        var user = await _userService.GetByIdAsync(userId);
        if (user == null)
        {
            return NotFound("Пользователь не найден");
        }

        return Ok(new
        {
            user.Id,
            user.Name,
            user.Surname,
            user.Sex,
            user.Phone,
            user.BirthDate
        });
    }




    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] Dictionary<string, string> data)
    {
        if (!data.TryGetValue("phone", out var phone) || !data.TryGetValue("password", out var pass))
            return BadRequest("Неверный формат данных");

        var user = await _userService.GetByPhoneAsync(phone);
        if (user == null || (pass != user.Password))
            return Unauthorized("Неверный логин или пароль");

        var token = GenerateJwtToken(user);
        return Ok(new { token });
    }


    private string GenerateJwtToken(Person user)
    {
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_jwtSettings.SecretKey));
        var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

        var claims = new[]
        {
            new Claim(JwtRegisteredClaimNames.Sub, user.Id),
            new Claim("Phone", user.Phone),
        };

        var token = new JwtSecurityToken(
            issuer: _jwtSettings.Issuer,
            audience: _jwtSettings.Audience,
            claims: claims,
            expires: DateTime.UtcNow.AddMinutes(_jwtSettings.ExpiryMinutes),
            signingCredentials: creds);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}
