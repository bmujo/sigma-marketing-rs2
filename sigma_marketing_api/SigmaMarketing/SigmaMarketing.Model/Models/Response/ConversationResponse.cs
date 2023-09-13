namespace SigmaMarketing.Model.Models.Response
{
    public class ConversationResponse
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string LastMessage { get; set; }
        public DateTime TimeOfLastMessage { get; set; }
        public string ImageOfSender { get; set; }
        public int SenderId { get; set; }
        public int NumberOfUnread { get; set; }
    }
}
