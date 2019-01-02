using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuoteLogin
{
    public partial class BuybackForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            for (int i = 0; i < PowerCheckl.Items.Count; i++)
            {
                PowerCheckl.Items[i].Attributes.Add("onclick", "MutExChkList(this)");
            }
            for (int i = 0; i < ScuffCheckl.Items.Count; i++)
            {
                ScuffCheckl.Items[i].Attributes.Add("onclick", "MutExChkList(this)");
            }
            for (int i = 0; i < LiquidCheckl.Items.Count; i++)
            {
                LiquidCheckl.Items[i].Attributes.Add("onclick", "MutExChkList(this)");
            }
            for (int i = 0; i < FindCheckl.Items.Count; i++)
            {
                FindCheckl.Items[i].Attributes.Add("onclick", "MutExChkList(this)");
            }
            for (int i = 0; i < GmailCheckl.Items.Count; i++)
            {
                GmailCheckl.Items[i].Attributes.Add("onclick", "MutExChkList(this)");
            }
            for (int i = 0; i < CrackCheckl.Items.Count; i++)
            {
                CrackCheckl.Items[i].Attributes.Add("onclick", "MutExChkList(this)");
            }
        }

        protected void PrintButton_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "CallPrint", "PrintPanel()", true);
        }

        protected void CalcButton_Click(object sender, EventArgs e)
        {

        }
    }
}