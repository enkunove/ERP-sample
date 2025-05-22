using Microsoft.Extensions.Options;
using MongoDB.Driver;
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

        public async Task<Person?> GetByLoginAsync(string login) =>
            await _persons.Find(x => x.Login == login).FirstOrDefaultAsync();

        public async Task Remove(string id)
        {
            await _persons.DeleteOneAsync(u => u.Id == id);
        }

        public async Task CreateAsync(Person user) =>
        await _persons.InsertOneAsync(user);
    }
}
