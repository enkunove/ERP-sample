namespace Server.Models
{
    public class Log
    {
        public string Event { get; set; }
        public object Data { get; set; }
        public string Type { get; set; }
        public DateTime Timestamp { get; set; } = DateTime.UtcNow;

    }
}
