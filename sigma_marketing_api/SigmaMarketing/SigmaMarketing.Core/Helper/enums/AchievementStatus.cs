using SigmaMarketing.Model.Models.Response.Base;

namespace SigmaMarketing.Core.Helper.enums
{
    public abstract class AchievementStatus : Enumeration<AchievementStatus>
    {
        public static readonly AchievementStatus Initial = new InitialStatus();
        public static readonly AchievementStatus Review = new ReviewStatus();
        public static readonly AchievementStatus Revision = new RevisionStatus();
        public static readonly AchievementStatus Done = new DoneStatus();

        protected AchievementStatus(int value, string name) : base(value, name)
        {
        }

        public abstract string HexColor { get; }

        private sealed class InitialStatus : AchievementStatus
        {
            public InitialStatus() : base(0, "Initial")
            {
            }

            public override string HexColor => "F03131";
        }

        private sealed class ReviewStatus : AchievementStatus
        {
            public ReviewStatus() : base(1, "Review")
            {
            }

            public override string HexColor => "E7BD29";
        }

        private sealed class RevisionStatus : AchievementStatus
        {
            public RevisionStatus() : base(2, "Revision")
            {
            }

            public override string HexColor => "3FAFDF";
        }

        private sealed class DoneStatus : AchievementStatus
        {
            public DoneStatus() : base(3, "Done")
            {
            }

            public override string HexColor => "42DF3F";
        }

        public static BaseStatus ToBaseStatus(int value)
        {
            AchievementStatus campaignStatus = value switch
            {
                0 => Initial,
                1 => Review,
                2 => Revision,
                3 => Done,
                _ => Initial,
            };

            return new BaseStatus
            {
                Value = campaignStatus.Value,
                Name = campaignStatus.Name,
                Color = campaignStatus.HexColor
            };
        }
    }
}
