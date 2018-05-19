using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public partial class SettingWeb
    {
        private Dictionary<string, Dictionary<string, string>> _hotline = null;

        public Dictionary<string, Dictionary<string, string>> hotlineDictionary
        {
            get
            {
                if (_hotline == null && !string.IsNullOrEmpty(this.Hotline))
                    _hotline = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, string>>>(this.Hotline);
                return _hotline;
            }
        }
    }
}
