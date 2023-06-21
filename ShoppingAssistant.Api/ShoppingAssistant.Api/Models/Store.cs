using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson;

namespace ShoppingAssistant.Api.Models
{
    public class Store
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string Id { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string Location { get; set; }
    }
}
