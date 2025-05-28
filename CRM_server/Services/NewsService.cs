using Microsoft.Extensions.Options;
using MongoDB.Driver;
using Server.Core;
using Server.Models;

namespace Server.Services
{
    public class NewsService
    {
        private readonly IMongoCollection<News> _news;

        public NewsService(IOptions<ShopDatabaseSettings> shopDatabaseSettings)
        {
            var mongoClient = new MongoClient(shopDatabaseSettings.Value.ConnectionString);
            var mongoDatabase = mongoClient.GetDatabase(shopDatabaseSettings.Value.DatabaseName);
            _news = mongoDatabase.GetCollection<News>("News");
        }

        public async Task<List<News>> GetAsync() =>
            await _news.Find(_ => true).ToListAsync();

        public async Task<News?> GetByIdAsync(string id) =>
            await _news.Find(p => p.Id == id).FirstOrDefaultAsync();
        public async Task CreateAsync(News news) =>
            await _news.InsertOneAsync(news);

        public async Task UpdateAsync(string id, News updatedNews) =>
            await _news.ReplaceOneAsync(p => p.Id == id, updatedNews);

        public async Task RemoveAsync(string id) =>
            await _news.DeleteOneAsync(p => p.Id == id);
    }
}
