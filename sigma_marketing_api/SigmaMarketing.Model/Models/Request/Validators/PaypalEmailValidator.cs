using FluentValidation;

namespace SigmaMarketing.Model.Models.Request.Validators
{
    public class PaypalEmailValidator : AbstractValidator<PaypalEmailRequest>
    {
        public PaypalEmailValidator()
        {
            RuleFor(x => x.PaypalEmail)
                .NotEmpty().WithMessage("PaypalEmail is required")
                .EmailAddress().WithMessage("PaypalEmail is not a valid email address");
        }
    }
}

