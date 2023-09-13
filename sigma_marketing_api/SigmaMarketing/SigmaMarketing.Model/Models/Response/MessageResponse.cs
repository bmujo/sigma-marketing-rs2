namespace SigmaMarketing.Model.Models.Response
{
    public class MessageResponse
    {
        public int Id { get; set; }
        public DateTime Created { get; set; }
        public string MessageText { get; set; }
        public int SenderId { get; set; }
        public int ReceiverId { get; set; }
        public int MessageOwnerId { get; set; }
        public bool IsRead { get; set; }
        public string SenderImage { get; set; }
        public string ReceiverImage { get; set; }
    }
}
