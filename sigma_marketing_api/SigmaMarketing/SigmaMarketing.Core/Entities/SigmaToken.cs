using SigmaMarketing.Core.Entities.Base;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SigmaMarketing.Core.Entities
{
    public class SigmaToken : BaseEntity
    {
        public string PackageName { get; set; }
        public int Amount { get; set; }
        public double Price { get; set; }
    }
}
