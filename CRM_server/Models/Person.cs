using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Server.Models
{
    public class Person
    {

        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string? Id { get; set; }

        [BsonElement("login")]
        [BsonRequired]
        public string Login { get; set; } = null!;

        [BsonElement("password")]
        [BsonRequired]
        public string Password { get; set; } = null!;
    }
}
