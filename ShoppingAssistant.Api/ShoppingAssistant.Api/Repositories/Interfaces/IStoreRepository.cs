using ShoppingAssistant.Api.Models;

namespace ShoppingAssistant.Api.Repositories.Interfaces
{
    public interface IStoreRepository
    {
        public Task AddStoreAsync(Store store);

        public Store GetStore(Object id);

        public List<Store> GetStores();
    }
}
