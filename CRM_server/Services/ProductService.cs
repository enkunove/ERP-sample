using MongoDB.Driver;
using Server.Models;
using Microsoft.Extensions.Options;

namespace Server.Services;

public class ProductService
{
    private readonly IMongoCollection<Product> _products;

    public ProductService(IOptions<ShopDatabaseSettings> shopDatabaseSettings)
    {
        var mongoClient = new MongoClient(shopDatabaseSettings.Value.ConnectionString);
        var mongoDatabase = mongoClient.GetDatabase(shopDatabaseSettings.Value.DatabaseName);
        _products = mongoDatabase.GetCollection<Product>(shopDatabaseSettings.Value.ProductsCollectionName);
    }

    public async Task<List<Product>> GetAsync() =>
        await _products.Find(_ => true).ToListAsync();

    public async Task<Product?> GetByIdAsync(string id) =>
        await _products.Find(p => p.Id == id).FirstOrDefaultAsync();

    public async Task CreateAsync(Product product) =>
        await _products.InsertOneAsync(product);

    public async Task UpdateAsync(string id, Product updatedProduct) =>
        await _products.ReplaceOneAsync(p => p.Id == id, updatedProduct);

    public async Task RemoveAsync(string id) =>
        await _products.DeleteOneAsync(p => p.Id == id);
}
