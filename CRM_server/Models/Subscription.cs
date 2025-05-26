using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Server.Models;

public class Subscription
{
    [BsonId]
    [BsonRepresentation(BsonType.ObjectId)]
    public string? Id { get; set; }

    [BsonElement("userId")]
    public string? UserId { get; set; }

    [BsonElement("title")]
    [BsonRequired]
    public string Title { get; set; } = null!;

    [BsonElement("price")]
    [BsonRequired]
    public decimal Price { get; set; }

    [BsonElement("description")]
    public string? Description { get; set; }

    [BsonElement("startDate")]
    [BsonRequired]
    public DateTime? StartDate { get; set; }


    [BsonElement("expirationDate")]
    [BsonRequired]
    public DateTime? ExpirationDate { get; set; }
}
