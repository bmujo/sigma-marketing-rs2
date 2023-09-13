using SigmaMarketing.Core.Entities;
using SigmaMarketing.Core.Helper.enums;

namespace SigmaMarketing.Core.Data.MockData
{
    public class Notifications
    {
        public List<Notification> ListOfNotifications { get; set; }

        public Notifications()
        {
            ListOfNotifications = new List<Notification>()
            {
                new Notification
                {
                    Id = -6000,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 1",
                    Message =
                        "Join our 'Protecting Wildlife' campaign and make a difference in the fight to save endangered species. Sign up now!",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6001,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 2",
                    Message =
                        "Get involved in our 'Ending Homelessness' campaign and help make a positive impact on people's lives. Donate or volunteer today!",
                    IsOpen = false,
                    Type = (int)NotificationType.Message,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6002,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 3",
                    Message =
                        "Promote mental well-being and support our 'Promoting Mental Health' campaign. Join us for a workshop or follow us on social media for tips and resources.",
                    IsOpen = false,
                    Type = (int)NotificationType.CampaignFinished,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6003,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 4",
                    Message =
                        "Celebrate the arts and join our 'Creating Art' campaign. Attend an event, support local artists, and unleash your creative side.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6004,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 5",
                    Message =
                        "Honor our veterans and support our 'Supporting Veterans' campaign. Learn about how you can help make a difference.",
                    IsOpen = true,
                    Type = (int)NotificationType.Payment,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6005,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 6",
                    Message =
                        "Preserve history and support our 'Preserving History' campaign. Donate to local historical sites and organizations, or volunteer your time.",
                    IsOpen = false,
                    Type = (int)NotificationType.Message,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6006,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 7",
                    Message =
                        "Embrace the future and support our 'Advancing Technology' campaign. Learn about the latest technologies and their potential impact on society.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6007,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 8",
                    Message =
                        "Help eliminate poverty and support our 'Eliminating Poverty' campaign. Learn about local poverty-reduction programs and how you can help.",
                    IsOpen = true,
                    Type = (int)NotificationType.CampaignFinished,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6008,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 9",
                    Message =
                        "Stand up for women's rights and support our 'Supporting Women' campaign. Donate or volunteer with organizations that empower women.",
                    IsOpen = false,
                    Type = (int)NotificationType.Payment,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6009,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 10",
                    Message =
                        "Invest in education and support our 'Advancing Education' campaign. Learn about programs and initiatives that promote access to quality education for all.",
                    IsOpen = true,
                    Type = (int)NotificationType.Payment,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6010,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 11",
                    Message =
                        "Don't miss out on our 'Protecting Wildlife' campaign! Sign up now and help save endangered species.",
                    IsOpen = true,
                    Type = (int)NotificationType.Message,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6011,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 12",
                    Message =
                        "Be a part of the solution and support our 'Ending Homelessness' campaign. Donate or volunteer to help end homelessness.",
                    IsOpen = true,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6012,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 13",
                    Message =
                        "Take care of your mental health and support our 'Promoting Mental Health' campaign. Follow us on social media for tips and resources.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6013,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 14",
                    Message =
                        "Get inspired and support our 'Creating Art' campaign. Attend an event, support local artists, and unleash your creative side.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6014,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 15",
                    Message =
                        "Say thank you to our veterans and support our 'Supporting Veterans' campaign. Learn about how you can help make a difference.",
                    IsOpen = false,
                    Type = (int)NotificationType.Payment,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6015,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 16",
                    Message =
                        "Preserve our heritage and support our 'Preserving History' campaign. Donate to local historical sites and organizations, or volunteer your time.",
                    IsOpen = true,
                    Type = (int)NotificationType.Message,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6016,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 17",
                    Message =
                        "Embrace innovation and support our 'Advancing Technology' campaign. Learn about the latest technologies and their potential impact on society.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6017,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 18",
                    Message =
                        "Make a difference and support our 'Eliminating Poverty' campaign. Learn about local poverty-reduction programs and how you can help.",
                    IsOpen = true,
                    Type = (int)NotificationType.CampaignFinished,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6018,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 19",
                    Message =
                        "Fight for equality and support our 'Supporting Women' campaign. Donate or volunteer with organizations that empower women.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6019,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 20",
                    Message =
                        "Invest in the future and support our 'Advancing Education' campaign. Learn about programs and initiatives that promote access to quality education for all.",
                    IsOpen = true,
                    Type = (int)NotificationType.Payment,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6020,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 21",
                    Message =
                        "Join the movement and support our 'Sustainable Living' campaign. Learn about ways to live a more eco-friendly lifestyle.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6021,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 22",
                    Message =
                        "Protect the oceans and support our 'Protecting Oceans' campaign. Sign up now to help reduce ocean pollution and conserve marine life.",
                    IsOpen = true,
                    Type = (int)NotificationType.Message,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6022,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 23",
                    Message =
                        "Help feed the hungry and support our 'Fighting Hunger' campaign. Donate or volunteer with local food banks and hunger-relief organizations",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6023,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 24",
                    Message =
                        "Advance medical research and support our 'Advancing Medicine' campaign. Learn about cutting-edge medical technologies and treatments.",
                    IsOpen = false,
                    Type = (int)NotificationType.Message,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6024,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 25",
                    Message =
                        "Celebrate diversity and support our 'Embracing Diversity' campaign. Attend cultural events, support local organizations, and learn about different cultures.",
                    IsOpen = false,
                    Type = (int)NotificationType.Payment,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6025,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 26",
                    Message =
                        "Protect animal rights and support our 'Animal Rights' campaign. Learn about animal welfare organizations and ways you can help.",
                    IsOpen = true,
                    Type = (int)NotificationType.Campaign,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6026,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 27",
                    Message =
                        "Join the fight against climate change and support our 'Combating Climate Change' campaign. Learn about ways to reduce your carbon footprint and support clean energy initiatives.",
                    IsOpen = false,
                    Type = (int)NotificationType.Payment,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6027,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 28",
                    Message =
                        "Support small businesses and join our 'Small Business Support' campaign. Shop local and support small businesses in your community.",
                    IsOpen = true,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6028,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 29",
                    Message =
                        "Take care of our planet and support our 'Saving the Planet' campaign. Learn about ways to reduce waste, conserve resources, and protect the environment.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6029,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 30",
                    Message =
                        "Improve public health and support our 'Improving Public Health' campaign. Learn about public health initiatives and how you can help.",
                    IsOpen = true,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6030,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 31",
                    Message =
                        "Protect endangered species and support our 'Saving Endangered Species' campaign. Learn about conservation efforts and ways to help protect wildlife.",
                    IsOpen = true,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6031,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 11",
                    Message =
                        "Don't miss out on our 'Protecting Wildlife' campaign! Sign up now and help save endangered species.",
                    IsOpen = false,
                    Type = (int)NotificationType.Message,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6032,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 12",
                    Message =
                        "Be a part of the solution and support our 'Ending Homelessness' campaign. Donate or volunteer to help end homelessness.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6033,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 13",
                    Message =
                        "Take care of your mental health and support our 'Promoting Mental Health' campaign. Follow us on social media for tips and resources.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6034,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 14",
                    Message =
                        "Get inspired and support our 'Creating Art' campaign. Attend an event, support local artists, and unleash your creative side.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6035,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 15",
                    Message =
                        "Say thank you to our veterans and support our 'Supporting Veterans' campaign. Learn about how you can help make a difference.",
                    IsOpen = false,
                    Type = (int)NotificationType.Payment,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6036,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 16",
                    Message =
                        "Preserve our heritage and support our 'Preserving History' campaign. Donate to local historical sites and organizations, or volunteer your time.",
                    IsOpen = true,
                    Type = (int)NotificationType.Message,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6037,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 17",
                    Message =
                        "Embrace innovation and support our 'Advancing Technology' campaign. Learn about the latest technologies and their potential impact on society.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6038,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 18",
                    Message =
                        "Make a difference and support our 'Eliminating Poverty' campaign. Learn about local poverty-reduction programs and how you can help.",
                    IsOpen = false,
                    Type = (int)NotificationType.CampaignFinished,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6039,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 19",
                    Message =
                        "Fight for equality and support our 'Supporting Women' campaign. Donate or volunteer with organizations that empower women.",
                    IsOpen = true,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6040,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 20",
                    Message =
                        "Invest in the future and support our 'Advancing Education' campaign. Learn about programs and initiatives that promote access to quality education for all.",
                    IsOpen = false,
                    Type = (int)NotificationType.Payment,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6041,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 21",
                    Message =
                        "Join the movement and support our 'Sustainable Living' campaign. Learn about ways to live a more eco-friendly lifestyle.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6042,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 22",
                    Message =
                        "Protect the oceans and support our 'Protecting Oceans' campaign. Sign up now to help reduce ocean pollution and conserve marine life.",
                    IsOpen = true,
                    Type = (int)NotificationType.Message,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6043,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 23",
                    Message =
                        "Help feed the hungry and support our 'Fighting Hunger' campaign. Donate or volunteer with local food banks and hunger-relief organizations",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6044,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 24",
                    Message =
                        "Advance medical research and support our 'Advancing Medicine' campaign. Learn about cutting-edge medical technologies and treatments.",
                    IsOpen = true,
                    Type = (int)NotificationType.Message,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6045,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 25",
                    Message =
                        "Celebrate diversity and support our 'Embracing Diversity' campaign. Attend cultural events, support local organizations, and learn about different cultures.",
                    IsOpen = false,
                    Type = (int)NotificationType.Payment,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6046,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 26",
                    Message =
                        "Protect animal rights and support our 'Animal Rights' campaign. Learn about animal welfare organizations and ways you can help.",
                    IsOpen = true,
                    Type = (int)NotificationType.Campaign,
                    UserId = -999
                },
                new Notification
                {
                    Id = -6047,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 27",
                    Message =
                        "Join the fight against climate change and support our 'Combating Climate Change' campaign. Learn about ways to reduce your carbon footprint and support clean energy initiatives.",
                    IsOpen = false,
                    Type = (int)NotificationType.Payment,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6048,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 28",
                    Message =
                        "Support small businesses and join our 'Small Business Support' campaign. Shop local and support small businesses in your community.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6049,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 29",
                    Message =
                        "Take care of our planet and support our 'Saving the Planet' campaign. Learn about ways to reduce waste, conserve resources, and protect the environment.",
                    IsOpen = true,
                    Type = (int)NotificationType.Campaign,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6050,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 30",
                    Message =
                        "Improve public health and support our 'Improving Public Health' campaign. Learn about public health initiatives and how you can help.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6051,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 31",
                    Message =
                        "Protect endangered species and support our 'Saving Endangered Species' campaign. Learn about conservation efforts and ways to help protect wildlife.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -777
                },


                // User -999
                new Notification
                {
                    Id = -6052,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 1",
                    Message =
                        "Join our 'Protecting Wildlife' campaign and make a difference in the fight to save endangered species. Sign up now!",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6053,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 2",
                    Message =
                        "Get involved in our 'Ending Homelessness' campaign and help make a positive impact on people's lives. Donate or volunteer today!",
                    IsOpen = false,
                    Type = (int)NotificationType.Message,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6054,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 3",
                    Message =
                        "Promote mental well-being and support our 'Promoting Mental Health' campaign. Join us for a workshop or follow us on social media for tips and resources.",
                    IsOpen = false,
                    Type = (int)NotificationType.CampaignFinished,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6055,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 4",
                    Message =
                        "Celebrate the arts and join our 'Creating Art' campaign. Attend an event, support local artists, and unleash your creative side.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6056,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 5",
                    Message =
                        "Honor our veterans and support our 'Supporting Veterans' campaign. Learn about how you can help make a difference.",
                    IsOpen = true,
                    Type = (int)NotificationType.Payment,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6057,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 6",
                    Message =
                        "Preserve history and support our 'Preserving History' campaign. Donate to local historical sites and organizations, or volunteer your time.",
                    IsOpen = false,
                    Type = (int)NotificationType.Message,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6058,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 7",
                    Message =
                        "Embrace the future and support our 'Advancing Technology' campaign. Learn about the latest technologies and their potential impact on society.",
                    IsOpen = false,
                    Type = (int)NotificationType.Campaign,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6059,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 8",
                    Message =
                        "Help eliminate poverty and support our 'Eliminating Poverty' campaign. Learn about local poverty-reduction programs and how you can help.",
                    IsOpen = true,
                    Type = (int)NotificationType.CampaignFinished,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6060,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 9",
                    Message =
                        "Stand up for women's rights and support our 'Supporting Women' campaign. Donate or volunteer with organizations that empower women.",
                    IsOpen = false,
                    Type = (int)NotificationType.Payment,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6061,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 10",
                    Message =
                        "Invest in education and support our 'Advancing Education' campaign. Learn about programs and initiatives that promote access to quality education for all.",
                    IsOpen = true,
                    Type = (int)NotificationType.Payment,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6062,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 11",
                    Message =
                        "Don't miss out on our 'Protecting Wildlife' campaign! Sign up now and help save endangered species.",
                    IsOpen = true,
                    Type = (int)NotificationType.Message,
                    UserId = -777
                },
                new Notification
                {
                    Id = -6063,
                    Created = GetRandomDate(DateTime.Today.AddDays(-10), DateTime.Today),
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Title = "Notification 12",
                    Message =
                        "Be a part of the solution and support our 'Ending Homelessness' campaign. Donate or volunteer to help end homelessness.",
                    IsOpen = true,
                    Type = (int)NotificationType.Campaign,
                    UserId = -777
                },
            };
        }

        static readonly Random rnd = new Random();

        public static DateTime GetRandomDate(DateTime from, DateTime to)
        {
            var range = to - from;

            var randTimeSpan = new TimeSpan((long)(rnd.NextDouble() * range.Ticks));

            return from + randTimeSpan;
        }
    }
}