using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Model_M_SignUp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string aAccount = Request["Account"].ToString();
            string aPassword = Request["Password"].ToString();
            string aEmail = Request["Email"].ToString();
            string aPhone = Request["Phone"].ToString();
            string aNickName = Request["NickName"].ToString();

            if (CheckAccount(aAccount) == true)
            {
                //帳號重複
                Response.Write("2");
            }
            else
            {
                using (SqlConnection aCon = new SqlConnection("Data Source = 184.168.47.10; Integrated Security = False; User ID = MobileDaddy; PASSWORD = Aa54380438!; Connect Timeout = 15; Encrypt = False; Packet Size = 4096 ;"))
                {
                    aCon.Open();
                    string aSQLStr = string.Format("INSERT INTO StockAccount (Account,Password,Email,Phone,NickName,RecTime,Money,Favourite) VALUES('{0}','{1}','{2}','{3}',N'{4}','{5}','{6}','')", aAccount,aPassword,aEmail,aPhone,aNickName,DateTime.Now.ToString("yyyy-MM-dd"),1000000);
                    using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
                    {
                        aCmd.ExecuteNonQuery();
                    }

                    aCon.Close();
                }
                Response.Write("0");
            }

        }
        catch
        {
            //參數錯誤
            Response.Write("1");
        }
    }

    private bool CheckAccount(string iAccount)
    {
        bool aFind = false;
        using (SqlConnection aCon = new SqlConnection("Data Source = 184.168.47.10; Integrated Security = False; User ID = MobileDaddy; PASSWORD = Aa54380438!; Connect Timeout = 15; Encrypt = False; Packet Size = 4096 ;"))
        {
            aCon.Open();
            string aSQLStr = string.Format("SELECT * FROM StockAccount WHERE Account='{0}'", iAccount);
            using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
            {
                SqlDataReader aRr = aCmd.ExecuteReader();
                while (aRr.Read())
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
}