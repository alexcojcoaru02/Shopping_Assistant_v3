using MongoDB.Bson;
using ShoppingAssistant.Api.Models;

namespace ShoppingAssistant.Api.Repositories.Interfaces
{
    public interface IProductRepository
    {
        public List<Product> GetAllProductsAsync();

        public Task AddProduct(Product product);

        public Product GetProduct(ObjectId id);

        public Product GetProductByBarcode(string barcode);
    }
}
