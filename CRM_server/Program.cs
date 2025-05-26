using Microsoft.AspNetCore.Authentication.JwtBearer;
using Server.Core;
using Server.Services;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();

builder.Services.Configure<JwtSettings>(
    builder.Configuration.GetSection("JwtSettings"));

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        var jwtSettings = builder.Configuration.GetSection("JwtSettings").Get<JwtSettings>();
        var key = System.Text.Encoding.UTF8.GetBytes(jwtSettings.SecretKey);

        options.TokenValidationParameters = new Microsoft.IdentityModel.Tokens.TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = jwtSettings.Issuer,
            ValidAudience = jwtSettings.Audience,
            IssuerSigningKey = new Microsoft.IdentityModel.Tokens.SymmetricSecurityKey(key)
        };

        options.Events = new JwtBearerEvents
        {
            OnAuthenticationFailed = ctx =>
            {
                Console.WriteLine($"Authentication failed: {ctx.Exception.Message}");
                return Task.CompletedTask;
            },
            OnTokenValidated = ctx =>
            {
                Console.WriteLine("Token validated successfully");
                return Task.CompletedTask;
            },
            OnMessageReceived = ctx =>
            {
                Console.WriteLine($"Token received: {ctx.Token}");
                return Task.CompletedTask;
            }
        };
    });

builder.WebHost.ConfigureKestrel(serverOptions =>
{
    serverOptions.ListenAnyIP(5294);
});
builder.WebHost.UseUrls("http://0.0.0.0:5294");

builder.Services.Configure<ShopDatabaseSettings>(
    builder.Configuration.GetSection("ShopDatabase"));

builder.Services.AddSingleton<ProductService>();
builder.Services.AddSingleton<SubscriptionsService>();
builder.Services.AddSingleton<QrService>();

builder.Services.AddSingleton<PersonService>();

var app = builder.Build();

app.UseStaticFiles();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

app.Run();
