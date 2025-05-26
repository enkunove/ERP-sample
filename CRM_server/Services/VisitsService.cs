using Microsoft.Extensions.Options;
using MongoDB.Driver;
using Server.Core;
using Server.Models;

namespace Server.Services
{
    public class VisitsService
    {
        private readonly IMongoCollection<Attendance> _visits;

        public VisitsService(IOptions<ShopDatabaseSettings> shopDatabaseSettings)
        {
            var mongoClient = new MongoClient(shopDatabaseSettings.Value.ConnectionString);
            var mongoDatabase = mongoClient.GetDatabase(shopDatabaseSettings.Value.DatabaseName);
            _visits = mongoDatabase.GetCollection<Attendance>("Visits");
        }

        public async Task<List<Attendance>> GetAsync() =>
            await _visits.Find(_ => true).ToListAsync();

        public async Task<Attendance?> GetByIdAsync(string id) =>
            await _visits.Find(p => p.Id == id).FirstOrDefaultAsync();

        public async Task CreateAsync(Attendance attendance) =>
            await _visits.InsertOneAsync(attendance);


        public async Task RemoveAsync(string id) =>
            await _visits.DeleteOneAsync(p => p.Id == id);
    }
}
