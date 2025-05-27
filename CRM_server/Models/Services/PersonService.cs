using Microsoft.Extensions.Options;
using MongoDB.Driver;
using Server.Core;
using Server.Models;

namespace Server.Services
{
    public class PersonService
    {
        private readonly IMongoCollection<Person> _persons;

        public PersonService(IOptions<ShopDatabaseSettings> shopDatabaseSettings)
        {
            var mongoClient = new MongoClient(shopDatabaseSettings.Value.ConnectionString);
            var mongoDatabase = mongoClient.GetDatabase(shopDatabaseSettings.Value.DatabaseName);
            _persons = mongoDatabase.GetCollection<Person>("Persons");
        }

        public async Task<Person?> GetByPhoneAsync(string phone) =>
            await _persons.Find(x => x.Phone == phone).FirstOrDefaultAsync(); 
        public async Task<Person?> GetByIdAsync(string id) =>
            await _persons.Find(x => x.Id == id).FirstOrDefaultAsync();

        public async Task Remove(string id)
        {
            await _persons.DeleteOneAsync(u => u.Id == id);
        }

        public async Task CreateAsync(Person user) =>
        await _persons.InsertOneAsync(user);
    }
}
