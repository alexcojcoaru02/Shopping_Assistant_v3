using MongoDB.Bson;
using MongoDB.Driver;
using ShoppingAssistant.Api.Models;
using ShoppingAssistant.Api.Repositories.Interfaces;

namespace ShoppingAssistant.Api.Repositories
{
    public class StoreRepository : IStoreRepository
    {
        private const string ConnectionString = "mongodb://alex-shoping-assitant:y8czsQg2fOQKUKwBzpDzQ2KKL7dlrDQtCMoNpBjQLiwkm4zVGSVrRv1ekdpf98YONtXgO3cL05ZkACDbAsP6TQ==@alex-shoping-assitant.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@alex-shoping-assitant@";
        private const string DBName = "SATest";
        private const string CollectionName = "stores";
        private IMongoCollection<Store> storesCollection;

        public MongoClient MongoClient;

        public StoreRepository()
        {
            storesCollection = new MongoClient(ConnectionString).GetDatabase(DBName).GetCollection<Store>(CollectionName);
        }
        public async Task AddStoreAsync(Store store)
        {
            store.Id = ObjectId.GenerateNewId().ToString();

            await storesCollection.InsertOneAsync(store);
        }

        public Store GetStore(ObjectId id)
            => storesCollection.Find(Builders<Store>.Filter.Eq("_id", id)).FirstOrDefault();

        public List<Store> GetStores()
        {
            return storesCollection.FindSync(_ => true).ToList();
        }

        public List<Store> GetStoresByIds(List<ObjectId> ids)
        {
            var stores = storesCollection.Find(Builders<Store>.Filter.In("_id", ids)).ToList();
            return stores;
        }
    }
}
