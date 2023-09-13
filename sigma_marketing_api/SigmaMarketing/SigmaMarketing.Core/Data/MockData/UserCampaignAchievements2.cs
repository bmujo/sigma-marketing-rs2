using SigmaMarketing.Core.Entities;
using SigmaMarketing.Core.Helper.enums;

namespace SigmaMarketing.Core.Data.MockData
{
    public class UserCampaignAchievements2
    {
        public List<UserCampaignAchievementPoint> ListOfUserCampaignAchievementPoints { get; set; }

        public UserCampaignAchievements2()
        {
            ListOfUserCampaignAchievementPoints = new List<UserCampaignAchievementPoint>();

            // ###################################################
            // ###### CampaignId -29 InfluencerId -999 ##########
            // ###################################################
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12400,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7122,
                CampaignId = -29,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12401,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7123,
                CampaignId = -29,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12402,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7124,
                CampaignId = -29,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12403,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7125,
                CampaignId = -29,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12404,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7126,
                CampaignId = -29,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            var counter29 = -12405;
            for (int influencerId = -2499; influencerId <= -2493; influencerId++)
            {
                for (int achievementPointId = -7122; achievementPointId >= -7126; achievementPointId--)
                {
                    var userCampaignAchievementPoint = new UserCampaignAchievementPoint
                    {
                        Id = counter29,
                        Created = DateTime.Now,
                        CreatedBy = "System",
                        LastModified = DateTime.Now,
                        LastModifiedBy = "System",
                        AchievementPointId = achievementPointId,
                        CampaignId = -29,
                        UserId = influencerId,
                        Status = AchievementStatus.Done.Value,
                    };
                    counter29--;

                    ListOfUserCampaignAchievementPoints.Add(userCampaignAchievementPoint);
                }
            }

            // ###################################################
            // ###### CampaignId -30 InfluencerId -999 ##########
            // ###################################################
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12440,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7127,
                CampaignId = -30,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12441,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7128,
                CampaignId = -30,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12442,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7129,
                CampaignId = -30,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12443,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7130,
                CampaignId = -30,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12444,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7131,
                CampaignId = -30,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            var counter30 = -12445;
            for (int influencerId = -2499; influencerId <= -2493; influencerId++)
            {
                for (int achievementPointId = -7127; achievementPointId >= -7131; achievementPointId--)
                {
                    var userCampaignAchievementPoint = new UserCampaignAchievementPoint
                    {
                        Id = counter30,
                        Created = DateTime.Now,
                        CreatedBy = "System",
                        LastModified = DateTime.Now,
                        LastModifiedBy = "System",
                        AchievementPointId = achievementPointId,
                        CampaignId = -30,
                        UserId = influencerId,
                        Status = AchievementStatus.Done.Value,
                    };
                    counter30--;

                    ListOfUserCampaignAchievementPoints.Add(userCampaignAchievementPoint);
                }
            }

            // ###################################################
            // ###### CampaignId -31 InfluencerId -999 ##########
            // ###################################################
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12480,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7132,
                CampaignId = -31,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12481,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7133,
                CampaignId = -31,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12482,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7134,
                CampaignId = -31,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12483,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7135,
                CampaignId = -31,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12484,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7136,
                CampaignId = -31,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            var counter31 = -12485;
            for (int influencerId = -2499; influencerId <= -2493; influencerId++)
            {
                for (int achievementPointId = -7132; achievementPointId >= -7136; achievementPointId--)
                {
                    var userCampaignAchievementPoint = new UserCampaignAchievementPoint
                    {
                        Id = counter31,
                        Created = DateTime.Now,
                        CreatedBy = "System",
                        LastModified = DateTime.Now,
                        LastModifiedBy = "System",
                        AchievementPointId = achievementPointId,
                        CampaignId = -31,
                        UserId = influencerId,
                        Status = AchievementStatus.Done.Value,
                    };
                    counter31--;

                    ListOfUserCampaignAchievementPoints.Add(userCampaignAchievementPoint);
                }
            }

            // ###################################################
            // ###### CampaignId -32 InfluencerId -999 ##########
            // ###################################################
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12535,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7137,
                CampaignId = -32,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12536,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7138,
                CampaignId = -32,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12537,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7139,
                CampaignId = -32,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12538,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7140,
                CampaignId = -32,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12539,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7141,
                CampaignId = -32,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            var counter32 = -12540;
            for (int influencerId = -2499; influencerId <= -2493; influencerId++)
            {
                for (int achievementPointId = -7137; achievementPointId >= -7141; achievementPointId--)
                {
                    var userCampaignAchievementPoint = new UserCampaignAchievementPoint
                    {
                        Id = counter32,
                        Created = DateTime.Now,
                        CreatedBy = "System",
                        LastModified = DateTime.Now,
                        LastModifiedBy = "System",
                        AchievementPointId = achievementPointId,
                        CampaignId = -32,
                        UserId = influencerId,
                        Status = AchievementStatus.Done.Value,
                    };
                    counter32--;

                    ListOfUserCampaignAchievementPoints.Add(userCampaignAchievementPoint);
                }
            }

            // ###################################################
            // ###### CampaignId -33 InfluencerId -999 ##########
            // ###################################################
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12575,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7142,
                CampaignId = -33,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12576,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7143,
                CampaignId = -33,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12577,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7144,
                CampaignId = -33,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12578,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7145,
                CampaignId = -33,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12579,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7146,
                CampaignId = -33,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            var counter33 = -12580;
            for (int influencerId = -2499; influencerId <= -2493; influencerId++)
            {
                for (int achievementPointId = -7142; achievementPointId >= -7146; achievementPointId--)
                {
                    var userCampaignAchievementPoint = new UserCampaignAchievementPoint
                    {
                        Id = counter33,
                        Created = DateTime.Now,
                        CreatedBy = "System",
                        LastModified = DateTime.Now,
                        LastModifiedBy = "System",
                        AchievementPointId = achievementPointId,
                        CampaignId = -33,
                        UserId = influencerId,
                        Status = AchievementStatus.Done.Value,
                    };
                    counter33--;

                    ListOfUserCampaignAchievementPoints.Add(userCampaignAchievementPoint);
                }
            }

            // ###################################################
            // ###### CampaignId -34 InfluencerId -999 ##########
            // ###################################################
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12615,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7147,
                CampaignId = -34,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12616,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7148,
                CampaignId = -34,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12617,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7149,
                CampaignId = -34,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12618,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7150,
                CampaignId = -34,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12619,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7151,
                CampaignId = -34,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            var counter34 = -12620;
            for (int influencerId = -2499; influencerId <= -2493; influencerId++)
            {
                for (int achievementPointId = -7147; achievementPointId >= -7151; achievementPointId--)
                {
                    var userCampaignAchievementPoint = new UserCampaignAchievementPoint
                    {
                        Id = counter34,
                        Created = DateTime.Now,
                        CreatedBy = "System",
                        LastModified = DateTime.Now,
                        LastModifiedBy = "System",
                        AchievementPointId = achievementPointId,
                        CampaignId = -34,
                        UserId = influencerId,
                        Status = AchievementStatus.Done.Value,
                    };
                    counter34--;

                    ListOfUserCampaignAchievementPoints.Add(userCampaignAchievementPoint);
                }
            }

            // ###################################################
            // ###### CampaignId -35 InfluencerId -999 ##########
            // ###################################################
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12655,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7152,
                CampaignId = -35,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12656,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7153,
                CampaignId = -35,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12657,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7154,
                CampaignId = -35,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12658,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7155,
                CampaignId = -35,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12659,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7156,
                CampaignId = -35,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            var counter35 = -12660;
            for (int influencerId = -2499; influencerId <= -2493; influencerId++)
            {
                for (int achievementPointId = -7152; achievementPointId >= -7156; achievementPointId--)
                {
                    var userCampaignAchievementPoint = new UserCampaignAchievementPoint
                    {
                        Id = counter35,
                        Created = DateTime.Now,
                        CreatedBy = "System",
                        LastModified = DateTime.Now,
                        LastModifiedBy = "System",
                        AchievementPointId = achievementPointId,
                        CampaignId = -35,
                        UserId = influencerId,
                        Status = AchievementStatus.Done.Value,
                    };
                    counter35--;

                    ListOfUserCampaignAchievementPoints.Add(userCampaignAchievementPoint);
                }
            }

            // ###################################################
            // ###### CampaignId -36 InfluencerId -999 ##########
            // ###################################################
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12695,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7157,
                CampaignId = -36,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12696,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7158,
                CampaignId = -36,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12697,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7159,
                CampaignId = -36,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12698,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7160,
                CampaignId = -36,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12699,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7161,
                CampaignId = -36,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            var counter36 = -12700;
            for (int influencerId = -2499; influencerId <= -2493; influencerId++)
            {
                for (int achievementPointId = -7157; achievementPointId >= -7161; achievementPointId--)
                {
                    var userCampaignAchievementPoint = new UserCampaignAchievementPoint
                    {
                        Id = counter36,
                        Created = DateTime.Now,
                        CreatedBy = "System",
                        LastModified = DateTime.Now,
                        LastModifiedBy = "System",
                        AchievementPointId = achievementPointId,
                        CampaignId = -36,
                        UserId = influencerId,
                        Status = AchievementStatus.Done.Value,
                    };
                    counter36--;

                    ListOfUserCampaignAchievementPoints.Add(userCampaignAchievementPoint);
                }
            }

            // ###################################################
            // ###### CampaignId -37 InfluencerId -999 ##########
            // ###################################################
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12735,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7162,
                CampaignId = -37,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12736,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7163,
                CampaignId = -37,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12737,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7164,
                CampaignId = -37,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12738,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7165,
                CampaignId = -37,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12739,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7166,
                CampaignId = -37,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            var counter37 = -12740;
            for (int influencerId = -2499; influencerId <= -2493; influencerId++)
            {
                for (int achievementPointId = -7162; achievementPointId >= -7166; achievementPointId--)
                {
                    var userCampaignAchievementPoint = new UserCampaignAchievementPoint
                    {
                        Id = counter37,
                        Created = DateTime.Now,
                        CreatedBy = "System",
                        LastModified = DateTime.Now,
                        LastModifiedBy = "System",
                        AchievementPointId = achievementPointId,
                        CampaignId = -37,
                        UserId = influencerId,
                        Status = AchievementStatus.Done.Value,
                    };
                    counter37--;

                    ListOfUserCampaignAchievementPoints.Add(userCampaignAchievementPoint);
                }
            }

            // ###################################################
            // ###### CampaignId -38 InfluencerId -999 ##########
            // ###################################################
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12775,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7167,
                CampaignId = -38,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12776,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7168,
                CampaignId = -38,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12777,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7169,
                CampaignId = -38,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12778,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7170,
                CampaignId = -38,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12779,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7171,
                CampaignId = -38,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            var counter38 = -12780;
            for (int influencerId = -2499; influencerId <= -2493; influencerId++)
            {
                for (int achievementPointId = -7167; achievementPointId >= -7171; achievementPointId--)
                {
                    var userCampaignAchievementPoint = new UserCampaignAchievementPoint
                    {
                        Id = counter38,
                        Created = DateTime.Now,
                        CreatedBy = "System",
                        LastModified = DateTime.Now,
                        LastModifiedBy = "System",
                        AchievementPointId = achievementPointId,
                        CampaignId = -38,
                        UserId = influencerId,
                        Status = AchievementStatus.Done.Value,
                    };
                    counter38--;

                    ListOfUserCampaignAchievementPoints.Add(userCampaignAchievementPoint);
                }
            }

            // ###################################################
            // ###### CampaignId -39 InfluencerId -999 ##########
            // ###################################################
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12815,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7172,
                CampaignId = -39,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12816,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7173,
                CampaignId = -39,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12817,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7174,
                CampaignId = -39,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12818,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7175,
                CampaignId = -39,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12819,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7176,
                CampaignId = -39,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            var counter39 = -12820;
            for (int influencerId = -2499; influencerId <= -2493; influencerId++)
            {
                for (int achievementPointId = -7172; achievementPointId >= -7176; achievementPointId--)
                {
                    var userCampaignAchievementPoint = new UserCampaignAchievementPoint
                    {
                        Id = counter39,
                        Created = DateTime.Now,
                        CreatedBy = "System",
                        LastModified = DateTime.Now,
                        LastModifiedBy = "System",
                        AchievementPointId = achievementPointId,
                        CampaignId = -39,
                        UserId = influencerId,
                        Status = AchievementStatus.Done.Value,
                    };
                    counter39--;

                    ListOfUserCampaignAchievementPoints.Add(userCampaignAchievementPoint);
                }
            }

            // ###################################################
            // ###### CampaignId -40 InfluencerId -999 ##########
            // ###################################################
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12855,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7177,
                CampaignId = -40,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12856,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7178,
                CampaignId = -40,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12857,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7179,
                CampaignId = -40,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12858,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7180,
                CampaignId = -40,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12859,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7181,
                CampaignId = -40,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            var counter40 = -12860;
            for (int influencerId = -2499; influencerId <= -2493; influencerId++)
            {
                for (int achievementPointId = -7177; achievementPointId >= -7181; achievementPointId--)
                {
                    var userCampaignAchievementPoint = new UserCampaignAchievementPoint
                    {
                        Id = counter40,
                        Created = DateTime.Now,
                        CreatedBy = "System",
                        LastModified = DateTime.Now,
                        LastModifiedBy = "System",
                        AchievementPointId = achievementPointId,
                        CampaignId = -40,
                        UserId = influencerId,
                        Status = AchievementStatus.Done.Value,
                    };
                    counter40--;

                    ListOfUserCampaignAchievementPoints.Add(userCampaignAchievementPoint);
                }
            }

            // ###################################################
            // ###### CampaignId -41 InfluencerId -999 ##########
            // ###################################################
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12895,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7182,
                CampaignId = -41,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12896,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7183,
                CampaignId = -41,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12897,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7184,
                CampaignId = -41,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12898,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7185,
                CampaignId = -41,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12899,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7186,
                CampaignId = -41,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            var counter41 = -12900;
            for (int influencerId = -2499; influencerId <= -2493; influencerId++)
            {
                for (int achievementPointId = -7182; achievementPointId >= -7186; achievementPointId--)
                {
                    var userCampaignAchievementPoint = new UserCampaignAchievementPoint
                    {
                        Id = counter41,
                        Created = DateTime.Now,
                        CreatedBy = "System",
                        LastModified = DateTime.Now,
                        LastModifiedBy = "System",
                        AchievementPointId = achievementPointId,
                        CampaignId = -41,
                        UserId = influencerId,
                        Status = AchievementStatus.Done.Value,
                    };
                    counter41--;

                    ListOfUserCampaignAchievementPoints.Add(userCampaignAchievementPoint);
                }
            }

            // ###################################################
            // ###### CampaignId -42 InfluencerId -999 ##########
            // ###################################################
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12935,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7187,
                CampaignId = -42,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12936,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7188,
                CampaignId = -42,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12937,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7189,
                CampaignId = -42,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12938,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7190,
                CampaignId = -42,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });
            ListOfUserCampaignAchievementPoints.Add(new UserCampaignAchievementPoint()
            {
                Id = -12939,
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                AchievementPointId = -7191,
                CampaignId = -42,
                UserId = -999,
                Status = AchievementStatus.Done.Value,
            });

            var counter42 = -12940;
            for (int influencerId = -2499; influencerId <= -2493; influencerId++)
            {
                for (int achievementPointId = -7187; achievementPointId >= -7191; achievementPointId--)
                {
                    var userCampaignAchievementPoint = new UserCampaignAchievementPoint
                    {
                        Id = counter42,
                        Created = DateTime.Now,
                        CreatedBy = "System",
                        LastModified = DateTime.Now,
                        LastModifiedBy = "System",
                        AchievementPointId = achievementPointId,
                        CampaignId = -42,
                        UserId = influencerId,
                        Status = AchievementStatus.Done.Value,
                    };
                    counter42--;

                    ListOfUserCampaignAchievementPoints.Add(userCampaignAchievementPoint);
                }
            }
        }
    }
}
