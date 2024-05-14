using SigmaMarketing.Core.Entities;

namespace SigmaMarketing.Core.Data.MockData
{
    public class PaymentTerms
    {
        public List<PaymentTerm> ListOfPaymentTerms { get; set; }

        public PaymentTerms()
        {
            ListOfPaymentTerms = new List<PaymentTerm>();
            int idCounter = -33050;
            Random random = new Random();

            for (int i = 1; i <= 10; i++)
            {
                ListOfPaymentTerms.Add(new PaymentTerm
                {
                    CreatedBy = "System",
                    LastModifiedBy = "System",
                    Created = DateTime.Now,
                    LastModified = DateTime.Now,
                    Id = idCounter,
                    Description = $"Achievement Point {idCounter}",
                    Name = $"Achievement Point {idCounter}",
                });
                idCounter++;
            }
        }
    }
}
