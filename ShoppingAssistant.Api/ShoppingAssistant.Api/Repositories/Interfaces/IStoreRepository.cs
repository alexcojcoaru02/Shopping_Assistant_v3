using MongoDB.Bson;
using ShoppingAssistant.Api.Models;

namespace ShoppingAssistant.Api.Repositories.Interfaces
{
    public interface IStoreRepository
    {
        public Task AddStoreAsync(Store store);

        public Store GetStore(ObjectId id);

        public List<Store> GetStores();

        public List<Store> GetStoresByIds(List<ObjectId> ids);
    }
}
