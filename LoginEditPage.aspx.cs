using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace QuoteLogin
{
    public partial class LoginEditPage : System.Web.UI.Page
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
                // Gets properties from previous page
                if (PreviousPage is DefaultScreen ds)
                {
                    qcs.EmpID = ds.EmpID;
                    qcs.PermID = ds.PermID;
                }
                else
                {
                    Response.Redirect("~/DefaultScreen.aspx");
                }
                if (qcs.PermID == 1)
                {
                    AddPermDropDown.DataSourceID = "AdminPermissionsDataSource";
                    PermissionsDropDown.DataSourceID = "AdminPermissionsDataSource";
                }
                else if (qcs.PermID == 2)
                {
                    AddPermDropDown.DataSourceID = "SManagerPermissionsDataSource";
                    PermissionsDropDown.DataSourceID = "SManagerPermissionsDataSource";
                }
                else if (qcs.PermID == 3)
                {
                    AddPermDropDown.DataSourceID = "AssistManagerPermissionsDataSource";
                    PermissionsDropDown.DataSourceID = "AssistManagerPermissionsDataSource";
                }
                else
                {
                    Response.Redirect("~/DefaultScreen.aspx");
                }

            }

            // Changes DataSource of Permissions dropdowns to fit PermissionsID passed to the page
            // Changes the GridView to show employees with lower permission type (higher number)
            if (qcs.PermID == 1)
            {
                LoginGridView.DataSource = AdminLoginViewDataSource;
            }
            else if (qcs.PermID == 2)
            {
                LoginGridView.DataSource = SManagerLoginViewDataSource;
            }
            else if (qcs.PermID == 3)
            {
                LoginGridView.DataSource = AssistManagerLoginViewDataSource;
            }
            else
            {
                Response.Redirect("~/DefaultScreen.aspx");
            }
            LoginGridView.DataBind();
            EditLoginActionNoUserPanel.Visible = true;
            EditLoginActionUserSelectedPanel.Visible = false;
            LoadControlState(qcs);
            CheckForVisibility();
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
            Response.Cache.SetNoStore();
        }
        protected void EditUserButton_Click(object sender, EventArgs e)
        {
            // Edits selected User name
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString());
            SqlCommand sqlCommand = new SqlCommand("UPDATE [User] SET [Name] = @Name WHERE [UserID] = @UserID", con);
            sqlCommand.Parameters.AddWithValue("@Name", EditUserText.Text);
            sqlCommand.Parameters.AddWithValue("@UserID", LoginGridView.SelectedValue);
            con.Open();
            sqlCommand.ExecuteNonQuery();
            con.Close();
            LoginGridView.DataBind();
            BackToStart();
        }
        protected void PermEditButton_Click(object sender, EventArgs e)
        {
            // Sets selected employee's permission type
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString());
            SqlCommand sqlCommand = new SqlCommand("UPDATE [UserPermissions] SET [TypeID] = @Perm WHERE [UserID] = @UserID", con);
            sqlCommand.Parameters.AddWithValue("@Perm", PermissionsDropDown.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@UserID", LoginGridView.SelectedValue);
            con.Open();
            sqlCommand.ExecuteNonQuery();
            con.Close();
            LoginGridView.DataBind();
            BackToStart();
        }
        protected void EditPassButton_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString());
            SqlCommand sqlCommand = new SqlCommand("UPDATE [Password] SET [Password] = @Password WHERE [UserID] = @UserID", con);
            sqlCommand.Parameters.AddWithValue("@Password", EditPasswordText1.Text);
            sqlCommand.Parameters.AddWithValue("@UserID", LoginGridView.SelectedValue);
            con.Open();
            sqlCommand.ExecuteNonQuery();
            con.Close();
            LoginGridView.DataBind();
            BackToStart();
        }

        private void ClearNewLoginForm()
        {
            // Resets new employee login form
            AddEmpFNameText.Text = String.Empty;
            AddEmpLNameText.Text = String.Empty;
            AddUserText.Text = String.Empty;
            AddPassText1.Text = String.Empty;
            AddPassText2.Text = String.Empty;
            AddPermDropDown.SelectedValue = "-1";
        }

        protected void EditEmployeeButton_Click(object sender, EventArgs e)
        {
            if (EditEmployeeFName.Text.Length != 0 && EditEmployeeLName.Text.Length != 0)
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString()))
                {

                    SqlCommand command = new SqlCommand(
                    "UPDATE [Employee] " +
                    "SET [FName] = @FName, [LName] = @LName " +
                    "FROM [User] U, [Employee] E " +
                    "WHERE U.[UserID] = @UserID AND E.[EmpID] = U.[EmpID]", con);

                    command.Parameters.AddWithValue("@FName", EditEmployeeFName.Text);
                    command.Parameters.AddWithValue("@LName", EditEmployeeLName.Text);
                    command.Parameters.AddWithValue("@UserID", LoginGridView.SelectedValue);
                    con.Open();
                    command.ExecuteNonQuery();
                    con.Close();
                    LoginGridView.DataBind();
                }
                BackToStart();
            }
        }
        protected void AddUserButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString());
                SqlCommand sqlCommand = new SqlCommand("CreateNewEmployee", con)
                {
                    CommandType = CommandType.StoredProcedure
                };
                sqlCommand.Parameters.AddWithValue("@EmpFName", AddEmpFNameText.Text);
                sqlCommand.Parameters.AddWithValue("@EmpLName", AddEmpLNameText.Text);
                sqlCommand.Parameters.AddWithValue("@UserName", AddUserText.Text);
                sqlCommand.Parameters.AddWithValue("@Password", AddPassText1.Text);
                sqlCommand.Parameters.AddWithValue("@PermissionsType", AddPermDropDown.SelectedValue);
                con.Open();
                sqlCommand.ExecuteNonQuery();
                con.Close();
                LoginGridView.DataBind();
                BackToStart();
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
            ClearNewLoginForm();
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
            ClearNewLoginForm();
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
        private void BackToStart()
        {
            LoginGridView.SelectedIndex = -1;
            AddUserAction.SelectedIndex = -1;
            EditLoginAction.SelectedIndex = -1;
            EditLoginActionNoUserPanel.Visible = true;
            EditLoginActionUserSelectedPanel.Visible = false;
            AddUserPanel.Visible = false;
            EditEmployeePanel.Visible = false;
            UserNameEditPanel.Visible = false;
            PermEditPanel.Visible = false;
            PassEditPanel.Visible = false;
            DeleteEditPanel.Visible = false;
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
            EditLoginAction.SelectedIndex = 0;

            System.Diagnostics.Debug.WriteLine(LoginGridView.SelectedValue.ToString());

            // Sets the 'Delete Entry' Listitem to be disabled if the user has selected their own account.
            if (LoginGridView.SelectedValue.ToString() == Page.User.Identity.Name)
            {
                EditLoginAction.Items[6].Enabled = false;
            }
            else
            {
                EditLoginAction.Items[6].Enabled = true;
            }
            System.Diagnostics.Debug.WriteLine("Index changed.");
        }
        protected void DeleteUserButton_Click(object sender, EventArgs e)
        {
            if (DeleteUserText.Text.Count() > 0)
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString());
                SqlCommand cmd = new SqlCommand("SELECT U.[Name], E.[EmpID] FROM [Employee] E, [User] U WHERE U.[UserID] = @UserID AND U.[EmpID] = E.[EmpID]", con);
                cmd.Parameters.AddWithValue("@UserID", LoginGridView.SelectedValue);

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                sqlDataAdapter.Fill(table);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                string name = table.Rows[0]["Name"].ToString().Trim();
                if (name == DeleteUserText.Text)
                {
                    int empID = (int)table.Rows[0]["EmpID"];
                    cmd = new SqlCommand("DeleteEmployee", con)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@EmpID", empID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    LoginGridView.DataBind();
                    DeleteUserText.Text = String.Empty;
                    BackToStart();
                }
                else
                {
                    RequiredName.Text = "User not found.";
                }
            }
            else
            {
                RequiredName.Text = "Enter employee name.";
            }


        }

        protected void LoginGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(LoginGridView, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }
        protected void PageBackButton_Click(object sender, EventArgs e)
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
        protected void PageSignOutButton_Click(object sender, EventArgs e)
        {
            // (TO-DO) Base class/function needed.
            Session.Clear();
            Session.Abandon();
            Session.RemoveAll();

            FormsAuthentication.SignOut();
            HttpContext.Current.User = new GenericPrincipal(new GenericIdentity(string.Empty), null);
            FormsAuthentication.RedirectToLoginPage();
        }
    }
}