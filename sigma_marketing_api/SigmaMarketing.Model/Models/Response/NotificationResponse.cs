namespace SigmaMarketing.Model.Models.Response
{
    public class NotificationResponse
    {
        public int Id { get; set; }
        public DateTime Created { get; set; }
        public string Title { get; set; }
        public string Message { get; set; }
        public bool IsOpen { get; set; }
        public int Type { get; set; }
    }
}