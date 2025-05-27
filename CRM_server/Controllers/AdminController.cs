using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Server.Models;
using Server.Services;
using System.Collections.Generic;

namespace Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AdminController : ControllerBase
    {
        private readonly QrService _qrService;
        private readonly VisitsService _visitService;
        private readonly PersonService _personService;
        private readonly SubscriptionsService _subscriptionsService;

        public AdminController(QrService qrservice, VisitsService visitsService, PersonService personService, SubscriptionsService subscriptionsService)
        {
            _qrService = qrservice;
            _visitService = visitsService;
            _personService = personService;
            _subscriptionsService = subscriptionsService;
        }
        [HttpPost("scan")]
        public async Task<IActionResult> ScanQr([FromBody] Dictionary<string, object> data)
        {
            try
            {
                if (!data.TryGetValue("data", out var qrDataElement))
                    return BadRequest("No QR data provided.");

                var qrData = qrDataElement is System.Text.Json.JsonElement element
                    ? element.GetString()
                    : qrDataElement?.ToString();

                if (string.IsNullOrWhiteSpace(qrData))
                    return BadRequest("QR data is empty or invalid.");


                var qr = await _qrService.GetByDataAsync(qrData);

                if (qr != null)
                {
                    var attendance = await _parseQrToAttendance(qr);
                    await _visitService.CreateAsync(attendance);

                    var user = await _personService.GetByIdAsync(attendance.UserId);
                    var subscription = await _subscriptionsService.GetByIdAsync(attendance.SubscriptionId);

                    Dictionary<string, object> payload = new Dictionary<string, object>() 
                    {
                        { "name", user.Name},
                        { "surname", user.Surname},
                        { "title", subscription.Title},
                        { "startDate", subscription.StartDate},
                        { "expirationDate", subscription.ExpirationDate},

                    };
                    Console.WriteLine("---->qr scanned<----");
                    return Ok(new { payload });
                }

                return BadRequest();
            }
            catch (Exception e)
            {
                Console.WriteLine($"Error: {e}");
                return BadRequest();
            }
        }


        private async Task<Attendance> _parseQrToAttendance(Qr qr)
        {
            if (string.IsNullOrWhiteSpace(qr.Data)) return null;

            var parts = qr.Data.Split(';', StringSplitOptions.RemoveEmptyEntries);

            string? subscriptionId = null;
            string? userId = null;

            foreach (var part in parts)
            {
                var trimmed = part.Trim();
                if (trimmed.StartsWith("SubscriptionId:"))
                {
                    subscriptionId = trimmed.Replace("SubscriptionId:", "").Trim();
                }
                else if (trimmed.StartsWith("User:"))
                {
                    userId = trimmed.Replace("User:", "").Trim();
                }
            }

            if (string.IsNullOrEmpty(subscriptionId) || string.IsNullOrEmpty(userId))
                return null;

            var sub = await _subscriptionsService.GetByIdAsync(subscriptionId);

            return new Attendance
            {
                SubscriptionId = subscriptionId,
                UserId = userId,
                Title = sub.Title,
                Time = DateTime.UtcNow
            };
        }

    }
}
