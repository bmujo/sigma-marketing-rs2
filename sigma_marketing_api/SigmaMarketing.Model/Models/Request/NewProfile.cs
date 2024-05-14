namespace SigmaMarketing.Model.Models.Request
{
    public class NewProfile
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Gender { get; set; }

        public DateTime BirthDate { get; set; }
        public string PhoneNumber { get; set; }
    }
}
