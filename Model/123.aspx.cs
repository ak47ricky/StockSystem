using HtmlAgilityPack;
using System.Data.Linq.Mapping; //for [Table(Name = "AllLineBusData")]
using System.Data.SqlClient; // for SQL
using System.Data.Linq; //for DataContext
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Model_Testaspx : System.Web.UI.Page
{
    //public class DataContext : IDisposable
    [Table(Name = "MessageBoard")]
    public class Product
    {
        public Product()
        {
        }
        public Product(string iAccount, int iStatus)
        {
            this.Account = iAccount;
            this.Status = iStatus;
        }
        [Column]
        public string Account { get; set; }
        public int Status { get; set; }

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        List<string> aList = new List<string>();

        SqlConnection conn = new SqlConnection(
                   "Data Source = 184.168.47.10; Integrated Security = False; User ID = MobileDaddy; PASSWORD = Aa54380438!; Connect Timeout = 15; Encrypt = False; Packet Size = 4096 ;");
        DataContext dc = new DataContext(conn);
        Table<Product> table = dc.GetTable<Product>();

        var temp =
            from x in table
            where x.Account == "Ricky"
            select x;

        foreach (var cust in temp)
        {
            aList.Add(string.Format("Name = {0} , Status{1}", cust.Account, cust.Status));
        }
        Response.Write(aList);

    }
}