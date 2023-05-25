using MongoDB.Driver;
using ShoppingAssistant.Core.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace ShoppingAssistant.Core.Services
{
    public class ProductService
    {
        private const string ConnectionString = "mongodb://localhost:27017";
        private const string DBName = "SATest";
        private const string CollectionName = "products";
        private readonly IMongoCollection<Product> productsCollection;

        public MongoClient MongoClient;

        public ProductService()
        {
            var client = new MongoClient(ConnectionString);
            var database = client.GetDatabase(DBName);
            productsCollection = database.GetCollection<Product>(CollectionName);
        }

        public async Task<List<Product>> GetAllProductsAsync()
            => (await productsCollection.FindAsync(_ => true)).ToList();

        public async Task AddProduct(Product product)
            => await productsCollection.InsertOneAsync(product);

        public Task<Product> GetProductAsync(string id)
            => productsCollection.Find(id).FirstAsync();

    }
}
