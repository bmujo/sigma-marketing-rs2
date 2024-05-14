using SigmaMarketing.Core.Entities;

namespace SigmaMarketing.Core.Data.MockData
{
    public class SigmaTokens
    {
        public List<SigmaToken> ListOfSigmaTokens { get; set; }

        public SigmaTokens()
        {
            ListOfSigmaTokens = new List<SigmaToken>()
            {
                new SigmaToken
                {
                    Id = -111001, Created = DateTime.Now, CreatedBy = "System", LastModified = DateTime.Now,
                    LastModifiedBy = "System", PackageName = "Sigma50", Amount = 50, Price = 50
                },
                new SigmaToken
                {
                    Id = -111002, Created = DateTime.Now, CreatedBy = "System", LastModified = DateTime.Now,
                    LastModifiedBy = "System", PackageName = "Sigma100", Amount = 100, Price = 100
                },
                new SigmaToken
                {
                    Id = -111003, Created = DateTime.Now, CreatedBy = "System", LastModified = DateTime.Now,
                    LastModifiedBy = "System", PackageName = "Sigma200", Amount = 200, Price = 200
                },
                new SigmaToken
                {
                    Id = -111004, Created = DateTime.Now, CreatedBy = "System", LastModified = DateTime.Now,
                    LastModifiedBy = "System", PackageName = "Sigma500", Amount = 500, Price = 500
                },
                new SigmaToken
                {
                    Id = -111005, Created = DateTime.Now, CreatedBy = "System", LastModified = DateTime.Now,
                    LastModifiedBy = "System", PackageName = "Sigma1000", Amount = 1000, Price = 1000
                },
                new SigmaToken
                {
                    Id = -111006, Created = DateTime.Now, CreatedBy = "System", LastModified = DateTime.Now,
                    LastModifiedBy = "System", PackageName = "Sigma5000", Amount = 5000, Price = 5000
                },
            };
        }
    }
}
