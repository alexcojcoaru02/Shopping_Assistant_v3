using MongoDB.Bson;
using MongoDB.Driver;
using ShoppingAssistant.Api.Models;
using ShoppingAssistant.Api.Repositories.Interfaces;

namespace ShoppingAssistant.Api.Repositories
{
    public class ProductRepository : IProductRepository
    {
        private const string ConnectionString = "mongodb://alex-shoping-assitant:y8czsQg2fOQKUKwBzpDzQ2KKL7dlrDQtCMoNpBjQLiwkm4zVGSVrRv1ekdpf98YONtXgO3cL05ZkACDbAsP6TQ==@alex-shoping-assitant.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@alex-shoping-assitant@";
        private const string DBName = "SATest";
        private const string CollectionName = "products";
        private IMongoCollection<Product> productsCollection;

        public MongoClient MongoClient;

        public ProductRepository()
        {
            productsCollection = new MongoClient(ConnectionString).GetDatabase(DBName).GetCollection<Product>(CollectionName);
        }

        public List<Product> GetAllProducts()
            => productsCollection.FindSync(_ => true).ToList();

        public async Task AddProduct(Product product)
        {
            product.Id = ObjectId.GenerateNewId().ToString();

            await productsCollection.InsertOneAsync(product);
        }

        public List<Product> GetProductsByHint(string hint)
        {
            var regexPattern = new BsonRegularExpression(hint, "i");

            var filter = Builders<Product>.Filter.Regex("Name", regexPattern);

            return productsCollection.Find(filter).ToList();
        }

        public Product GetProduct(ObjectId id)
            => productsCollection.Find(Builders<Product>.Filter.Eq("_id", id)).FirstOrDefault();

        public Product GetProductByBarcode(string barcode)
            => productsCollection.Find(Builders<Product>.Filter.Eq("Barcode", barcode)).FirstOrDefault();

        public void UpdateProduct(Product product)
        {
            var filter = Builders<Product>.Filter.Eq(p => p.Id, product.Id);
            var update = Builders<Product>.Update
                .Set(p => p.Name, product.Name)
                .Set(p => p.Barcode, product.Barcode)
                .Set(p => p.Description, product.Description)
                .Set(p => p.Category, product.Category)
                .Set(p => p.ImageUrl, product.ImageUrl)
                .Set(p => p.PriceHistory, product.PriceHistory)
                .Set(p => p.Reviews, product.Reviews);

            productsCollection.UpdateOne(filter, update);
        }
        public bool ProductExists(string productId)
        {
            var filter = Builders<Product>.Filter.Eq(p => p.Id, productId);
            var product = productsCollection.Find(filter).FirstOrDefault();

            return product != null;
        }

        public void AddReview(string productId, Review review)
        {
            var filter = Builders<Product>.Filter.Eq(p => p.Id, productId);
            var update = Builders<Product>.Update.Push(p => p.Reviews, review);

            productsCollection.UpdateOne(filter, update);
        }
    }
}
