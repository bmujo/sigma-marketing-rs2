using QuestPDF.Infrastructure;

namespace SigmaMarketing.Email.PdfGenerator
{
    public interface IDocument
    {
        DocumentMetadata GetMetadata();
        DocumentSettings GetSettings();
        byte[]? Compose();
    }
}
