using SigmaMarketing.Model.Models.Response.Base;

namespace SigmaMarketing.Core.Helper.enums
{
    public abstract class CampaignStatus : Enumeration<CampaignStatus>
    {
        public static readonly CampaignStatus NotActive = new NotActiveStatus();
        public static readonly CampaignStatus Open = new OpenStatus();
        public static readonly CampaignStatus InProgress = new InProgressStatus();
        public static readonly CampaignStatus Completed = new CompletedStatus();
        public static readonly CampaignStatus Archived = new ArchivedStatus();

        protected CampaignStatus(int value, string name) : base(value, name)
        {
        }

        public abstract string HexColor { get; }

        private sealed class NotActiveStatus : CampaignStatus
        {
            public NotActiveStatus() : base(0, "Not Active")
            {
            }

            public override string HexColor => "F03131";
        }

        private sealed class OpenStatus : CampaignStatus
        {
            public OpenStatus() : base(1, "Open")
            {
            }

            public override string HexColor => "E7BD29";
        }

        private sealed class InProgressStatus : CampaignStatus
        {
            public InProgressStatus() : base(2, "In Progress")
            {
            }

            public override string HexColor => "3FAFDF";
        }

        private sealed class CompletedStatus : CampaignStatus
        {
            public CompletedStatus() : base(3, "Completed")
            {
            }

            public override string HexColor => "42DF3F";
        }

        private sealed class ArchivedStatus : CampaignStatus
        {
            public ArchivedStatus() : base(4, "Archived")
            {
            }

            public override string HexColor => "919291";
        }

        public static BaseStatus ToBaseStatus(int value)
        {
            CampaignStatus campaignStatus = value switch
            {
                0 => NotActive,
                1 => Open,
                2 => InProgress,
                3 => Completed,
                4 => Archived,
                _ => NotActive,
            };

            return new BaseStatus
            {
                Value = campaignStatus.Value,
                Name = campaignStatus.Name,
                Color = campaignStatus.HexColor
            };
        }

        public static Dictionary<int, string> GetAllCampaignStatuses()
        {
            var campaignStatuses = new Dictionary<int, string>();

            var statuses = Enumeration<CampaignStatus>.GetEnumerations();

            foreach (var stat in statuses)
            {
                campaignStatuses.Add(stat.Key, stat.Value.Name);
            }

            return campaignStatuses;
        }
    }
}
