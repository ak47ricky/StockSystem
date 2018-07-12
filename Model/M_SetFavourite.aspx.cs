using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Model_M_SetFavourite : System.Web.UI.Page
{
    private string aSQLConStr = "Data Source = 184.168.47.10; Integrated Security = False; User ID = MobileDaddy; PASSWORD = Aa54380438!; Connect Timeout = 15; Encrypt = False; Packet Size = 4096 ;";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string aStockNumber = Request["Number"].ToString();
            string aKind = Request["Kind"].ToString();

            HttpCookie aCookieAC = Request.Cookies["Account"];

            string aAccount = aCookieAC.Value;

            //沒有帳號
            if (aAccount == null || aAccount == "")
            {
                Response.Write("2");
                return;
            }

            if (aKind == "1")
                AddFavourite(aStockNumber,aAccount);
            else
                RemoveFavourite(aStockNumber, aAccount);

            Response.Write("0");
            
        }
        catch(Exception ex)
        {
            //參數錯誤
            Response.Write("1");
        }
    }

    private void AddFavourite(string iNumber,string iAccount)
    {
        string[] aFavourite = GetFavourite();

        string aSQLStr = string.Empty;

        List<string> aFavouriteList = new List<string>();

        if (aFavourite != null)
        {
            for (int i = 0; i < aFavourite.Length; i++)
                aFavouriteList.Add(aFavourite[i]);
        }

        aFavouriteList.Add(iNumber);

        string aSqlFavourite = string.Empty;

        for (int i = 0; i < aFavouriteList.Count; i++)
            aSqlFavourite += aFavouriteList[i] + ",";


        using (SqlConnection aCon = new SqlConnection(aSQLConStr))
        {
            aCon.Open();
            //代表裡面有資料

            aSQLStr = string.Format("UPDATE StockAccount SET Favourite = '{0}' WHERE Account='{1}'", aSqlFavourite, iAccount);

            using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
            {
                aCmd.ExecuteNonQuery();
            }
        }

        SetSessionFavourite(aSqlFavourite);
    }

    private void RemoveFavourite(string iNumber, string iAccount)
    {
        string[] aFavourite = GetFavourite();

        List<string> aFavouriteList = new List<string>();

        for (int i = 0; i < aFavourite.Length; i++)
        {
            if (aFavourite[i] == iNumber)
                continue;
            aFavouriteList.Add(aFavourite[i]);
        }
        
        string aSqlFavourite = string.Empty;

        for (int i = 0; i < aFavouriteList.Count; i++)
        {
            if (aFavouriteList[i] == "")
                continue;

            aSqlFavourite += aFavouriteList[i] + ",";
        }

        aSqlFavourite.Replace(" ,","");

        using (SqlConnection aCon = new SqlConnection(aSQLConStr))
        {
            aCon.Open();

            string aSQLStr = string.Format("UPDATE StockAccount SET Favourite = '{0}' WHERE Account='{1}'", aSqlFavourite, iAccount);

            using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
            {
                aCmd.ExecuteNonQuery();
            }
        }

        SetSessionFavourite(aSqlFavourite);
    }

    private void SetSessionFavourite(string iFavourite)
    {
        HttpCookie aCookie = Request.Cookies["FavouriteData"];

        aCookie.Value = iFavourite;

        //設定過期日
        aCookie.Expires = DateTime.Now.AddDays(1);
        //寫到用戶端
        Response.Cookies.Add(aCookie);
    }

    private string[] GetFavourite()
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
}