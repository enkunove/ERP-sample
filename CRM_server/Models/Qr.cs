using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Server.Models
{
    public class Qr
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string? Id { get; set; }

        [BsonElement("data")]
        [BsonRequired]
        public string Data { get; set; } = null!;

        [BsonElement("validUntill")]
        [BsonRequired]
        public DateTime ValidUntill { get; set; } = DateTime.Now!;
    }
}
