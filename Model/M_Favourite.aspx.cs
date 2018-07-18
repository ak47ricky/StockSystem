using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Data.SqlClient;

public partial class Model_M_Favourite : System.Web.UI.Page
{
    public class AllFavourite
    {
        public int total;
        public FavouriteData[] rows;
    }

    public class FavouriteData
    {
        public string StockName;
        public string NowPrice;
        public string RangePrice;
        public string YesterdayPrice;
    }

    public class StockData
    {
        public string Result;
        public string[] StockValue;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        HttpCookie aCookieAC = Request.Cookies["Account"];

        string aAccount = aCookieAC.Value;

        if (aAccount == null)
            return;

        List<FavouriteData> aData = new List<FavouriteData>();

        string[] aAllFavourite = GetFavourite(aAccount);

        if (aAllFavourite.Length <= 0)
            return;

        SqlConnection aCon = new SqlConnection("Data Source = 184.168.47.10; Integrated Security = False; User ID = MobileDaddy; PASSWORD = Aa54380438!; Connect Timeout = 15; Encrypt = False; Packet Size = 4096 ;");
        aCon.Open();
        string aSQLStr = "";

        for (int i = 0; i < aAllFavourite.Length; i++)
        {
            aSQLStr = string.Format("SELECT * FROM StockList WHERE StockNumber='{0}'",aAllFavourite[i]);

            using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
            {
                SqlDataReader aRd = aCmd.ExecuteReader();
                bool aFind = false;
                FavouriteData aTmpData = new FavouriteData();
                while (aRd.Read())
                {
                    aTmpData.NowPrice = aRd["DealPrice"].ToString().Replace(" ","") ;
                    aTmpData.RangePrice = aRd["PriceRange"].ToString().Replace(" ", "");
                    aTmpData.StockName = aRd["StockName"].ToString().Replace(" ", "");
                    aTmpData.YesterdayPrice = aRd["Yesterday"].ToString().Replace(" ", "");
                    aFind = true;
                }
                aRd.Close();
                //代表SQL表單內還沒有這單號
                if (aFind == false)
                {
                    aTmpData = GetStcokData(aAllFavourite[i]);
                }
                aData.Add(aTmpData);
            }
        }

        //for (int i = 0; i < aAllFavourite.Length; i++)
        //{
        //    if (aAllFavourite[i] == "")
        //        continue;

        //    using (WebClient aWC = new WebClient())
        //    {
        //        string aUrl = "http://www.mobiledaddy.net/StockWeb/Model/GetStockData.aspx?Number=" + aAllFavourite[i];

        //        string aJsonStr = aWC.DownloadString(aUrl);

        //        if (aJsonStr == "")
        //            break;

        //        //0.代碼 1.時間(不需要) 2.成交價 3.買進價 4.賣出價 5.漲跌 6.張數 7.昨收 8.開盤 9.最高 10.最低
        //        StockData aJsonData = JsonConvert.DeserializeObject<StockData>(aJsonStr);

        //        FavouriteData aTmpData = new FavouriteData();

        //        aTmpData.NowPrice = aJsonData.StockValue[2];
        //        aTmpData.RangePrice = aJsonData.StockValue[5];
        //        aTmpData.StockName = aJsonData.StockValue[0];
        //        aTmpData.YesterdayPrice = aJsonData.StockValue[7];

        //        aData.Add(aTmpData);
        //        aWC.Dispose();
        //    }
        //}
        AllFavourite aAllData = new AllFavourite();

        aAllData.total = aData.Count;
        aAllData.rows = aData.ToArray();

        string aJson = JsonConvert.SerializeObject(aAllData);

        aCon.Close();

        Response.Write(aJson);

    }

    private string[] GetFavourite(string iAccount)
    {
        string[] aTmp = null;
        List<string> aFavourite = new List<string>();

        HttpCookie aCookie = Request.Cookies["FavouriteData"];

        aTmp = aCookie.Value.Split(Convert.ToChar(","));

        for (int i = 0; i < aTmp.Length; i++)
        {
            if (aTmp[i] != "")
                aFavourite.Add(aTmp[i]);
        }

        return aFavourite.ToArray();
    }

    private FavouriteData GetStcokData(string iNumber)
    {
        FavouriteData aTmpData = new FavouriteData();
        using (WebClient aWC = new WebClient())
        {
            string aUrl = "http://www.mobiledaddy.net/StockWeb/Model/GetStockData.aspx?Number=" + iNumber;

            string aJsonStr = aWC.DownloadString(aUrl);

            if (aJsonStr == "")
                return null;

            //0.代碼 1.時間(不需要) 2.成交價 3.買進價 4.賣出價 5.漲跌 6.張數 7.昨收 8.開盤 9.最高 10.最低
            StockData aJsonData = JsonConvert.DeserializeObject<StockData>(aJsonStr);

            aTmpData.NowPrice = aJsonData.StockValue[2];
            aTmpData.RangePrice = aJsonData.StockValue[5];
            aTmpData.StockName = aJsonData.StockValue[0];
            aTmpData.YesterdayPrice = aJsonData.StockValue[7];
            aWC.Dispose();
        }

        return aTmpData;
    }
}