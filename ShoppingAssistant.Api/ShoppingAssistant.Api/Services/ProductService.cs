using MongoDB.Bson;
using MongoDB.Driver;
using ShoppingAssistant.Api.Models;

namespace ShoppingAssistant.Api.Services
{
    public class ProductService
    {
        private const string ConnectionString = "mongodb://alex-shoping-assitant:y8czsQg2fOQKUKwBzpDzQ2KKL7dlrDQtCMoNpBjQLiwkm4zVGSVrRv1ekdpf98YONtXgO3cL05ZkACDbAsP6TQ==@alex-shoping-assitant.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@alex-shoping-assitant@";
        private const string DBName = "SATest";
        private const string CollectionName = "products";
        private IMongoCollection<Product> productsCollection;

        public MongoClient MongoClient;

        public ProductService()
        {
            productsCollection = new MongoClient(ConnectionString).GetDatabase(DBName).GetCollection<Product>(CollectionName);
        }

        public async Task<List<Product>> GetAllProductsAsync()
            => (await productsCollection.FindAsync(_ => true)).ToList();

        public async Task AddProduct(Product product)
        {
            product.Id = ObjectId.GenerateNewId().ToString();

            await productsCollection.InsertOneAsync(product);
        }

        public Task<Product> GetProductAsync(ObjectId id)
            => productsCollection.Find(Builders<Product>.Filter.Eq("_id", id)).FirstAsync();

        public Task<Product> GetProductByBarcode(string barcode)
            => productsCollection.Find(Builders<Product>.Filter.Eq("Barcode", barcode)).FirstAsync();

    }
}
