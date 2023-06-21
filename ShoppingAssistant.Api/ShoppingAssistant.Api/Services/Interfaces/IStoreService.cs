using MongoDB.Bson;
using ShoppingAssistant.Api.Models;

namespace ShoppingAssistant.Api.Services.Interfaces
{
    public interface IStoreService
    {
        public IEnumerable<Store> GetAllStores();

        public Store GetStore(ObjectId id);

        public Task AddStoreAsync(Store store);
    }
}
