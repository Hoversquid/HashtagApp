using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuoteLogin
{
    public partial class AdminLoginEdit : System.Web.UI.Page
    {
        // (TO-DO) This and AdminLoginEdit need to have a base page for similiar functionality.
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
                    if (qcs.PermID == 1)
                    {
                        LoginGridView.DataBind();
                        EditLoginActionNoUserPanel.Visible = true;
                        EditLoginActionUserSelectedPanel.Visible = false;
                        CheckForVisibility();
                    }
                    else
                    {
                        Response.Redirect("~/LoginEditPage.aspx");
                    }
                }
                else
                {

                    Response.Redirect("~/DefaultScreen.aspx");
                }
            }

            LoadControlState(qcs);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
            Response.Cache.SetNoStore();

        }
        protected void EditUserButton_Click(object sender, EventArgs e)
        {
            
        }
        protected void PermEditButton_Click(object sender, EventArgs e)
        {

        }

        protected void EditPassButton_Click(object sender, EventArgs e)
        {

        }

        protected void LoginEditBackButton_Click(object sender, EventArgs e)
        {
            // (TO-DO) Base class/function needed.
            if (Page.User.Identity.IsAuthenticated)
            {
                Response.Redirect("DefaultScreen.aspx");
            }
            else
            {
                FormsAuthentication.RedirectToLoginPage();
            }
        }

        protected void LoginEditSignoutButton_Click(object sender, EventArgs e)
        {
            // (TO-DO) Base class/function needed.
            Session.Clear();
            Session.Abandon();
            Session.RemoveAll();

            FormsAuthentication.SignOut();
            HttpContext.Current.User = new GenericPrincipal(new GenericIdentity(string.Empty), null);
            FormsAuthentication.RedirectToLoginPage();
        }

        protected void EditEmployeeButton_Click(object sender, EventArgs e)
        {
            if (EditEmployee.Text.Length != 0)
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString()))
                {
                    SqlCommand command = new SqlCommand(
                    "UPDATE [Employee] SET [Name] = @EmpName FROM [User], [Employee] WHERE [User].[UserID] = @UserID AND [User].[EmpID] = [Employee].[EmpID]", con);
                    SqlParameter EmpName = new SqlParameter
                    {
                        ParameterName = "@EmpName",
                        Value = EditEmployee.Text
                    };
                    command.Parameters.Add(EmpName);
                    SqlParameter UserID = new SqlParameter
                    {
                        ParameterName = "@UserID",
                        Value = LoginGridView.SelectedValue
                    };
                    command.Parameters.Add(UserID);
                    con.Open();
                    command.ExecuteNonQuery();
                    LoginGridView.DataBind();
                    con.Close();
                }
            }
        }

        protected void AddUserButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (AddPassText1.Text == AddPassText2.Text)
                {
                    System.Diagnostics.Debug.WriteLine("Writing " + AddEmpText.Text + " with user name " + AddUserText.Text + " to DB.");
                    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString());
                    SqlCommand sqlCommand = new SqlCommand("CreateNewEmployee", con)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    sqlCommand.Parameters.AddWithValue("@EmpName", AddEmpText.Text);
                    sqlCommand.Parameters.AddWithValue("@UserName", AddUserText.Text);
                    sqlCommand.Parameters.AddWithValue("@Password", AddPassText1.Text);
                    sqlCommand.Parameters.AddWithValue("@PermissionsType", AddPermDropDown.SelectedValue);
                    con.Open();
                    sqlCommand.ExecuteNonQuery();
                    con.Close();
                    LoginGridView.DataBind();
                }
            }
        }

        protected void EditLoginAction_SelectedIndexChanged(object sender, EventArgs e)
        {
            EditLoginActionNoUserPanel.Visible = false;
            EditLoginActionUserSelectedPanel.Visible = true;
            AddUserPanel.Visible = false;
            EditEmployeePanel.Visible = false;
            UserNameEditPanel.Visible = false;
            PermEditPanel.Visible = false;
            PassEditPanel.Visible = false;
            DeleteEditPanel.Visible = false;
            switch (EditLoginAction.SelectedValue)
            {
                case "Add New User":
                    AddUserPanel.Visible = true;
                    break;
                case "Edit Employee Name":
                    EditEmployeePanel.Visible = true;
                    break;
                case "Edit User Name":
                    UserNameEditPanel.Visible = true;
                    break;
                case "Edit Permissions":
                    PermEditPanel.Visible = true;
                    break;
                case "Edit Password":
                    PassEditPanel.Visible = true;
                    break;
                case "Delete Entry":
                    DeleteEditPanel.Visible = true;
                    break;
                default:
                    break;
            }
        }

        protected void AddUserAction_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (AddUserAction.SelectedValue)
            {
                case "Add New User":
                    AddUserPanel.Visible = true;
                    break;

                default:
                    AddUserPanel.Visible = false;
                    break;
            }
        }
        

        private void CheckForVisibility()
        {
            string action = EditLoginAction.SelectedValue;
            if (action == "Add New User")
            {
                AddUserPanel.Visible = true;
                EditEmployeePanel.Visible = false;
                UserNameEditPanel.Visible = false;
                PermEditPanel.Visible = false;
                PassEditPanel.Visible = false;
                DeleteEditPanel.Visible = false;
            }
            else if (action == "Edit Employee Name")
            {
                AddUserPanel.Visible = false;
                EditEmployeePanel.Visible = true;
                UserNameEditPanel.Visible = false;
                PermEditPanel.Visible = false;
                PassEditPanel.Visible = false;
                DeleteEditPanel.Visible = false;
            }
            else if (action == "Edit User Name")
            {
                AddUserPanel.Visible = false;
                EditEmployeePanel.Visible = false;
                UserNameEditPanel.Visible = true;
                PermEditPanel.Visible = false;
                PassEditPanel.Visible = false;
                DeleteEditPanel.Visible = false;
            }
            else if (action == "Edit Permissions")
            {
                AddUserPanel.Visible = false;
                EditEmployeePanel.Visible = false;
                UserNameEditPanel.Visible = false;
                PermEditPanel.Visible = true;
                PassEditPanel.Visible = false;
                DeleteEditPanel.Visible = false;
            }
            else if (action == "Edit Password")
            {
                AddUserPanel.Visible = false;
                EditEmployeePanel.Visible = false;
                UserNameEditPanel.Visible = false;
                PermEditPanel.Visible = false;
                PassEditPanel.Visible = true;
                DeleteEditPanel.Visible = false;
            }
            else if (action == "Delete Entry")
            {
                AddUserPanel.Visible = false;
                EditEmployeePanel.Visible = false;
                UserNameEditPanel.Visible = false;
                PermEditPanel.Visible = false;
                PassEditPanel.Visible = false;
                DeleteEditPanel.Visible = true;
            }
            else
            {
                AddUserPanel.Visible = false;
                EditEmployeePanel.Visible = false;
                UserNameEditPanel.Visible = false;
                PermEditPanel.Visible = false;
                PassEditPanel.Visible = false;
                DeleteEditPanel.Visible = false;
            }
        }

        protected void LoginGridView_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("Changing to " + e.NewSelectedIndex);

        }

        protected void LoginGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            EditLoginActionNoUserPanel.Visible = false;
            EditLoginActionUserSelectedPanel.Visible = true;
            AddUserPanel.Visible = false;
            EditEmployeePanel.Visible = false;
            UserNameEditPanel.Visible = false;
            PermEditPanel.Visible = false;
            PassEditPanel.Visible = false;
            DeleteEditPanel.Visible = false;
            System.Diagnostics.Debug.WriteLine("Index changed.");
        }

        protected void LoginGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(LoginGridView, "Select$" + e.Row.RowIndex);
                    e.Row.ToolTip = "Click to select this row.";
                }
        }
    }
}