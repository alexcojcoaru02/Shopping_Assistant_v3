using MongoDB.Bson;
using ShoppingAssistant.Api.Models;

namespace ShoppingAssistant.Api.Services.Interfaces
{
    public interface IProductService
    {
        public Task<List<Product>> GetAllProductsAsync();

        public Task AddProduct(Product product);

        public Task<Product> GetProductAsync(ObjectId id);

        public Task<Product> GetProductByBarcode(string barcode);

        public List<double> GetProductPriceHistory(ObjectId id);
    }
}
