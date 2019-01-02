using System;
using System.Collections.Generic;
using System.Linq;
using System.Configuration;
using System.Security.Principal;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using ControlLibrary.Controls;
using System.Web.UI.WebControls;

namespace QuoteLogin
{
    public partial class QuotePage : System.Web.UI.Page
    {
        public int EmpID
        {
            get { return qcs.EmpID; }
        }
        public int CustID
        {
            get { return qcs.CustID; }
        }
        public int PermID
        {
            get { return qcs.PermID; }
        }
        public int PricingID
        {
            get { return qcs.PricingID; }
        }
        public int MarginID
        {
            get { return qcs.MarginID; }
        }
        public string Make
        {
            get { return qcs.Make; }
        }
        public string Model
        {
            get { return qcs.Model; }
        }
        public string Issue
        {
            get { return qcs.Issue; }
        }
        public decimal BasePrice
        {
            get { return qcs.BasePrice; }
        }
        public decimal FinalPrice
        {
            get { return qcs.FinalPrice; }
        }
        public bool IsQuickQuote
        {
            get { return qcs.IsQuickQuote; }
        }
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }

            if (!IsPostBack)
            {
                if (PreviousPage is CustomerPage custP)
                {
                    qcs.PermID = custP.PermID;
                    qcs.EmpID = custP.EmpID;
                    qcs.CustID = custP.CustID;
                    qcs.IsQuickQuote = false;
                    CustInfoPanel.Visible = true;
                }
                else if (PreviousPage is QuoteConfirmationPage qcp)
                {
                    qcs.IsQuickQuote = qcp.IsQuickQuote;
                    if (!qcs.IsQuickQuote)
                    {
                        qcs.CustID = qcp.CustID;
                        CustInfoPanel.Visible = true;
                    }
                    else
                    {
                        QuickQuotePanel.Visible = true;
                    }

                    qcs.EmpID = qcp.EmpID;
                    qcs.PermID = qcp.PermID;
                }
                else if (PreviousPage is DefaultScreen ds && ds.IsQuickQuote)
                {
                    qcs.PermID = ds.PermID;
                    qcs.EmpID = ds.EmpID;
                    qcs.IsQuickQuote = true;
                    QuickQuotePanel.Visible = true;
                }
                else
                {
                    Response.Redirect("~/CustomerPage.aspx");
                }
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString());

                if (!qcs.IsQuickQuote)
                {
                    SqlCommand sqlCommand = new SqlCommand("SELECT [CustID], [F_Name], [L_Name] FROM [Customer] WHERE [CustID] = @CustID", con);
                    sqlCommand.Parameters.AddWithValue("@CustID", qcs.CustID);

                    SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    DataTable dataTable = new DataTable();
                    con.Open();
                    sqlDataAdapter.Fill(dataTable);
                    //sqlCommand.ExecuteNonQuery();
                    CustomerLabel.Text = dataTable.Rows[0]["F_Name"].ToString() + " " + dataTable.Rows[0]["L_Name"].ToString();
                    con.Close();
                }
            }
            LoadControlState(qcs);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
            Response.Cache.SetNoStore();
        }

        protected void CalculatePriceButton_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(PriceIn.Text))
            {
                decimal PriceValue = Decimal.Parse(PriceIn.Text);

                // Get DB values entered through the Pricing page
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString());

                SqlCommand categoryCmd = new SqlCommand("SELECT Labor FROM [Pricing] WHERE PriceID = @Price", con);
                categoryCmd.Parameters.AddWithValue("@Price", CategoryDropDownList.SelectedValue);

                SqlCommand marginCmd = new SqlCommand("SELECT [Percent] AS P FROM [Margin] WHERE MarginID = @Margin", con);
                marginCmd.Parameters.AddWithValue("@Margin", MarginDropDownList.SelectedValue);

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(categoryCmd);
                DataTable dataTable = new DataTable();

                con.Open();
                sqlDataAdapter.Fill(dataTable);
                categoryCmd.ExecuteNonQuery();
                decimal categoryAmt = (decimal)dataTable.Rows[0]["Labor"];

                dataTable = new DataTable();
                sqlDataAdapter = new SqlDataAdapter(marginCmd);
                sqlDataAdapter.Fill(dataTable);
                marginCmd.ExecuteNonQuery();
                decimal marginAmt = (decimal)dataTable.Rows[0]["P"];
                

                if (Decimal.Compare(PriceValue, 0) >= 0)
                {
                    decimal Price = (PriceValue + categoryAmt);
                    decimal Margin = marginAmt * Price;
                    decimal FinalPrice = decimal.Round((Price + Margin), 2, MidpointRounding.AwayFromZero);
                    qcs.BasePrice = decimal.Round(Convert.ToDecimal(PriceIn.Text), 2, MidpointRounding.AwayFromZero);
                    qcs.FinalPrice = FinalPrice;
                    FinalPriceField.Text = String.Format("{0:C0}", FinalPrice.ToString());
                }
                else
                {
                    FinalPriceField.Text = "Invalid price";
                }
            }
            else
            {
                FinalPriceField.Text = "Enter price";
            }
            Response.Cache.SetNoStore();
        }

        protected void PageSignOutButton_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Session.RemoveAll();

            FormsAuthentication.SignOut();
            HttpContext.Current.User = new GenericPrincipal(new GenericIdentity(string.Empty), null);
            FormsAuthentication.RedirectToLoginPage();
        }

        protected void ClearButton_Click(object sender, EventArgs e)
        {
            // Resets page
            PriceIn.Text = String.Empty;
            CategoryDropDownList.SelectedValue = "-1";
            MarginDropDownList.SelectedValue = "-1";
            MakeText.Text = String.Empty;
            ModelText.Text = String.Empty;
            IssueTextBox.Text = String.Empty;
            qcs.FinalPrice = 0;
            FinalPriceField.Text = String.Empty;
        }

        protected void EditPricingButton_Click(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                Response.Redirect("AdminPricingEdit.aspx");
            }
        }

        protected void EditLoginButton_Click(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                Response.Redirect("AdminLoginEdit.aspx");
            }
        }

        protected void PageBackButton_Click(object sender, EventArgs e)
        {
            // (TO-DO) Base class/function needed
            if (Page.User.Identity.IsAuthenticated)
            {
                if (qcs.IsQuickQuote)
                {
                    Server.Transfer("~/DefaultScreen.aspx");
                }
                else
                {
                    Server.Transfer("~/CustomerPage.aspx");
                }
                
            }
            else
            {
                FormsAuthentication.RedirectToLoginPage();
            }
        }

        protected void CreateQuoteButton_Click(object sender, EventArgs e)
        {
            qcs.PricingID = Int32.Parse(CategoryDropDownList.SelectedValue);
            qcs.MarginID = Int32.Parse(MarginDropDownList.SelectedValue);
            qcs.Make = MakeText.Text.Trim(' ');
            qcs.Model = ModelText.Text.Trim(' ');
            qcs.Issue = IssueTextBox.Text.Trim(' ');
            Server.Transfer("QuoteConfirmationPage.aspx");
        }
    }
}