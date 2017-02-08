using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public partial class ThreadChat
    {

        public string getName()
        {
            return !isRegister() ? "Bạn cần hỗ trợ?" : this.Admin == null ? "Đang đợi tư vấn viên":this.Admin.FullName;
        }
        public bool isRegister()
        {
            if (this.FullName != null && this.Email != null && this.PhoneNumber != null)
                return true;
            else
                return false;
        }
        public Admin Admin { get; set; }
    }
}
