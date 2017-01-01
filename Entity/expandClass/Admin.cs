using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public partial class Admin
    {
        private List<int> _arrayQuyen = null;
        public List<int> getQuyen
        {
            get
            {
                if (_arrayQuyen == null)
                {
                    if (string.IsNullOrEmpty(this.Quyen))
                        _arrayQuyen = new List<int>();
                    else
                        _arrayQuyen = this.Quyen.Split(',').Where(d => !string.IsNullOrEmpty(d)).Select(d => Convert.ToInt32(d)).ToList();
                }
                return _arrayQuyen;
            }
        }
    }
}
