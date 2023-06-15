using MongoDB.Bson;
using ShoppingAssistant.Api.Models;

namespace ShoppingAssistant.Api.Repositories.Interfaces
{
    public interface IProductRepository
    {
        public List<Product> GetAllProducts();

        public Task AddProduct(Product product);

        public Product GetProduct(ObjectId id);

        public List<Product> GetProductsByHint(string hint);

        public Product GetProductByBarcode(string barcode);
    }
}
