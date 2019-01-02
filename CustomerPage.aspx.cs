using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Drawing;
using System.Data.Common;
using ControlLibrary.Controls;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Principal;

namespace QuoteLogin
{
    public partial class CustomerPage : System.Web.UI.Page
    {
        // Public properties to be carried over
        public int EmpID
        {
            get { return qcs.EmpID; }
        }
        public int PermID
        {
            get { return qcs.PermID; }
        }
        public int CustID
        {
            get { return qcs.CustID; }
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
                    if (EmployeeHasPermissions())
                    {
                        QuotePageButton.Visible = true;
                    }
                }
                else if (PreviousPage is QuotePage qp)
                {
                    qcs.EmpID = qp.EmpID;
                    qcs.PermID = qp.PermID;
                    if (EmployeeHasPermissions())
                    {
                        QuotePageButton.Visible = true;
                    }
                }
                else if (PreviousPage is ServiceRequestPage srp)
                {
                    qcs.EmpID = srp.EmpID;
                    qcs.PermID = srp.PermID;
                    LinkToServiceRequestButton.Visible = true;
                }
                else
                {
                    Response.Redirect("~/DefaultScreen.aspx");
                }
                CustGridView.Visible = false;
                CustGridView.DataBind();
                ResetPanels();
            }
            LoadControlState(qcs);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
            Response.Cache.SetNoStore();
        }

        private void ResetPanels()
        {
            // Resets the view while keeping the selected customer options visible 
            SelectedCustDetailsView.DataBind();
            SearchResults.Visible = true;
            CustNameSelectPanel.Visible = true;
            CustList.Visible = false;
            CreateCustPanel.Visible = false;
            EditCustomerPanel.Visible = false;
            if (qcs.CustID > 0)
            {
                MakeCustomerSelectionPanel.Visible = true;
                NewCustActionPanel.Visible = false;
                CustSelectedActionPanel.Visible = true;
            }
            else
            {
                NewCustActionPanel.Visible = true;
                CustSelectedActionPanel.Visible = false;
                MakeCustomerSelectionPanel.Visible = false;
            }
        }

        // This function determines if an Employee has access to making quotes
        private bool EmployeeHasPermissions()
        {
            return (qcs.PermID <= 4);
        }

        protected void SearchCustNameButton_Click(object sender, EventArgs e)
        {
            // Provides SelectCommand parameters and opens the Customer datagrid
            CustGridView.Visible = true;
            CustGridView.DataBind();
        }
        protected void QuotePageButton_Click(object sender, EventArgs e)
        {
            // Uses selected customer to transfer to next page and start quote
            if (Page.User.Identity.IsAuthenticated)
            {
                Server.Transfer("QuotePage.aspx");
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
        protected void PageBackButton_Click(object sender, EventArgs e)
        {
            // Back to default page
            if (Page.User.Identity.IsAuthenticated)
            {
                Response.Redirect("DefaultScreen.aspx");
            }
            else
            {
                FormsAuthentication.RedirectToLoginPage();
            }
        }
        protected void NewCustButton_Click(object sender, EventArgs e)
        {
            // Selected from New Cust action
            SearchResults.Visible = false;
            MakeCustomerSelectionPanel.Visible = false;
            CreateCustPanel.Visible = true;
            CustNameSelectPanel.Visible = false;
            NewCustActionPanel.Visible = false;
            CustSelectedActionPanel.Visible = false;
            CustFNameText.Text = CustFNameSearchText.Text;
            CustLNameText.Text = CustLNameSearchText.Text;
        }
        protected void ClearCustFormButton_Click(object sender, EventArgs e)
        {
            // Clears the Customer Creation form fields
            ClearCreateCustForm();
        }
        protected void CustGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Changes from no customer select options to customer select options
            qcs.CustID = (int)CustGridView.SelectedValue;
            SelectedCustData.DataBind();
            ResetPanels();
            NewCustActionPanel.Visible = false;
            CustList.Visible = false;
        }
        protected void CreateNewCustButton_Click(object sender, EventArgs e)
        {
            CustData.Insert();
            CustData.DataBind();
            Reset();
        }

        private void Reset()
        {
            CreateCustPanel.Visible = false;
            CustList.Visible = false;
            ResetPanels();
            ClearCreateCustForm();
        }
        private void ClearCreateCustForm()
        {
            // Clears the Customer Creation form fields
            CustFNameSearchText.Text = String.Empty;
            CustLNameSearchText.Text = String.Empty;
            CustGridView.Visible = false;
            CustFNameText.Text = String.Empty;
            CustLNameText.Text = String.Empty;
            CustPhoneText.Text = String.Empty;
            CustEmailText.Text = String.Empty;
            CustNotesText.Text = String.Empty;
        }
        protected void Reset_Click(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                qcs.CustID = 0;
                Reset();
            }
            else
            {
                FormsAuthentication.RedirectToLoginPage();
            }
        }
        protected void CustBackButton_Click(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                Reset();
            }
            else
            {
                FormsAuthentication.RedirectToLoginPage();
            }
        }
        protected void CustData_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            // Uses the created Primary Key to select the new customer
            CustData.DataBind();
            DbCommand dbCommand = e.Command;
            qcs.CustID = (int)dbCommand.Parameters["@New_PK"].Value;
            SelectedCustData.DataBind();
            CreateCustPanel.Visible = false;
            CustNameSelectPanel.Visible = true;
        }

        protected void CustGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(CustGridView, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }

        }

        protected void CustomerListButton_Click(object sender, EventArgs e)
        {
            AllCustData.DataBind();
            CustList.DataBind();
            MakeCustomerSelectionPanel.Visible = false;
            SearchResults.Visible = false;
            CustNameSelectPanel.Visible = false;
            NewCustActionPanel.Visible = false;
            CustSelectedActionPanel.Visible = false;
            CustList.Visible = true;
        }

        protected void AllCustList_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Changes from no customer select options to customer select options
            qcs.CustID = (int)AllCustList.SelectedValue;
            EditCustomerDetailsView.DataBind();
            SelectedCustData.DataBind();
            ResetPanels();
            
        }

        protected void AllCustList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(AllCustList, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void EditCustomerButton_Click(object sender, EventArgs e)
        {
            // Hide NewCustActionPanel, CustSelectedActionPanel, StartQuotePanel
            NewCustActionPanel.Visible = false;
            CustSelectedActionPanel.Visible = false;
            MakeCustomerSelectionPanel.Visible = false;
            SearchResults.Visible = false;
            CustNameSelectPanel.Visible = false;

            // Open EditCustomerPanel
            EditCustomerDetailsView.DataBind();
            EditCustomerPanel.Visible = true;
        }

        protected void BackButton_Click(object sender, EventArgs e)
        {
            // Go back to start, retaining selected customer
            EditCustomerDetailsView.DataBind();
            Reset();
        }

        protected void DeleteCustomerButton_Click(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                SelectedCustData.Delete();
                CustData.DataBind();
                SelectedCustData.DataBind();
                qcs.CustID = 0;
                Reset();
            }
            else
            {
                FormsAuthentication.RedirectToLoginPage();
            }
        }

        protected void EditCustomerDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            CustData.DataBind();
            SelectedCustData.DataBind();
            SelectedCustDetailsView.DataBind();
        }

        protected void EditCustomerDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            CustData.DataBind();
            SelectedCustData.DataBind();
            EditCustomerDetailsView.DataBind();
            SelectedCustDetailsView.DataBind();
        }

        protected void BackToSearchButton_Click(object sender, EventArgs e)
        {
            EditCustomerDetailsView.DataBind();
            Reset();
        }

        protected void LinkToServiceRequestButton_Click(object sender, EventArgs e)
        {
            Server.Transfer("ServiceRequestPage.aspx");
        }

        protected void CustHistoryButton_Click(object sender, EventArgs e)
        {
            Server.Transfer("CustomerHistoryPage.aspx");
        }
    }
}