using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Text.RegularExpressions;
using System.Linq;

public class strucIni
{
    public List<string> listLine { set; get; }
    public string name { set; get; }
    public long timeTick { set; get; }
    public strucIni(string name, List<string> listLine, long timeTick)
    {
        this.listLine = listLine;
        this.name = name;
        this.timeTick = timeTick;
    }
}
public class Ini
{
    public static HashSet<strucIni> listIni = new HashSet<strucIni>();
    public static strucIni getStrucIni(string patchFile)
    {
        FileInfo _file = new FileInfo(patchFile);
        if (_file.Exists)
        {
            strucIni getData = (from p in listIni where p.name.Equals(patchFile) select p).FirstOrDefault<strucIni>();
            if (getData == null)
            {
                getData = new strucIni(patchFile, new List<string>(), _file.LastWriteTime.Ticks);
                StreamReader read = _file.OpenText();
                string text;
                do
                {
                    text = read.ReadLine();
                    if (text != null)
                    {
                        getData.listLine.Add(text);
                    }
                } while (text != null);
                read.Close();
            }
            else
            {
                if (getData.timeTick != _file.LastWriteTime.Ticks)
                {
                    getData.timeTick = _file.LastWriteTime.Ticks;
                    StreamReader read = _file.OpenText();
                    string text;
                    do
                    {
                        text = read.ReadLine();
                        if (text != null)
                        {
                            getData.listLine.Add(text);
                        }
                    } while (text != null);
                    read.Close();
                }
            }
            return getData;
        }
        else {
            strucIni getData = new strucIni(patchFile, new List<string>(), DateTime.Now.Ticks);
            return getData;
        }
    }
    public static bool deleteSection(string Patch, string Section)
    {
        try
        {

            List<string> listLine = getStrucIni(Patch).listLine;
            StreamWriter _writer = new StreamWriter(Patch, false, new UTF8Encoding());
            bool isSection = false;
            bool isExitSection = false;
            List<string> listLineWrite = new List<string>();
            foreach (string item in listLine)
            {

                if (!isSection)
                {
                    if (item.IndexOf("[" + Section + "]") != -1)
                    {
                        isSection = true;
                    }
                    else
                    {
                        listLineWrite.Add(item);
                    }
                }
                else
                {
                    if (isExitSection)
                    {
                        listLineWrite.Add(item);
                    }
                    else
                    {
                        if (item.IndexOf("[") != -1 && item.IndexOf("]") != -1 && item.IndexOf("=") == -1)
                        {
                            listLineWrite.Add(item);
                            isExitSection = true;
                        }
                    }
                }
            }
            foreach (string item in listLineWrite)
            {
                _writer.WriteLine(item);
            }
            _writer.Flush();
            _writer.Close();
            return true;
        }
        catch (IOException ex)
        {
            return false;
        }
    }

    public static bool writer(string Patch, string Section, string Key, string Value)
    {
        try
        {
            List<string> listLine = getStrucIni(Patch).listLine;
            StreamWriter _writer = new StreamWriter(Patch, false, new UTF8Encoding());
            bool isExitWrite = false;
            bool isSection = false;
            bool isKey = false;
            bool isExitSection = false;
            List<string> listLineWrite = new List<string>();
            foreach (string item in listLine)
            {

                if (!isSection)
                {
                    if (item.IndexOf("[" + Section + "]") != -1)
                    {
                        listLineWrite.Add(item);
                        isSection = true;
                    }
                    else
                    {
                        listLineWrite.Add(item);
                    }
                }
                else
                {
                    if (isExitSection)
                    {
                        listLineWrite.Add(item);
                    }
                    else
                    {
                        if (!isKey)
                        {
                            if (item.IndexOf("[") != -1 && item.IndexOf("]") != -1 && item.IndexOf("=") == -1)
                            {
                                listLineWrite.Add(Key + "=" + Value);
                                listLineWrite.Add(item);
                                isExitSection = true;
                            }
                            else
                            {
                                string[] txtSplit = item.Split('=');
                                if (txtSplit.Length > 1)
                                {
                                    if (txtSplit[0].Trim().Equals(Key))
                                    {
                                        listLineWrite.Add(Key + "=" + Value);
                                        isKey = true;
                                        isExitWrite = true;
                                    }
                                    else
                                    {
                                        listLineWrite.Add(item);
                                    }
                                }
                                else
                                {
                                    listLineWrite.Add(item);
                                }
                            }
                        }
                        else
                        {
                            listLineWrite.Add(item);
                        }
                    }
                }
            }
            if (!isExitWrite)
            {
                foreach (string item in listLineWrite)
                {
                    _writer.WriteLine(item);
                }
                if (!isSection)
                {
                    _writer.WriteLine("[" + Section + "]");
                }
                if (!isKey && !isExitSection)
                {
                    _writer.WriteLine(Key + "=" + Value);
                }
            }
            else
            {
                foreach (string item in listLineWrite)
                {
                    _writer.WriteLine(item);
                }
            }
            _writer.Flush();
            _writer.Close();
            return true;
        }
        catch (IOException ex)
        {
            return false;
        }
    }
    public static string read(string Patch, string Section, string Key,out bool exitkey)
    {
        exitkey = false;
        try
        {
            
            string textReturn = "";
            List<string> listLine = new List<string>();
            List<string> lineNew = getStrucIni(Patch).listLine;
            for (int i = 0; i < lineNew.Count; i++)
            {
                string text = lineNew[i];
                if (text.Trim().Length > 0)
                {
                    if (text.IndexOf("[" + Section + "]") != -1)
                    {
                        for (int j = i+1; j < lineNew.Count; j++)
                        {
                            text = lineNew[j];
                            if (text.IndexOf("[") != -1 && text.IndexOf("]") != -1 && text.IndexOf("=") == -1)
                            {
                                text = null;
                            }
                            else
                            {
                                if (!text.Trim().Equals(""))
                                {
                                    listLine.Add(text);
                                }
                            }
                        }
                    }
                }
                else {
                    textReturn = "";
                }
            }
            foreach (string item in listLine)
            {
                string[] txtSplit = item.Split('=');
                if (txtSplit.Length > 1)
                {
                    if (txtSplit[0].Trim().Equals(Key))
                    {
                        exitkey = true;
                        if (txtSplit.Length == 2)
                        {
                            textReturn = txtSplit[1];
                        }
                        else
                        {
                            for (int i = 1; i < txtSplit.Length; i++)
                            {
                                textReturn += txtSplit[i];
                                if (i < txtSplit.Length - 1)
                                {
                                    textReturn += "=";
                                }
                            }
                        }
                        break;
                    }
                }
            }
            return textReturn;
        }
        catch (IOException ex)
        {
            return "";
        }
    }
}
