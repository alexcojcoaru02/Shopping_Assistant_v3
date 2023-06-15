using MongoDB.Bson;
using ShoppingAssistant.Api.Models;
using ShoppingAssistant.Api.Repositories.Interfaces;
using ShoppingAssistant.Api.Services.Interfaces;

namespace ShoppingAssistant.Api.Services
{
    public class StoreService : IStoreService
    {
        public readonly IStoreRepository _storeRepository;

        public StoreService(IStoreRepository storeRepository)
        {
            _storeRepository = storeRepository;
        }

        public async Task AddStoreAsync(Store store)
        {
            await _storeRepository.AddStoreAsync(store);
        }

        public IEnumerable<Store> GetAllStores()
        {
            return _storeRepository.GetStores();
        }

        public Store GetStore(ObjectId id)
        {
            return _storeRepository.GetStore(id);
        }
    }
}
