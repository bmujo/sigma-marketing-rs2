using SigmaMarketing.Model.Models.Response.Base;

namespace SigmaMarketing.Core.Helper.enums
{
    public abstract class CampaignUserStatus : Enumeration<CampaignUserStatus>
    {
        public static readonly CampaignUserStatus Initial = new InitialStatus();
        public static readonly CampaignUserStatus Requested = new RequestedStatus();
        public static readonly CampaignUserStatus Invited = new InvitedStatus();
        public static readonly CampaignUserStatus Denied = new DeniedStatus();

        public static readonly CampaignUserStatus Accepted = new AcceptedStatus();
        public static readonly CampaignUserStatus InProgress = new InProgressStatus();
        public static readonly CampaignUserStatus Completed = new CompletedStatus();
        public static readonly CampaignUserStatus PayedOut = new PayedOutStatus();

        protected CampaignUserStatus(int value, string name) : base(value, name)
        {
        }

        public abstract string HexColor { get; }

        private sealed class InitialStatus : CampaignUserStatus
        {
            public InitialStatus() : base(0, "Initial")
            {
            }

            public override string HexColor => "F03131";
        }

        private sealed class RequestedStatus : CampaignUserStatus
        {
            public RequestedStatus() : base(1, "Requested")
            {
            }

            public override string HexColor => "E7BD29";
        }

        private sealed class InvitedStatus : CampaignUserStatus
        {
            public InvitedStatus() : base(2, "Invited")
            {
            }

            public override string HexColor => "3FAFDF";
        }

        private sealed class DeniedStatus : CampaignUserStatus
        {
            public DeniedStatus() : base(3, "Denied")
            {
            }

            public override string HexColor => "42DF3F";
        }



        private sealed class AcceptedStatus : CampaignUserStatus
        {
            public AcceptedStatus() : base(4, "Accepted")
            {
            }

            public override string HexColor => "919291";
        }

        private sealed class InProgressStatus : CampaignUserStatus
        {
            public InProgressStatus() : base(5, "In Progress")
            {
            }

            public override string HexColor => "919291";
        }

        private sealed class CompletedStatus : CampaignUserStatus
        {
            public CompletedStatus() : base(6, "Completed")
            {
            }

            public override string HexColor => "919291";
        }

        private sealed class PayedOutStatus : CampaignUserStatus
        {
            public PayedOutStatus() : base(7, "Payed Out")
            {
            }

            public override string HexColor => "919291";
        }

        public static BaseStatus ToBaseStatus(int value)
        {
            CampaignUserStatus campaignUserStatus = value switch
            {
                0 => Initial,
                1 => Requested,
                2 => Invited,
                3 => Denied,
                4 => Accepted,
                5 => InProgress,
                6 => Completed,
                7 => PayedOut,
                _ => Initial,
            };

            return new BaseStatus
            {
                Value = campaignUserStatus.Value,
                Name = campaignUserStatus.Name,
                Color = campaignUserStatus.HexColor
            };
        }
    }
}
