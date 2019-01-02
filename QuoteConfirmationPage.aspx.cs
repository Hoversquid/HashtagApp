using System;
using System.Collections.Generic;
using System.Linq;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.Security;
using System.Security.Principal;
using System.Text;
using System.IO;
using ControlLibrary.Controls;
using System.Web.UI.WebControls;

namespace QuoteLogin
{
    public partial class QuoteConfirmationPage : System.Web.UI.Page
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
                if (PreviousPage is QuotePage qp)
                {
                    // Gets all public properties from other pages
                    qcs.EmpID = qp.EmpID;
                    qcs.PermID = qp.PermID;
                    qcs.PricingID = qp.PricingID;
                    qcs.MarginID = qp.MarginID;
                    qcs.Make = qp.Make;
                    qcs.Model = qp.Model;
                    qcs.Issue = qp.Issue;
                    qcs.BasePrice = qp.BasePrice;
                    qcs.FinalPrice = qp.FinalPrice;
                    qcs.IsQuickQuote = qp.IsQuickQuote;

                    if (!qcs.IsQuickQuote)
                    {
                        qcs.CustID = qp.CustID;
                        
                        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString());
                        SqlCommand sqlCommand = new SqlCommand("SELECT C.[F_Name] AS First, C.[L_Name] AS Second, E.[FName] AS EmpFName, E.[LName] AS EmpLName FROM [Customer] C, [Employee] E WHERE E.[EmpID] = @EmpID AND C.[CustID] = @CustID", con);
                        sqlCommand.Parameters.AddWithValue("@EmpID", qcs.EmpID);
                        sqlCommand.Parameters.AddWithValue("@CustID", qcs.CustID);

                        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                        DataTable dataTable = new DataTable();
                        con.Open();
                        sqlDataAdapter.Fill(dataTable);
                        sqlCommand.ExecuteNonQuery();

                        qcs.CustFName = dataTable.Rows[0]["First"].ToString().Trim();
                        qcs.CustLName = dataTable.Rows[0]["Second"].ToString().Trim();
                        CustomerText.Text = qcs.CustFName + " " + qcs.CustLName;
                        EmployeeText.Text = dataTable.Rows[0]["EmpFName"].ToString() + dataTable.Rows[0]["EmpLName"].ToString();
                        con.Close();

                        
                    }
                    else
                    {
                        CustomerTableRow.Visible = false;
                        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString());
                        SqlCommand sqlCommand = new SqlCommand("SELECT [FName], [LName] FROM [Employee] WHERE [EmpID] = @EmpID", con);
                        sqlCommand.Parameters.AddWithValue("@EmpID", qcs.EmpID);

                        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                        DataTable dataTable = new DataTable();
                        con.Open();
                        sqlDataAdapter.Fill(dataTable);
                        sqlCommand.ExecuteNonQuery();
                        
                        EmployeeText.Text = dataTable.Rows[0]["FName"].ToString() + dataTable.Rows[0]["LName"].ToString();
                        con.Close();
                    }

                    DateText.Text = DateTime.Now.ToString();
                    MakeNameText.Text = qcs.Make;
                    ModelNameText.Text = qcs.Model;
                    IssueDescText.Text = qcs.Issue;
                    PriceText.Text = qcs.FinalPrice.ToString();
                    DateText.Text = System.DateTimeOffset.Now.ToString("d");
                    ExpiresText.Text = (System.DateTimeOffset.Now.AddDays(2)).ToString("d");
                }
                else if (PreviousPage is CustomerHistoryPage chp)
                {
                    qcs.QuoteID = chp.QuoteID;
                    qcs.CustID = chp.CustID;

                    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString());
                    SqlCommand sqlCommand = new SqlCommand("SELECT [CustFName], [CustLName], [Make], [Model], [Issue], [Final_Price], [EmpFName], [EmpLName], [QuoteTime], FORMAT ( [Expiration], 'd', 'en-US' ) AS 'Expiration' FROM [QuoteView] WHERE [CustID] = @CustID AND [QuoteID] = @QuoteID", con);
                    sqlCommand.Parameters.AddWithValue("@CustID", qcs.CustID);
                    sqlCommand.Parameters.AddWithValue("@QuoteID", qcs.QuoteID);
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    sqlDataAdapter.Fill(dataTable);

                    qcs.Make = dataTable.Rows[0]["Make"].ToString();
                    qcs.Model = dataTable.Rows[0]["Model"].ToString();
                    qcs.Issue = dataTable.Rows[0]["Issue"].ToString();
                    qcs.FinalPrice = Convert.ToDecimal(dataTable.Rows[0]["Final_Price"]);
                    string custName = dataTable.Rows[0]["CustFName"].ToString() + " " + dataTable.Rows[0]["CustLName"].ToString();
                    string empName = dataTable.Rows[0]["EmpFName"].ToString() + " " + dataTable.Rows[0]["EmpLName"].ToString();

                    CustomerText.Text = custName;
                    EmployeeText.Text = empName;
                    MakeNameText.Text = qcs.Make;
                    ModelNameText.Text = qcs.Model;
                    IssueDescText.Text = qcs.Issue;
                    PriceText.Text = qcs.FinalPrice.ToString();
                    DateText.Text = dataTable.Rows[0]["QuoteTime"].ToString();
                    ExpiresText.Text = dataTable.Rows[0]["Expiration"].ToString();
                }
                else
                {
                    Response.Redirect("~/CustomerPage.aspx");
                }
                //LoadControlState(qcs);
                
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
                Response.Cache.SetNoStore();
            }
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

        protected void BackButton_Click(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                Server.Transfer("~/QuotePage.aspx");
            }
            else
            {
                FormsAuthentication.RedirectToLoginPage();
            }
        }

        protected void ConfirmButton_Click(object sender, EventArgs e)
        {

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString()))
            {
                // Sets up two SqlCommands with parameters that have been selected from the page
                SqlCommand deviceIDcmd = new SqlCommand("CreateNewDevice", con)
                {
                    CommandType = CommandType.StoredProcedure
                };
                deviceIDcmd.Parameters.AddWithValue("@Make", qcs.Make);
                deviceIDcmd.Parameters.AddWithValue("@Model", qcs.Model);

                // Second SqlCommand for the issue text
                SqlCommand issueCmd = new SqlCommand("EXEC CreateNewIssue @Desc", con);
                issueCmd.Parameters.AddWithValue("@Desc", qcs.Issue);

                // New SqlDataAdapter for the two commands
                SqlDataAdapter adapter = new SqlDataAdapter(deviceIDcmd);
                DataTable table = new DataTable();
                con.Open();
                adapter.Fill(table);
                //deviceIDcmd.ExecuteNonQuery();
                int deviceID = (int)table.Rows[0]["DeviceID"];
                foreach (DataRow row in table.Rows)
                {
                    System.Diagnostics.Debug.WriteLine(row.ToString());
                }

                // Resets adapter for second command
                adapter = new SqlDataAdapter(issueCmd);
                table.Reset();
                adapter.Fill(table);
                //issueCmd.ExecuteNonQuery();
                int issueID = (int)table.Rows[0]["IssueID"];
                foreach (DataRow row in table.Rows)
                {
                    System.Diagnostics.Debug.WriteLine(row.ToString());
                }

                // Uses all the public properties collected from the other pages to create table in DB

                if (qcs.IsQuickQuote)
                {
                    SqlCommand command = new SqlCommand("CreateNewQuickQuote", con)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    
                    command.Parameters.AddWithValue("@Employee", qcs.EmpID);
                    command.Parameters.AddWithValue("@Price", qcs.PricingID);
                    command.Parameters.AddWithValue("@Device", deviceID);
                    command.Parameters.AddWithValue("@Issue", issueID);
                    command.Parameters.AddWithValue("@Margin", qcs.MarginID);
                    command.Parameters.AddWithValue("@Base", qcs.BasePrice);
                    command.Parameters.AddWithValue("@Final", qcs.FinalPrice);
                    command.Parameters.AddWithValue("@QuoteTime", DateTimeOffset.Now);
                    SqlParameter NewPK = new SqlParameter("@New_PK", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    command.Parameters.Add(NewPK);
                    adapter = new SqlDataAdapter(command);
                    table.Reset();
                    adapter.Fill(table);
                    //command.ExecuteNonQuery();
                    qcs.QuoteID = (int)command.Parameters["@New_PK"].Value;
                    con.Close();
                }
                else
                {
                    SqlCommand command = new SqlCommand("CreateNewQuote", con)
                    {
                        CommandType = CommandType.StoredProcedure
                    };

                    command.Parameters.AddWithValue("@Cust", qcs.CustID);
                    command.Parameters.AddWithValue("@Employee", qcs.EmpID);
                    command.Parameters.AddWithValue("@Price", qcs.PricingID);
                    command.Parameters.AddWithValue("@Device", deviceID);
                    command.Parameters.AddWithValue("@Issue", issueID);
                    command.Parameters.AddWithValue("@Margin", qcs.MarginID);
                    command.Parameters.AddWithValue("@Base", qcs.BasePrice);
                    command.Parameters.AddWithValue("@Final", qcs.FinalPrice);
                    command.Parameters.AddWithValue("@QuoteTime", DateTimeOffset.Now);
                    SqlParameter NewPK = new SqlParameter("@New_PK", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    command.Parameters.Add(NewPK);
                    adapter = new SqlDataAdapter(command);
                    table.Reset();
                    adapter.Fill(table);
                    //command.ExecuteNonQuery();
                    qcs.QuoteID = (int)command.Parameters["@New_PK"].Value;
                    con.Close();

                    ServiceRequestButton.Visible = true;
                }
            }
            ConfirmationActionPanel.Visible = true;
            SubmissionPanel.Visible = false;
        }

        protected void ServiceRequestButton_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("SELECT QV.[CustFName], QV.[CustLName], QV.[Issue], QV.[Make], QV.[Model], C.[Phone], C.[Email] FROM [QuoteView] QV, [Customer] C, [Quote] Q WHERE QV.[QuoteID] = @QuoteID AND C.[CustID] = @CustID", con);
                cmd.Parameters.AddWithValue("@QuoteID", qcs.QuoteID);
                cmd.Parameters.AddWithValue("@CustID", qcs.CustID);
                con.Open();
                DataTable dataTable = new DataTable();
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                sqlDataAdapter.Fill(dataTable);
                cmd.ExecuteNonQuery();
                qcs.CustPhone = dataTable.Rows[0]["Phone"].ToString();
                qcs.CustEmail = dataTable.Rows[0]["Email"].ToString();
                qcs.Issue = dataTable.Rows[0]["Issue"].ToString();
                qcs.Make = dataTable.Rows[0]["Make"].ToString();
                qcs.Model = dataTable.Rows[0]["Model"].ToString();
                con.Close();
            }
                Server.Transfer("ServiceRequestPage.aspx");
        }

        protected void FinishButton_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Session.RemoveAll();

            FormsAuthentication.SignOut();
            HttpContext.Current.User = new GenericPrincipal(new GenericIdentity(string.Empty), null);
            FormsAuthentication.RedirectToLoginPage();
        }
    }
}