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
    private readonly LogService _logService;

    public AuthController(PersonService userService, IOptions<JwtSettings> jwtSettings, LogService logService)
    {
        _userService = userService;
        _jwtSettings = jwtSettings.Value;
        _logService = logService;
    }

    [HttpPost("register")]
    public async Task<IActionResult> Register([FromBody] Person user)
    {
        _logService.LogAllFormats("Register attempt", user);

        var existing = await _userService.GetByPhoneAsync(user.Phone);
        if (existing != null)
        {
            _logService.LogAllFormats("Register failed", $"User already exists: {user.Phone}");
            return BadRequest("User already exists");
        }

        await _userService.CreateAsync(user);
        var token = GenerateJwtToken(user);

        _logService.LogAllFormats("Register success", new { user.Id, user.Phone });

        return Ok(new { token });
    }

    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] Dictionary<string, string> data)
    {
        _logService.LogAllFormats("Login attempt", data);

        if (!data.TryGetValue("phone", out var phone) || !data.TryGetValue("password", out var pass))
        {
            _logService.LogAllFormats("Login failed", "Missing credentials");
            return BadRequest("Неверный формат данных");
        }

        var user = await _userService.GetByPhoneAsync(phone);
        if (user == null || (pass != user.Password))
        {
            _logService.LogAllFormats("Login failed", "Invalid credentials");
            return Unauthorized("Неверный логин или пароль");
        }

        var token = GenerateJwtToken(user);
        _logService.LogAllFormats("Login success", new { user.Id, user.Phone });

        return Ok(new { token });
    }

    [Authorize]
    [HttpGet("profile")]
    public async Task<IActionResult> GetProfile()
    {
        var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);

        if (userId == null)
        {
            _logService.LogAllFormats("Profile access denied", "Token missing or invalid");
            return Unauthorized("Токен некорректен или истек");
        }

        var user = await _userService.GetByIdAsync(userId);
        if (user == null)
        {
            _logService.LogAllFormats("Profile access failed", $"User not found: {userId}");
            return NotFound("Пользователь не найден");
        }

        var profile = new
        {
            user.Id,
            user.Name,
            user.Surname,
            user.Sex,
            user.Phone,
            user.BirthDate
        };

        _logService.LogAllFormats("Profile access success", profile);

        return Ok(profile);
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
