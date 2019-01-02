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
using System.Web.UI.WebControls;
using System.Text;
using System.IO;

namespace QuoteLogin
{
    public partial class QuoteViewPage : System.Web.UI.Page
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
        public bool ViewingHistory
        {
            get { return qcs.ViewingHistory; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
            if (!IsPostBack)
            {
                if (PreviousPage is DefaultScreen ds)
                {
                    qcs.EmpID = ds.EmpID;
                    qcs.PermID = ds.PermID;
                }
                else
                {
                    Response.Redirect("~/DefaultScreen.aspx");
                }
                QuoteGridView.DataBind();
                PrintDetailsView.DataBind();
                if (qcs.PermID < 4)
                {
                    DeleteButton.Visible = true;
                }
                QuoteSelectedPanel.Visible = false;
            }
            if (QuoteGridView.SelectedIndex > -1)
            {
                PrintButton.Visible = true;
            }
            
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
            Response.Cache.SetNoStore();
        }

        protected void DeleteQuoteButton_Click(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                QuoteDataSource.Delete();
                QuoteGridView.DataBind();
                QuoteSelectedPanel.Visible = false;
            }
            else
            {
                FormsAuthentication.RedirectToLoginPage();
            }
        }

        protected void QuoteGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            QuoteSelectedPanel.Visible = true;
            PrintButton.Visible = true;
            qcs.QuoteID = (int)QuoteGridView.SelectedValue;
        }

        protected void PageBackButton_Click(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                Response.Redirect("DefaultScreen.aspx");
                
            }
            else
            {
                FormsAuthentication.RedirectToLoginPage();
            }
        }

        protected void PageSignOutButton_Click(object sender, EventArgs e)
        {
            // Back to sign in page
            Session.Clear();
            Session.Abandon();
            Session.RemoveAll();

            FormsAuthentication.SignOut();
            HttpContext.Current.User = new GenericPrincipal(new GenericIdentity(string.Empty), null);
            FormsAuthentication.RedirectToLoginPage();
        }

        protected void QuoteGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Sets cells invisible if below admin privileges. 
                // Makes Margin, Pricing, and Base Prices invisible for managers and employees.
                if (qcs.PermID > 1)
                {
                    for (int i = 0; i < QuoteGridView.Columns.Count; i++)
                    {
                        DataControlField col = QuoteGridView.Columns[i];
                        if (col.HeaderText == "Margin" || col.HeaderText == "Pricing" || col.HeaderText == "Labor" || col.HeaderText == "Base_Price")
                        {
                            QuoteGridView.HeaderRow.Cells[i].Visible = false;
                            e.Row.Cells[i].Visible = false;
                        }
                    }
                }
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(QuoteGridView, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void PrintButton_Click(object sender, EventArgs e)
        {
            PrintDetailsView.DataBind();
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            Control parent = PrintDetailsView.Parent;
            int GridIndex= 0;
            if (parent != null)
            {
                GridIndex = parent.Controls.IndexOf(PrintDetailsView);
                parent.Controls.Remove(PrintDetailsView);
            }
            
            PrintDetailsView.RenderControl(hw);
            if (parent != null)
            {
                parent.Controls.AddAt(GridIndex, PrintDetailsView);
            }

            string gridHTML = sw.ToString().Replace("\"", "'").Replace(System.Environment.NewLine, "");
            StringBuilder sb = new StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload = new function(){");
            sb.Append("var printWin = window.open('', '', 'left=0");
            sb.Append(",top=0,width=1000,height=600,status=0');");
            sb.Append("printWin.document.write(\"");
            sb.Append(gridHTML);
            sb.Append("\");");
            //sb.Append("printWin.document.close();");
            sb.Append("printWin.focus();");
            sb.Append("printWin.print();};");
            //sb.Append("printWin.close();};");
            sb.Append("</script>");
            ClientScript.RegisterStartupScript(this.GetType(), "GridPrint", sb.ToString());
            PrintDetailsView.DataBind();
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            QuoteDataSource.Delete();
            QuoteGridView.DataBind();
            QuoteGridView.SelectedIndex = -1;
            QuoteSelectedPanel.Visible = false;
        }

        protected void ServiceRequestButton_Click(object sender, EventArgs e)
        {
            // CREATES ServiceRequest from Quote
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString()))
            {
                con.Open();
                getQuoteInfo(con);
                con.Close();
            }
            qcs.ViewingHistory = false;
            Server.Transfer("ServiceRequestPage.aspx");
        }

        // Gets Quote information based on the QuoteID saved on the control state, requires open connection
        private void getQuoteInfo(SqlConnection con)
        {
            SqlCommand cmd = new SqlCommand("SELECT QV.[CustFName], QV.[CustLName], QV.[Final_Price], QV.[Issue], QV.[Make], QV.[Model], C.[Phone], C.[Email] FROM [QuoteView] QV, [Customer] C, [Quote] Q WHERE QV.[QuoteID] = @QuoteID AND Q.[CustID] = C.[CustID]", con);
            cmd.Parameters.AddWithValue("@QuoteID", qcs.QuoteID);
            DataTable dataTable = new DataTable();
            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
            sqlDataAdapter.Fill(dataTable);
            qcs.FinalPrice = (decimal)dataTable.Rows[0]["Final_Price"];
            qcs.CustPhone = dataTable.Rows[0]["Phone"].ToString();
            qcs.CustEmail = dataTable.Rows[0]["Email"].ToString();
            qcs.Issue = dataTable.Rows[0]["Issue"].ToString();
            qcs.CustFName = dataTable.Rows[0]["CustFName"].ToString().Trim();
            qcs.CustLName = dataTable.Rows[0]["CustLName"].ToString().Trim();
            qcs.Make = dataTable.Rows[0]["Make"].ToString();
            qcs.Model = dataTable.Rows[0]["Model"].ToString();
        }

        protected void ViewTypeDropdown_SelectedIndexChanged(object sender, EventArgs e)
        {
            string viewType = ViewTypeDropdown.SelectedValue;
            
            switch (viewType)
            {
                case "Service Request":
                    ServiceReqViewPanel.Visible = true;
                    QuoteViewPanel.Visible = false;
                    QuoteSelectedPanel.Visible = false;
                    break;
                case "Quote":
                    QuoteViewPanel.Visible = true;
                    ServiceReqViewPanel.Visible = false;
                    SRSelectedPanel.Visible = false;
                    break;
            }
        }

        protected void ServiceReqGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(ServiceReqGridView, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select service request.";
            }
        }

        protected void ServiceReqGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            SRSelectedPanel.Visible = true;
            qcs.ServReqID = (int)ServiceReqGridView.SelectedValue;
            Label deviceTypeLabel = ServiceReqGridView.SelectedRow.FindControl("DeviceTypeLabel") as Label;
            qcs.ServReqType = deviceTypeLabel.Text.Trim();
        }

        // View PREVIOUSLY MADE Service Request
        protected void ViewSRButton_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM [ServiceRequestView] WHERE [Service_Request_ID] = @ID AND [Device_Type] = @DeviceType", con);
                cmd.Parameters.AddWithValue("@ID", qcs.ServReqID);
                cmd.Parameters.AddWithValue("@DeviceType", qcs.ServReqType);
                con.Open();
                DataTable dataTable = new DataTable();
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                sqlDataAdapter.Fill(dataTable);
                qcs.StoreID = (int)dataTable.Rows[0]["StoreID"];
                //getQuoteInfo(con);
                con.Close();
                qcs.ViewingHistory = true;
                Server.Transfer("ServiceRequestPage.aspx");
                
            }
        }
    }
}