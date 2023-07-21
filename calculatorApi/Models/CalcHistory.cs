namespace calculatorApi.Models
{
    public class CalcHistory
    {
        public string userId { get; set; }
        public string username { get; set; }
        public required List<Calculation> Calculations { get; set; }
    }
}

