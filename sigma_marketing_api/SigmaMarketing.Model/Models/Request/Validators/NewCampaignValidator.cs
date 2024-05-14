using FluentValidation;

namespace SigmaMarketing.Model.Models.Request.Validators
{
    public class NewCampaignValidator : AbstractValidator<NewCampaignRequest>
    {
        public NewCampaignValidator()
        {
            RuleFor(x => x.Name).NotEmpty().WithMessage("Name is required");
            RuleFor(x => x.StartDate).NotEmpty().WithMessage("Start Date is required");
            RuleFor(x => x.EndDate).NotEmpty().WithMessage("End Date is required");
            RuleFor(x => x.Details).NotEmpty().WithMessage("Details are required");
            RuleFor(x => x.Budget).GreaterThan(0).WithMessage("Budget must be a positive number");
            RuleFor(x => x.OpenPositions).GreaterThan(0).WithMessage("Maximum positions must be a positive number");
            RuleFor(x => x.VideoUrl).NotEmpty().WithMessage("Video URL is required").Must(BeAValidUrl).WithMessage("Video URL must be a valid URL");
        }

        private bool BeAValidUrl(string url)
        {
            return Uri.TryCreate(url, UriKind.Absolute, out Uri uriResult)
                   && (uriResult.Scheme == Uri.UriSchemeHttp || uriResult.Scheme == Uri.UriSchemeHttps);
        }
    }
}
