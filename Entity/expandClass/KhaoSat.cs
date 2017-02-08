using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public partial class KhaoSat
    {
        public class strucData {

            public string id;
            public string title;
            public List<strucCau> array;
        }
        public class strucCau
        {

            public string id;
            public string text;
        }
        public List<strucData> arrayCauHoi = null;
        public List<KhaoSat_TraLoi> arrayCauTraLoi = null;
        
    }
}
