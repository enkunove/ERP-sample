using Microsoft.Extensions.Options;
using MongoDB.Driver;
using Server.Core;
using Server.Models;

namespace Server.Services
{
    public class QrService
    {
        private readonly IMongoCollection<Qr> _qr;

        public QrService(IOptions<ShopDatabaseSettings> shopDatabaseSettings)
        {
            var mongoClient = new MongoClient(shopDatabaseSettings.Value.ConnectionString);
            var mongoDatabase = mongoClient.GetDatabase(shopDatabaseSettings.Value.DatabaseName);
            _qr = mongoDatabase.GetCollection<Qr>("Qr");
        }

        public async Task<List<Qr>> GetAsync() =>
            await _qr.Find(_ => true).ToListAsync();

        public async Task<Qr?> GetByDataAsync(string data)
        {
            Console.WriteLine("LOOKING FOR QR");
            var allQrs = await _qr.Find(_ => true).ToListAsync();
            Console.WriteLine("All stored QRs:");
            foreach (var q in allQrs)
            {
                Console.WriteLine($"-> {q.Data}");
            }

            return await _qr.Find(p => p.Data == data).FirstOrDefaultAsync();
        }
 

        public async Task CreateAsync(Qr qr) =>
            await _qr.InsertOneAsync(qr);

        public async Task RemoveAsync(string data) =>
            await _qr.DeleteOneAsync(p => p.Data == data);
    }
}
