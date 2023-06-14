using MongoDB.Bson;
using MongoDB.Driver;
using ShoppingAssistant.Api.Models;
using ShoppingAssistant.Api.Repositories.Interfaces;
using ShoppingAssistant.Api.Services.Interfaces;
using System;

namespace ShoppingAssistant.Api.Services
{
    public class ProductService : IProductService
    {
        private const string ConnectionString = "mongodb://alex-shoping-assitant:y8czsQg2fOQKUKwBzpDzQ2KKL7dlrDQtCMoNpBjQLiwkm4zVGSVrRv1ekdpf98YONtXgO3cL05ZkACDbAsP6TQ==@alex-shoping-assitant.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@alex-shoping-assitant@";
        private const string DBName = "SATest";
        private const string CollectionName = "products";
        private readonly IMongoCollection<Product> productsCollection;

        public readonly IProductRepository _productRepository;

        public MongoClient MongoClient;

        public ProductService(IProductRepository productRepository)
        {
            productsCollection = new MongoClient(ConnectionString).GetDatabase(DBName).GetCollection<Product>(CollectionName);
            productRepository = _productRepository;
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

        public List<double> GetProductPriceHistory(ObjectId id)
        {
            var priceHistories = _productRepository.GetAllProducts().SelectMany(x => x.PriceHistory);

            var oneYearAgo = DateTime.Now.AddYears(-1);

            var monthlyPrices = priceHistories
                .Where(ph => ph.DateTime > oneYearAgo)
                .GroupBy(ph => new { ph.DateTime.Year, ph.DateTime.Month, ph.StoreId })
                .Select(g => new { Month = new DateTime(g.Key.Year, g.Key.Month, 1), StoreId = g.Key.StoreId, AvgPrice = g.Average(ph => ph.Price) })
                .ToList();

            var result = monthlyPrices
                .GroupBy(mp => mp.Month)
                .Select(g => g.Average(mp => mp.AvgPrice))
                .ToList();


            return result;
        }

    }
}
