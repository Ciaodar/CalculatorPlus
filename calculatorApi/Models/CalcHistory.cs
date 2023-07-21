using System.Text.Json.Serialization;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace calculatorApi.Models
{
    public class CalcHistory
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string? userId { get; set; }
        public string username { get; set; }
        [BsonElement("Calculations")]
        public required List<Calculation> Calculations { get; set; }
    }
}

