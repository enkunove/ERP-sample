using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Server.Models
{
    public class Person
    {

        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string? Id { get; set; }

        [BsonElement("name")]
        [BsonRequired]
        public string Name { get; set; } = null!;
        [BsonElement("surname")]
        [BsonRequired]
        public string Surname { get; set; } = null!;

        [BsonElement("sex")]
        [BsonRequired]
        public bool Sex { get; set; }

        [BsonElement("phone")]
        [BsonRequired]
        public string Phone { get; set; } = null!;

        [BsonElement("birthDate")]
        [BsonRequired]
        public string BirthDate { get; set; }

        [BsonElement("password")]
        [BsonRequired]
        public string Password { get; set; } = null!;
    }
}
