using MongoDB.Driver;
using ShoppingAssistant.Api.Models;

namespace ShoppingAssistant.Api.Services
{
    public class ProductService
    {
        private const string ConnectionString = "mongodb://localhost:27017";
        private const string DBName = "SATest";
        private const string CollectionName = "products";
        private IMongoCollection<Product> productsCollection;

        public MongoClient MongoClient;

        public ProductService()
        {
            var productsCollection = new MongoClient(ConnectionString).GetDatabase(DBName).GetCollection<Product>(CollectionName);
        }

        public async Task<List<Product>> GetAllProductsAsync()
            => (await productsCollection.FindAsync(_ => true)).ToList();

        public async Task AddProduct(Product product)
            => await productsCollection.InsertOneAsync(product);

        public Task<Product> GetProductAsync(string id)
            => productsCollection.Find(id).FirstAsync();

    }
}
