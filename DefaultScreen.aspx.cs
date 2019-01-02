using System;
using System.Collections.Generic;
using System.Linq;
using System.Configuration;
using ControlLibrary.Controls;
using System.Data;
using System.Data.SqlClient;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuoteLogin
{
    public partial class DefaultScreen : System.Web.UI.Page
    {
        // Public properties are used in all of the pages to retain control state between transfers
        // The program returns to this page any time the program is used out of sequence
        public QuoteControlState QCState
        {
            get { return qcs; }
        }
        public int PermID
        {
            get { return qcs.PermID; }
        }
        public int EmpID
        {
            get { return qcs.EmpID; }
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
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString()))
                {
                    // Gets UserID and PermissionsID to login and start to build the QuoteControlState
                    SqlCommand userCmd = new SqlCommand("SELECT U.[UserID], U.[EmpID], PT.[PermTypeID] " +
                        "FROM [User] U, [UserPermissions] UP, [PermissionsType] PT " +
                        "WHERE U.[UserID] = UP.[UserID] AND UP.[TypeID] = PT.[PermTypeID]" +
                        " AND U.[UserID] = @UserID", con);
                    SqlParameter userP = new SqlParameter("@UserID", Page.User.Identity.Name);
                    userCmd.Parameters.Add(userP);

                    SqlDataAdapter adapter = new SqlDataAdapter(userCmd);
                    DataTable table = new DataTable();
                    con.Open();
                    adapter.Fill(table);
                    userCmd.ExecuteNonQuery();
                    con.Close();
                    qcs.EmpID = (int)table.Rows[0]["EmpID"];
                    qcs.PermID = (int)table.Rows[0]["PermTypeID"];
                    qcs.IsQuickQuote = false;
                }

                // If PermissionsID (PermID) is not the Admin or Senior Manager (PermID = 1 or 2), then remove some page access
                if (qcs.PermID >= 3)
                {
                    EditPricingPageButton.Visible = false;
                }
                if (qcs.PermID >= 4)
                {
                    EditLoginPageButton.Visible = false;
                }

                // If Employee is of lowest level permissions type, disable access to Quotes
                // Employees still need access to customer information, so access will have to be altered on that page until that functionality is seperated into their own pages
                if (qcs.PermID > 4)
                {
                    QuickQuoteButton.Visible = false;
                }

            }
            LoadControlState(qcs);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
            Response.Cache.SetNoStore();
        }

        protected void QuoteButton_Click(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                Response.Redirect("QuotePage.aspx");
            }
        }

        protected void EditLoginButton_Click(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                Server.Transfer("~/LoginEditPage.aspx");
            }
        }

        protected void EditPricingButton_Click(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                Server.Transfer("AdminPricingEdit.aspx");
            }
        }
        protected void NewQuotePageButton_Click(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                qcs.IsQuickQuote = false;
                Server.Transfer("CustomerPage.aspx");
            }
        }

        protected void SignOutButton_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Session.RemoveAll();

            FormsAuthentication.SignOut();
            HttpContext.Current.User = new GenericPrincipal(new GenericIdentity(string.Empty), null);
            FormsAuthentication.RedirectToLoginPage();
        }

        protected void QuoteViewPageButton_Click(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                Server.Transfer("QuoteViewPage.aspx");
            }
        }

        protected void ServiceRequestFormButton_Click(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                Server.Transfer("ServiceRequestPage.aspx");
            }
        }

        protected void QuickQuoteButton_Click(object sender, EventArgs e)
        {
            qcs.IsQuickQuote = true;
            Server.Transfer("/QuotePage.aspx");
        }

        protected void ProceduresButton_Click(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                Server.Transfer("ProcedureChecklist.aspx");
            }
        }
    }
}