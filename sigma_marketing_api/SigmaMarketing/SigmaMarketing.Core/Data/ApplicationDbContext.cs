using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using SigmaMarketing.Core.Data.MockData;
using SigmaMarketing.Core.Entities;

namespace SigmaMarketing.Core.Data
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser, IdentityRole<int>, int>
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
        }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);
            optionsBuilder.EnableSensitiveDataLogging(true);
        }

        public DbSet<Campaign> Campaigns { get; set; }
        public DbSet<CampaignTag> CampaignTags { get; set; }
        public DbSet<CampaignUser> CampaignUsers { get; set; }
        public DbSet<Message> Messages { get; set; }
        public DbSet<Photo> Photos { get; set; }
        public DbSet<Tag> Tags { get; set; }
        public DbSet<Video> Videos { get; set; }
        public DbSet<Notification> Notifications { get; set; }
        public DbSet<Conversation> Conversations { get; set; }
        public DbSet<HubConnection> HubConnections { get; set; }
        public DbSet<AchievementPoint> AchievementPoints { get; set; }
        public DbSet<LikedCampaign> LikedCampaigns { get; set; }
        public DbSet<UserCampaignAchievementPoint> UserCampaignAchievementPoints { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<SigmaToken> SigmaTokens { get; set; }
        public DbSet<Transfer> Transfers { get; set; }
        public DbSet<Withdraw> Withdraws { get; set; }
        public DbSet<PaymentTerm> PaymentTerms { get; set; }
        public DbSet<Platform> Platforms { get; set; }
        public DbSet<CampaignPlatform> CampaignPlatforms { get; set; }
        public DbSet<TrackState> TrackStates { get; set; }
        public DbSet<AchievementTrackNote> AchievementTrackNotes { get; set; }
        public DbSet<AchievementType> AchievementsTypes { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

            builder.Entity<ApplicationUser>(entity =>
            {
                entity.ToTable(name: "User");
                entity.Property(e => e.Id).HasColumnName("UserID");

            });

            builder.Entity<IdentityRole<int>>(entity =>
            {
                entity.ToTable(name: "Role");
                entity.Property(e => e.Id).HasColumnName("RoleID");

            });

            builder.Entity<IdentityUserClaim<int>>(entity =>
            {
                entity.ToTable("UserClaim");
                entity.Property(e => e.UserId).HasColumnName("UserID");
                entity.Property(e => e.Id).HasColumnName("UserClaimID");

            });

            builder.Entity<IdentityUserLogin<int>>(entity =>
            {
                entity.ToTable("UserLogin");
                entity.Property(e => e.UserId).HasColumnName("UserID");

            });

            builder.Entity<IdentityRoleClaim<int>>(entity =>
            {
                entity.ToTable("RoleClaim");
                entity.Property(e => e.Id).HasColumnName("RoleClaimID");
                entity.Property(e => e.RoleId).HasColumnName("RoleID");
            });

            builder.Entity<IdentityUserRole<int>>(entity =>
            {
                entity.ToTable("UserRole");
                entity.Property(e => e.UserId).HasColumnName("UserID");
                entity.Property(e => e.RoleId).HasColumnName("RoleID");

            });

            builder.Entity<IdentityUserToken<int>>(entity =>
            {
                entity.ToTable("UserToken");
                entity.Property(e => e.UserId).HasColumnName("UserID");
            });

            builder.Entity<CampaignUser>()
                .HasOne(cu => cu.Campaign) 
                .WithMany()
                .HasForeignKey(cu => cu.CampaignId)
                .OnDelete(DeleteBehavior.NoAction);

            builder.Entity<UserCampaignAchievementPoint>()
                .HasOne(cu => cu.Campaign)
                .WithMany()
                .HasForeignKey(cu => cu.CampaignId)
                .OnDelete(DeleteBehavior.NoAction);

            builder.Entity<UserCampaignAchievementPoint>()
                .HasOne(cu => cu.User)
                .WithMany()
                .HasForeignKey(cu => cu.UserId)
                .OnDelete(DeleteBehavior.NoAction);

            builder.Entity<ApplicationUser>()
                .HasMany(x => x.CampaignUsers)
                .WithOne(x => x.Influencer)
                .IsRequired();

            builder.Entity<Campaign>()
               .HasMany(x => x.CampaignUsers)
               .WithOne(x => x.Campaign)
               .IsRequired();

            builder.Entity<Conversation>()
               .HasMany(x => x.Messages)
               .WithOne(x => x.Conversation)
               .IsRequired();

            SeedAchievementTypes(builder);
            SeedPaymentTerms(builder);
            SeedUsers(builder);
            SeedRoles(builder);
            SeedUserRoles(builder);
            SeedNotifications(builder);
            SeedTags(builder);
            SeedCampaignUsers(builder);
            SeedAchievementPoints(builder);
            SeedSigmaTokens(builder);
            SeedPlatforms(builder);
            SeedUserCampaignAchievements(builder);
            SeedUserCampaignAchievements2(builder);
            SeedCampaignTags(builder);
            SeedCampaignPlatforms(builder);
        }

        private void SeedUsers(ModelBuilder builder)
        {
            ApplicationUser userCompany = new ApplicationUser()
            {
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                Id = -777,
                UserName = "Company",
                FirstName = "Company",
                LastName = "Company",
                Email = "company@gmail.com",
                NormalizedEmail = "company@gmail.com".ToUpper(),
                LockoutEnabled = true,
                IsInfluencer = false,
                PhoneNumber = "1234567890",
                Balance = 0,
                ProfilePhotoUrl = "/images/profile/profile_default.png",
                InstagramLink = "https://www.instagram.com/",
                FacebookLink = "https://www.facebook.com/",
                TikTokLink = "https://www.tiktok.com/",
                LinkedInLink = "https://www.linkedin.com/",
                Bio = "Company Bio",
            };

            ApplicationUser userInfluencer = new ApplicationUser()
            {
                Created = DateTime.Now,
                CreatedBy = "System",
                LastModified = DateTime.Now,
                LastModifiedBy = "System",
                Id = -999,
                UserName = "InfluencerVM",
                FirstName = "InfluencerVM",
                LastName = "InfluencerVM",
                Email = "influencer@gmail.com",
                NormalizedEmail = "influencer@gmail.com".ToUpper(),
                LockoutEnabled = true,
                IsInfluencer = true,
                PhoneNumber = "1234567890",
                Balance = 0,
                ProfilePhotoUrl = "/images/profile/profile_default.png",
                InstagramLink = "https://www.instagram.com/",
                FacebookLink = "https://www.facebook.com/",
                TikTokLink = "https://www.tiktok.com/",
                LinkedInLink = "https://www.linkedin.com/",
                Bio = "Influencer Bio",
            };

            // Add Balance 
            userCompany.Balance = 5000;
            userInfluencer.Balance = 1000;

            PasswordHasher<ApplicationUser> passwordHasher1 = new PasswordHasher<ApplicationUser>();
            userCompany.PasswordHash = passwordHasher1.HashPassword(userCompany, "Test1234*");

            PasswordHasher<ApplicationUser> passwordHasher2 = new PasswordHasher<ApplicationUser>();
            userInfluencer.PasswordHash = passwordHasher2.HashPassword(userInfluencer, "Test1234*");

            builder.Entity<ApplicationUser>().HasData(userCompany);
            builder.Entity<ApplicationUser>().HasData(userInfluencer);

            var companies = new Companies();
            foreach (var item in companies.ListOfCompanies)
            {
                PasswordHasher<ApplicationUser> passwordHasher = new PasswordHasher<ApplicationUser>();
                item.PasswordHash = passwordHasher.HashPassword(userCompany, "Test1234*");
                builder.Entity<ApplicationUser>().HasData(item);
            }

            var influencers = new Influencers();
            foreach (var item in influencers.ListOfInfluencers)
            {
                PasswordHasher<ApplicationUser> passwordHasher = new PasswordHasher<ApplicationUser>();
                item.PasswordHash = passwordHasher.HashPassword(userCompany, "Test1234*");
                builder.Entity<ApplicationUser>().HasData(item);
            }

            var campaigns = new Campaigns();
            foreach (var item in campaigns.ListOfCampaigns)
            {
                builder.Entity<Campaign>().HasData(item);
            }
        }

        private void SeedCampaignPlatforms(ModelBuilder builder)
        {
            var campaignPlatforms = new CampaignPlatforms();
            foreach (var item in campaignPlatforms.ListOfCampaignPlatforms)
            {
                builder.Entity<CampaignPlatform>().HasData(item);
            }
        }

        private void SeedCampaignTags(ModelBuilder builder)
        {
            var campaignTags = new CampaignTags();
            foreach (var item in campaignTags.ListOfCampaignTags)
            {
                builder.Entity<CampaignTag>().HasData(item);
            }
        }

        private void SeedUserCampaignAchievements(ModelBuilder builder)
        {
            var userCampaignAchievements = new UserCampaignAchievements();
            foreach (var item in userCampaignAchievements.ListOfUserCampaignAchievementPoints)
            {
                builder.Entity<UserCampaignAchievementPoint>().HasData(item);
            }
        }

        private void SeedUserCampaignAchievements2(ModelBuilder builder)
        {
            var userCampaignAchievements = new UserCampaignAchievements2();
            foreach (var item in userCampaignAchievements.ListOfUserCampaignAchievementPoints)
            {
                builder.Entity<UserCampaignAchievementPoint>().HasData(item);
            }
        }

        private void SeedAchievementTypes(ModelBuilder builder)
        {
            var achievementTypes = new AchievementTypes();
            foreach (var item in achievementTypes.ListOfAchievementTypes)
            {
                builder.Entity<AchievementType>().HasData(item);
            }
        }

        private void SeedPaymentTerms(ModelBuilder builder)
        {
            var paymentTerms = new PaymentTerms();
            foreach (var item in paymentTerms.ListOfPaymentTerms)
            {
                builder.Entity<PaymentTerm>().HasData(item);
            }
        }

        private void SeedRoles(ModelBuilder builder)
        {
            builder.Entity<IdentityRole<int>>().HasData(
                new IdentityRole<int>() { Id = -1, Name = "Copmpany", ConcurrencyStamp = "-1", NormalizedName = "Company" },
                new IdentityRole<int>() { Id = -2, Name = "InfluencerVM", ConcurrencyStamp = "-2", NormalizedName = "InfluencerVM" }
                );
        }

        private void SeedUserRoles(ModelBuilder builder)
        {
            builder.Entity<IdentityUserRole<int>>().HasData(
                new IdentityUserRole<int>() { RoleId = -1, UserId = -777 },
                new IdentityUserRole<int>() { RoleId = -2, UserId = -999 }
                );
        }

        private void SeedNotifications(ModelBuilder builder)
        {
            var notifications = new Notifications();
            foreach (var item in notifications.ListOfNotifications)
            {
                builder.Entity<Notification>().HasData(item);
            }
        }

        private void SeedTags(ModelBuilder builder)
        {
            var tags = new Tags();
            foreach (var item in tags.ListOfTags)
            {
                builder.Entity<Tag>().HasData(item);
            }
        }

        private void SeedCampaignUsers(ModelBuilder builder)
        {
            var campaignUsers = new CampaignUsers();
            foreach (var item in campaignUsers.CampaignUsersList)
            {
                builder.Entity<CampaignUser>().HasData(item);
            }
        }

        private void SeedAchievementPoints(ModelBuilder builder)
        {
            var achievementPoints = new AchievementPoints();
            foreach (var item in achievementPoints.ListOfPoints)
            {
                builder.Entity<AchievementPoint>().HasData(item);
            }
        }

        private void SeedSigmaTokens(ModelBuilder builder)
        {
            var sigmaTokens = new SigmaTokens();
            foreach (var item in sigmaTokens.ListOfSigmaTokens)
            {
                builder.Entity<SigmaToken>().HasData(item);
            }
        }

        private void SeedPlatforms(ModelBuilder builder)
        {
            var platforms = new Platforms();
            foreach (var item in platforms.ListOfPlatforms)
            {
                builder.Entity<Platform>().HasData(item);
            }
        }
    }
}
