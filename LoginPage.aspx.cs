using System;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Security.Principal;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Remoting.Contexts;

namespace QuoteLogin
{

    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            HttpContext.Current.User = new GenericPrincipal(new GenericIdentity(string.Empty), null);
            HttpContext.Current.ApplicationInstance.CompleteRequest();
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString());
            SqlCommand cmd = new SqlCommand(
                @"SELECT DISTINCT U.[UserID], U.[Name], P.[Password]
                FROM [User] AS U, [Employee] AS E, [Password] AS P
                WHERE P.[UserID] = U.[UserID] AND E.[EmpID] = U.[EmpID]
                AND (U.Name = @User) AND (P.Password = @Password)", con);
            cmd.Parameters.AddWithValue("@User", UsernameInput.Text);
            cmd.Parameters.AddWithValue("@Password", PasswordInput.Text);
            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
            DataTable dataTable = new DataTable();
            con.Open();
            sqlDataAdapter.Fill(dataTable);
            int i = cmd.ExecuteNonQuery();
            con.Close();

            if (dataTable.Rows.Count == 1)
            {
                FormsAuthentication.RedirectFromLoginPage(dataTable.Rows[0]["UserID"].ToString(), false);
            }
            else if (dataTable.Rows.Count > 1)
            { 
                IncorrectLabel.Text = "ERROR: Multiple logins!";
            }
            else
            {
                IncorrectLabel.Text = "Incorrect Username or password.";
            }
        }
    }
}