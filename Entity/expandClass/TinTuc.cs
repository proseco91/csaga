using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public partial class TinTuc
    {
        public DateTime NgayHienThi
        {
            get
            {
                if (this.ShowDate.HasValue)
                    return this.ShowDate.Value;
                return this.CreateDate.Value;
            }
        }
    }
}
