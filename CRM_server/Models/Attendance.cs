using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson;

namespace Server.Models
{
    public class Attendance
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string? Id { get; set; }

        [BsonElement("subscriptionId")]
        [BsonRequired]
        public string SubscriptionId { get; set; } = null!; 
        
        [BsonElement("userId")]
        [BsonRequired]
        public string UserId { get; set; } = null!;

        [BsonElement("time")]
        [BsonRequired]
        public DateTime Time { get; set; } = DateTime.Now!;
    }
}
