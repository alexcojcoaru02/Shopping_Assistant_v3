using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson;

namespace ShoppingAssistant.Api.Models
{
    public class Product
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string Id { get; set; }

        public string Name { get; set; }

        public string Barcode { get; set; }

        public string Description { get; set; }

        public ProductCategory Category { get; set; }

        public string ImageUrl { get; set; }

        public List<PriceHistory> PriceHistory { get; set; }
    }

    public class PriceHistory
    {
        public double Price { get; set; }
        public string StoreId { get; set; }
        public DateTime DateTime { get; set; }
    }

    public enum ProductCategory
    {
        Electronics,
        Clothing,
        Beauty,
        Food,
        Home,
        Sports
    }
}
