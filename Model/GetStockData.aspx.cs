using HtmlAgilityPack;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;
using System.Data.SqlClient;
using Newtonsoft.Json;
using System.Web;

public partial class Model_GetStockData : System.Web.UI.Page
{
    public class StockData
    {
        public string Result;
        public string[] NewsURL;
        public string[] NewsTitle;
        public string[] StockTitle;
        public string[] StockValue;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string aStcokNumber = Request["Number"].ToString();

            StockData aData = new StockData();

            ////下載 Yahoo 奇摩股市資料
            HtmlWeb aWeb = new HtmlWeb();
            aWeb.OverrideEncoding = Encoding.GetEncoding("big5");

            ////使用預設編碼讀入 HTML
            HtmlDocument doc = new HtmlDocument();
            doc = aWeb.Load("http://tw.stock.yahoo.com/q/q?s=" + aStcokNumber);


            //裝載第一層查詢結果
            HtmlDocument docStockContext = new HtmlDocument();

            docStockContext.LoadHtml(doc.DocumentNode.SelectSingleNode("/html[1]/body[1]/center[1]/table[2]/tr[1]/td[1]/table[1]").InnerHtml);

            //取得個股標頭
            HtmlNodeCollection nodeHeaders = docStockContext.DocumentNode.SelectNodes("./tr[1]/th");

            //取得個股數值
            string[] aStockValues = docStockContext.DocumentNode.SelectSingleNode("./tr[2]").InnerText.Trim().Split('\n');

            for (int i = 0; i < aStockValues.Length; i++)
                aStockValues[i] = aStockValues[i].Replace(" ", "");

            List<string> aTitleData = new List<string>();

            //輸出資料
            foreach (HtmlNode nodeHeader in nodeHeaders)
            {
                if (nodeHeader.InnerText.Trim() != "")
                    aTitleData.Add(HttpUtility.HtmlDecode(nodeHeader.InnerText));
            }
            //0.代碼 1.時間(不需要) 2.成交價 3.買進價 4.賣出價 5.漲跌 6.張數 7.昨收 8.開盤 9.最高 10.最低
            aData.StockValue = aStockValues;
            aData.StockValue[0] = aData.StockValue[0].Replace("加到投資組合", "");
            //取得股票資料標頭
            aData.StockTitle = aTitleData.ToArray();
            if(CheckStockData(aStcokNumber) == false)
                InsertToSQL(aStockValues, aStcokNumber);
            else
                UpdateSQLData(aStockValues, aStcokNumber);

            //取得新聞標題
            aData.NewsTitle = GetNewsTitle(doc);
            //取得新聞URL
            aData.NewsURL = GetNewsURL(doc);

            //aData.IsFavourite = CheckIsFavourite(aStcokNumber);

            doc = null;
            docStockContext = null;

            aData.Result = "0";

            string aJsonStr = JsonConvert.SerializeObject(aData, new JsonSerializerSettings() { StringEscapeHandling = StringEscapeHandling.EscapeNonAscii });

            Response.Write(aJsonStr);

        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }

    private void InsertToSQL(string[] iValue,string iStockNumber)
    {
        string aStockName = iValue[0].Replace(iStockNumber, "");
        aStockName = aStockName.Replace("加到投資組合", "");
        using (SqlConnection aCon = new SqlConnection("Data Source = 184.168.47.10; Integrated Security = False; User ID = MobileDaddy; PASSWORD = Aa54380438!; Connect Timeout = 15; Encrypt = False; Packet Size = 4096 ;"))
        {
            aCon.Open();
            //0.代碼 1.時間(不需要) 2.成交價 3.買進價 4.賣出價 5.漲跌 6.張數 7.昨收 8.開盤 9.最高 10.最低
            string aInsertData = string.Format("INSERT INTO StockData(StockName,StockNumber,DealPrice,BuyPrice,SalePrice,PriceRange,DealCount,Yesterday,StartPrice,Highest,Lowest) " +
                "VALUES(N'{0}','{1}','{2}','{3}','{4}',N'{5}','{6}','{7}','{8}','{9}','{10}')",
                aStockName,iStockNumber,iValue[2], iValue[3], iValue[4], iValue[5], iValue[6], iValue[7], iValue[8], iValue[9], iValue[10]);

            using (SqlCommand aCmd = new SqlCommand(aInsertData,aCon))
            {
                aCmd.ExecuteNonQuery();
            }
            aCon.Close();
        }
    }

    private bool CheckStockData(string iStockNumber)
    {
        bool aFind = false;

        using (SqlConnection aCon = new SqlConnection("Data Source = 184.168.47.10; Integrated Security = False; User ID = MobileDaddy; PASSWORD = Aa54380438!; Connect Timeout = 15; Encrypt = False; Packet Size = 4096 ;"))
        {
            aCon.Open();
            string aStrSQL = string.Format("select * FROM StockData WHERE StockNumber='{0}'", iStockNumber);
           

            using (SqlCommand aCmd = new SqlCommand(aStrSQL, aCon))
            {
                SqlDataReader aRd = aCmd.ExecuteReader();

                while (aRd.Read())
                {
                    aFind = true;
                }
            }
            aCon.Close();
        }
        if (aFind == true)
            return true;
        else
            return false;
    }


    private string[] GetNewsURL(HtmlDocument iDoc)
    {
        List<string> aNewsURL = new List<string>();

        // 裝載第一層查詢結果 
        HtmlDocument aDocStockContext = new HtmlDocument();

        aDocStockContext.LoadHtml(iDoc.DocumentNode.SelectSingleNode(@"//div[@class='bd quote']").InnerHtml);

        HtmlNodeCollection aURLHtnode = aDocStockContext.DocumentNode.SelectNodes("./ul[1]/li");
        int aIndex = 0;
        foreach (HtmlNode currNode in aURLHtnode)
        {
            aNewsURL.Add("https://tw.stock.yahoo.com/" + currNode.SelectSingleNode("./a").Attributes["href"].Value);
            aIndex++;
            if (aIndex >= 4)
                break;
        }

        return aNewsURL.ToArray();
    }

    private string[] GetNewsTitle(HtmlDocument iDoc)
    {
        List<string> aNewsTitle = new List<string>();

        HtmlDocument aDocStockContext = new HtmlDocument();

        aDocStockContext.LoadHtml(iDoc.DocumentNode.SelectSingleNode(@"//div[@class='bd quote']").InnerHtml);

        // 取得個股新聞標題
        string[] aTitle = aDocStockContext.DocumentNode.SelectSingleNode("./ul[1]").InnerText.Trim().Split('\n');

        int i = 0;

        while (i < aTitle.Length)
        {
            aNewsTitle.Add(aTitle[i]);

            i += 3;
        }

        return aNewsTitle.ToArray();
    }

    private void UpdateSQLData(string[] iValue, string iStockNumber)
    {
        using (SqlConnection aCon = new SqlConnection("Data Source = 184.168.47.10; Integrated Security = False; User ID = MobileDaddy; PASSWORD = Aa54380438!; Connect Timeout = 15; Encrypt = False; Packet Size = 4096 ;"))
        {
            aCon.Open();
            //0.代碼 1.時間(不需要) 2.成交價 3.買進價 4.賣出價 5.漲跌 6.張數 7.昨收 8.開盤 9.最高 10.最低
            string aInsertData = string.Format("UPDATE StockData SET DealPrice='{0}',BuyPrice='{1}',SalePrice='{2}',PriceRange=N'{3}',DealCount='{4}',Yesterday='{5}',StartPrice='{6}',Highest='{7}',Lowest='{8}' WHERE StockNumber='{9}'",
                iValue[2], iValue[3], iValue[4], iValue[5], iValue[6], iValue[7], iValue[8], iValue[9], iValue[10],iStockNumber);

            using (SqlCommand aCmd = new SqlCommand(aInsertData, aCon))
            {
                aCmd.ExecuteNonQuery();
            }
            aCon.Close();
        }
    }
}