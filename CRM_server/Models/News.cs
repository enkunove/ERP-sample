using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson;

namespace Server.Models
{
    public class News
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string? Id { get; set; }

        [BsonElement("title")]
        [BsonRequired]
        public string Title { get; set; } = null!;

        [BsonElement("payload")]
        [BsonRequired]
        public string Payload { get; set; } = null!;

        [BsonElement("datePublished")]
        [BsonRequired]
        public DateTime DatePublished { get; set; }
    }
}
