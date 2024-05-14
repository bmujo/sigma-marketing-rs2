using System.ComponentModel.DataAnnotations;

namespace SigmaMarketing.Core.Entities.Base
{
    public class BaseEntity
    {
        [Key]
        public int Id { get; set; }

        public DateTime Created { get; set; }

        public string CreatedBy { get; set; }

        public DateTime? LastModified { get; set; }

        public string LastModifiedBy { get; set; }
    }
}
