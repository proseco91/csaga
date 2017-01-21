using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public partial class Comment
    {
        public string CreateDateTxt
        {
            get
            {
                return this.CreateDate.ToString("dd-MM-yyyy lúc HH:mm");
            }
        }
    }
}
