using MongoDB.Bson;
using ShoppingAssistant.Api.Models;

namespace ShoppingAssistant.Api.Services.Interfaces
{
    public interface IProductService
    {
        public Task<List<Product>> GetAllProductsAsync();

        public Task AddProduct(Product product);

        public Task<Product> GetProductAsync(ObjectId id);

        public List<Product> GetProductsByHint(string hint);

        public Task<Product> GetProductByBarcode(string barcode);

        public List<double> GetProductPriceHistory(ObjectId id);

        public bool ProductExists(string productId);

        public void AddReview(string productId, Review review);
    }
}
