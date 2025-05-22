using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Server.Models;

public class Product
{
    [BsonId]
    [BsonRepresentation(BsonType.ObjectId)]
    public string? Id { get; set; }

    [BsonElement("name")]
    [BsonRequired]
    public string Name { get; set; } = null!;

    [BsonElement("price")]
    [BsonRequired]
    public decimal Price { get; set; }

    [BsonElement("description")]
    public string? Description { get; set; }

    [BsonElement("imageUrl")]
    [BsonRequired]
    public string? ImageUrl { get; set; }  
}
