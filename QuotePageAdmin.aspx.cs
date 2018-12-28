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
    public partial class QuotePageAdmin : System.Web.UI.Page
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
                }
                else if (PreviousPage is QuoteConfirmationPage qcp)
                {
                    qcs.EmpID = qcp.EmpID;
                    qcs.CustID = qcp.CustID;
                    qcs.PermID = qcp.PermID;
                }
                else
                {
                    Response.Redirect("~/CustomerPage.aspx");
                }
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString());
                SqlCommand sqlCommand = new SqlCommand("SELECT [CustID], [F_Name], [L_Name] FROM [Customer] WHERE [CustID] = @CustID", con);
                sqlCommand.Parameters.AddWithValue("@CustID", qcs.CustID);

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                DataTable dataTable = new DataTable();
                con.Open();
                sqlDataAdapter.Fill(dataTable);
                sqlCommand.ExecuteNonQuery();
                CustomerLabel.Text = dataTable.Rows[0]["F_Name"].ToString() + " " + dataTable.Rows[0]["L_Name"].ToString();
                con.Close();
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

                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString());
                SqlCommand categoryCmd = new SqlCommand("SELECT Labor FROM [Pricing] WHERE PriceID = @Price", con);
                SqlParameter categoryP = new SqlParameter("@Price", CategoryDropDownList.SelectedValue);
                categoryCmd.Parameters.Add(categoryP);

                SqlCommand marginCmd = new SqlCommand("SELECT [Percent] AS P FROM [Margin] WHERE MarginID = @Margin", con);
                SqlParameter marginP = new SqlParameter("@Margin", MarginDropDownList.SelectedValue);
                marginCmd.Parameters.Add(marginP);

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

        protected void SignoutButton_Click(object sender, EventArgs e)
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

        protected void BackButton_Click(object sender, EventArgs e)
        {
            // (TO-DO) Base class/function needed
            if (Page.User.Identity.IsAuthenticated)
            {
                Server.Transfer("~/CustomerPage.aspx");
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
            qcs.Make = MakeText.Text;
            qcs.Model = ModelText.Text;
            qcs.Issue = IssueTextBox.Text;
            Server.Transfer("QuoteConfirmationPage.aspx");
        }
    }
}