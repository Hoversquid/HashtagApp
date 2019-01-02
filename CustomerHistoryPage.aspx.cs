using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration;

namespace QuoteLogin
{
    public partial class CustomerHistoryPage : System.Web.UI.Page
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
        public int QuoteID
        {
            get { return qcs.QuoteID; }
        }
        public int ServReqID
        {
            get { return qcs.ServReqID; }
        }
        public string ServReqType
        {
            get { return qcs.ServReqType; }
        }
        public int StoreID
        {
            get { return qcs.StoreID; }
        }
        public decimal FinalPrice
        {
            get { return qcs.FinalPrice; }
        }
        public string Model
        {
            get { return qcs.Model; }
        }
        public string Make
        {
            get { return qcs.Make; }
        }
        public string CustFName
        {
            get { return qcs.CustFName; }
        }
        public string CustLName
        {
            get { return qcs.CustLName; }
        }
        public string Issue
        {
            get { return qcs.Issue; }
        }
        public string CustEmail
        {
            get { return qcs.CustEmail; }
        }
        public string CustPhone
        {
            get { return qcs.CustPhone; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
            if (!IsPostBack)
            {
                
                if (PreviousPage is CustomerPage cp)
                {
                    qcs.CustID = cp.CustID;
                    qcs.EmpID = cp.EmpID;
                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString()))
                    {
                        SqlCommand sqlCommand = new SqlCommand("SELECT [CustID], [F_Name], [L_Name] FROM [Customer] WHERE [CustID] = @CustID", con);
                        sqlCommand.Parameters.AddWithValue("@CustID", qcs.CustID);

                        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                        DataTable dataTable = new DataTable();
                        con.Open();
                        sqlDataAdapter.Fill(dataTable);
                        //sqlCommand.ExecuteNonQuery();
                        SelectedCustomerLabel.Text = dataTable.Rows[0]["F_Name"].ToString() + " " + dataTable.Rows[0]["L_Name"].ToString();
                        con.Close();
                    }
                }
            }

            LoadControlState(qcs);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
            Response.Cache.SetNoStore();
        }

        protected void QuoteHistoryGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(QuoteHistoryGridView, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void SRHistoryGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(SRHistoryGridView, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void QuoteHistoryGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            qcs.QuoteID = (int)QuoteHistoryGridView.SelectedValue;
            QuoteHistoryDataSource.DataBind();
            QuoteDetailsViewPanel.Visible = true;
            PrintQuotePanel.Visible = true;
            SelectSRPanel.Visible = false;
        }

        protected void SRHistoryGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            qcs.ServReqID = (int)SRHistoryGridView.SelectedValue;
            Label deviceTypeLabel = SRHistoryGridView.SelectedRow.FindControl("DeviceTypeLabel") as Label;
            qcs.ServReqType = deviceTypeLabel.Text.Trim();

            SelectSRPanel.Visible = true;
            QuoteDetailsViewPanel.Visible = false;
            PrintQuotePanel.Visible = false;
        }

        protected void SRSelectButton_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("SELECT [StoreID] FROM [ServiceRequestView] WHERE [Service_Request_ID] = @ID AND [Device_Type] = @DeviceType", con);
                cmd.Parameters.AddWithValue("@ID", qcs.ServReqID);
                cmd.Parameters.AddWithValue("@DeviceType", qcs.ServReqType);
                con.Open();
                DataTable dataTable = new DataTable();
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                sqlDataAdapter.Fill(dataTable);
                qcs.StoreID = (int)dataTable.Rows[0]["StoreID"];
                //getQuoteInfo(con);
                con.Close();

            }
            Server.Transfer("~/ServiceRequestPage.aspx");
        }

        protected void QuoteSelectButton_Click(object sender, EventArgs e)
        {

        }

        protected void PageBackButton_Click(object sender, EventArgs e)
        {
            Server.Transfer("~/CustomerPage.aspx");
        }

        protected void PageSignOutButton_Click(object sender, EventArgs e)
        {

        }

        protected void PrintQuoteButton_Click(object sender, EventArgs e)
        {

        }
    }
}