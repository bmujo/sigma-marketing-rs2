using SigmaMarketing.Core.Entities;

namespace SigmaMarketing.Core.Data.MockData
{
    public class AchievementTypes
    {
        public List<AchievementType> ListOfAchievementTypes { get; set; }

        public AchievementTypes()
        {
            ListOfAchievementTypes = new List<AchievementType>
            {
                new AchievementType()
                {
                    Id = -9895214,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "Achievement Type 1",
                    Explanation = "Achievement Type 1 Explanation",
                    Value = 100,
                    Type = 1,
                    ImageUrl = "/images/AchievementType/a_1.png"
                },
                new AchievementType()
                {
                    Id = -9895215,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "Achievement Type 2",
                    Explanation = "Achievement Type 2 Explanation",
                    Value = 200,
                    Type = 2,
                    ImageUrl = "/images/AchievementType/a_2.png"
                },
                new AchievementType()
                {
                    Id = -9895216,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "Achievement Type 3",
                    Explanation = "Achievement Type 3 Explanation",
                    Value = 300,
                    Type = 3,
                    ImageUrl = "/images/AchievementType/a_3.png"
                },
                new AchievementType()
                {
                    Id = -9895217,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "Achievement Type 4",
                    Explanation = "Achievement Type 4 Explanation",
                    Value = 400,
                    Type = 4,
                    ImageUrl = "/images/AchievementType/a_4.png"
                },
                new AchievementType()
                {
                    Id = -9895218,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "Achievement Type 5",
                    Explanation = "Achievement Type 5 Explanation",
                    Value = 500,
                    Type = 5,
                    ImageUrl = "/images/AchievementType/a_5.png"
                },
                new AchievementType()
                {
                    Id = -9895219,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "Achievement Type 6",
                    Explanation = "Achievement Type 6 Explanation",
                    Value = 600,
                    Type = 6,
                    ImageUrl = "/images/AchievementType/a_6.png"
                },
            };
        }
    }
}
