using calculatorApi.Models;
using MongoDB.Driver;
using MongoDB.Bson;
using Microsoft.Extensions.Options;

namespace calculatorApi.Services
{
    public class MongoDBService
    {
        private readonly IMongoCollection<CalcHistory> _calcHistoryCollection;

        public MongoDBService(IOptions<MongoDbSettings> mongoDbSettings) {
            MongoClient client = new MongoClient(mongoDbSettings.Value.ConnectionURI);
            IMongoDatabase database = client.GetDatabase(mongoDbSettings.Value.DatabaseName);
            _calcHistoryCollection = database.GetCollection<CalcHistory>(mongoDbSettings.Value.CollectionName);
        }

        public async Task<List<CalcHistory>> GetAsync() {//Get all data from MongoDB
            return await _calcHistoryCollection.Find(new BsonDocument()).ToListAsync();
        }

        public async Task CreateAsync(CalcHistory calcHistory) {
            string newId = calcHistory.Id == null ? ObjectId.GenerateNewId().ToString() : calcHistory.Id;

            await _calcHistoryCollection.UpdateOneAsync(Builders<CalcHistory>.Filter.Eq(_ => _.Id, newId),
                Builders<CalcHistory>.Update.SetOnInsert(_ => _.Id, newId).
                    Push("Calculations", calcHistory.calculations[0]),
                new UpdateOptions() { IsUpsert = true });
            return;
        }
    }
}

