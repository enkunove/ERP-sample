using MongoDB.Driver;
using Server.Models;
using Microsoft.Extensions.Options;
using Server.Core;

namespace Server.Services;

public class ProductService
{
    private readonly IMongoCollection<Subscription> _products;

    public ProductService(IOptions<ShopDatabaseSettings> shopDatabaseSettings)
    {
        var mongoClient = new MongoClient(shopDatabaseSettings.Value.ConnectionString);
        var mongoDatabase = mongoClient.GetDatabase(shopDatabaseSettings.Value.DatabaseName);
        _products = mongoDatabase.GetCollection<Subscription>(shopDatabaseSettings.Value.ProductsCollectionName);
    }

    public async Task<List<Subscription>> GetAsync() =>
        await _products.Find(_ => true).ToListAsync();

    public async Task<Subscription?> GetByIdAsync(string id) =>
        await _products.Find(p => p.Id == id).FirstOrDefaultAsync();

    public async Task CreateAsync(Subscription product) =>
        await _products.InsertOneAsync(product);

    public async Task UpdateAsync(string id, Subscription updatedProduct) =>
        await _products.ReplaceOneAsync(p => p.Id == id, updatedProduct);

    public async Task RemoveAsync(string id) =>
        await _products.DeleteOneAsync(p => p.Id == id);
}
