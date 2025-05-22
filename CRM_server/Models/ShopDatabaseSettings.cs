namespace Server.Models;

public class ShopDatabaseSettings
{
    public string ConnectionString { get; set; } = null!;
    public string DatabaseName { get; set; } = null!;
    public string ProductsCollectionName { get; set; } = null!;
}
