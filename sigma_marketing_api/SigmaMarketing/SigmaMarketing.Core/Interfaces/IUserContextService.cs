namespace SigmaMarketing.Core.Interfaces
{
    public interface IUserContextService
    {
        int GetCurrentUserId();
        string GetHostUrl();
    }
}
