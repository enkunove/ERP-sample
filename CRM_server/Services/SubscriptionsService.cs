using Microsoft.Extensions.Options;
using MongoDB.Driver;
using Server.Core;
using Server.Models;

namespace Server.Services
{
    public class SubscriptionsService
    {
        private readonly IMongoCollection<Subscription> _subscriptions;

        public SubscriptionsService(IOptions<ShopDatabaseSettings> shopDatabaseSettings)
        {
            var mongoClient = new MongoClient(shopDatabaseSettings.Value.ConnectionString);
            var mongoDatabase = mongoClient.GetDatabase(shopDatabaseSettings.Value.DatabaseName);
            _subscriptions = mongoDatabase.GetCollection<Subscription>("Subscriptions");
        }

        public async Task<List<Subscription>> GetAsync() =>
            await _subscriptions.Find(_ => true).ToListAsync();

        public async Task<Subscription?> GetByIdAsync(string id) =>
            await _subscriptions.Find(p => p.Id == id).FirstOrDefaultAsync(); 
        public async Task<List<Subscription>?> GetByUserIdAsync(string id) =>
            await _subscriptions.Find(p => p.UserId == id).ToListAsync();

        public async Task CreateAsync(Subscription product) =>
            await _subscriptions.InsertOneAsync(product);

        public async Task UpdateAsync(string id, Subscription updatedProduct) =>
            await _subscriptions.ReplaceOneAsync(p => p.Id == id, updatedProduct);

        public async Task RemoveAsync(string id) =>
            await _subscriptions.DeleteOneAsync(p => p.Id == id);
    }
}
