using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Model_M_OrderSystem : System.Web.UI.Page
{
    SqlConnection mCon;


    protected void Page_Load(object sender, EventArgs e)
    {
        mCon = new SqlConnection("Data Source = 184.168.47.10; Integrated Security = False; User ID = MobileDaddy; PASSWORD = Aa54380438!; Connect Timeout = 15; Encrypt = False; Packet Size = 4096;");
        mCon.Open();
    }

    private void CheckListData(string iStockNumber)
    {
        string aSQLStr = string.Format("SELECT * FROM StockList WHERE StockNumber='{0}'", iStockNumber);
        int aCount = 0;

        using (SqlCommand aCmd = new SqlCommand(aSQLStr, mCon))
        {
            SqlDataReader aRr = aCmd.ExecuteReader();

            while (aRr.Read())
            {
                aCount++;
            }
        }
        //若沒有這筆資料就加入進去
        if (aCount > 0)
        {
            aSQLStr = string.Format("INSERT INTO StockList(StockNumber) VALUES('{0}')", iStockNumber);
            using (SqlCommand aCmd = new SqlCommand(aSQLStr, mCon))
            {
                aCmd.ExecuteNonQuery();
            }
        }
    }
}