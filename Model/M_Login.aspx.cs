using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Model_M_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string aKind = Request["Kind"].ToString();

            if (aKind == "1")
            {
                string aAccount = Request["Account"].ToString();
                string aPassword = Request["Password"].ToString();

                int aResult = CheckAccount(aAccount, aPassword);

                if (aResult == 0)
                {
                    //產生一個Cookie
                    HttpCookie aNickNameCookie = new HttpCookie("FavouriteData");
                    //設定單值
                    aNickNameCookie.Value = GetFavourite();
                    //設定過期日
                    aNickNameCookie.Expires = DateTime.Now.AddDays(1);
                    //寫到用戶端
                    Response.Cookies.Add(aNickNameCookie);
                }

                Response.Write(aResult);
            }
            else
            {
                Session.Abandon();
                Response.Write("0");
            }

        }
        catch
        {
            //參數錯誤
            Response.Write("1");
        }
    }
    //2無此帳號1密碼錯誤0帳號密碼正確
    private int CheckAccount(string iAccount,string iPassword)
    {
        int aFind = 2;
        using (SqlConnection aCon = new SqlConnection("Data Source = 184.168.47.10; Integrated Security = False; User ID = MobileDaddy; PASSWORD = Aa54380438!; Connect Timeout = 15; Encrypt = False; Packet Size = 4096 ;"))
        {
            aCon.Open();
            string aSQLStr = string.Format("SELECT * FROM StockAccount WHERE Account='{0}'",iAccount);
            using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
            {
                SqlDataReader aDr = aCmd.ExecuteReader();
                while (aDr.Read())
                {
                    if (aDr["Password"].ToString() == iPassword)
                    {
                        aFind = 0;
                        //Session["NickName"] = aDr["NickName"].ToString();
                        //產生一個Cookie
                        HttpCookie aNickNameCookie = new HttpCookie("NickName");
                        //設定單值
                        aNickNameCookie.Value = aDr["NickName"].ToString();
                        //設定過期日
                        aNickNameCookie.Expires = DateTime.Now.AddDays(1);
                        //寫到用戶端
                        Response.Cookies.Add(aNickNameCookie);

                        //產生一個Cookie
                        HttpCookie aAccountCookie = new HttpCookie("Account");
                        //設定單值
                        aAccountCookie.Value = iAccount;
                        //設定過期日
                        aAccountCookie.Expires = DateTime.Now.AddDays(1);
                        //寫到用戶端
                        Response.Cookies.Add(aAccountCookie);
                    }
                        
                    else
                        aFind = 1;

                }
            }
            
            aCon.Close();
        }

        return aFind;
    }

    private string GetFavourite()
    {
        string aFavourite = null;

        HttpCookie aAccount = Request.Cookies["Account"];

        using (SqlConnection aCon = new SqlConnection("Data Source = 184.168.47.10; Integrated Security = False; User ID = MobileDaddy; PASSWORD = Aa54380438!; Connect Timeout = 15; Encrypt = False; Packet Size = 4096 ;"))
        {
            aCon.Open();
            string aSQLStr = string.Format("SELECT * FROM StockAccount WHERE Account='{0}'", aAccount.Value);
            using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
            {
                SqlDataReader aRd = aCmd.ExecuteReader();
                while (aRd.Read())
                {
                    string aData = aRd["Favourite"].ToString();
                    aFavourite = aData;
                }
            }
        }

        return aFavourite;
    }
}