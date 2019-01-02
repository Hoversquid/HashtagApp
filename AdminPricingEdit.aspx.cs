using System;
using System.Collections.Generic;
using System.Text;
using System.Linq;
using System.Security.Principal;
using System.Web.Security;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuoteLogin
{
    public partial class AdminPricingEdit : System.Web.UI.Page
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

                    // Makes sure the page is being accessed by someone with an acceptable permission type (1 or 2)
                    if (qcs.PermID < 3)
                    {
                        PricingGridView.DataBind();
                        PricingDetailsView.DataBind();
                    }
                    else
                    {
                        Response.Redirect("~/DefaultScreen.aspx");
                    }
                }
                else
                {

                    Response.Redirect("~/DefaultScreen.aspx");
                }
                
            }
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
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
        protected void PageBackButton_Click(object sender, EventArgs e)
        {
            // (TO-DO) Base class/function needed
            if (Page.User.Identity.IsAuthenticated)
            {
                Response.Redirect("DefaultScreen.aspx");
            }
            else
            {
                FormsAuthentication.RedirectToLoginPage();
            }
        }

        protected void PricingDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            PricingGridView.DataBind();
        }

        protected void MarginDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            MarginGridView.DataBind();
        }

        protected void PricingDetailsView_ItemCreated(object sender, EventArgs e)
        {
            // As each button in the command field is created, it detects if the button is the delete button. 
            // If it is, an attribute is added to make a javascript prompt display to confirm the action when pressed.
            int commandRowIndex = PricingDetailsView.Rows.Count - 1;
            if (commandRowIndex != -1)
            {
                DetailsViewRow row = PricingDetailsView.Rows[commandRowIndex];
                if (row.Controls[0].Controls.OfType<Button>().Where(b => b.CommandName == "Delete").Count() > 0)
                {
                    Button btnDelete = row.Controls[0].Controls.OfType<Button>().Where(b => b.CommandName == "Delete").FirstOrDefault();
                    btnDelete.Attributes["onclick"] = "if(!confirm('Do you want to delete this Pricing?')){ return false; };";
                }
            }
            PricingGridView.DataBind();
        }

        protected void MarginDetailsView_ItemCreated(object sender, EventArgs e)
        {
            // As each button in the command field is created, it detects if the button is the delete button. 
            // If it is, an attribute is added to make a javascript prompt display to confirm the action when pressed.
            int commandRowIndex = MarginDetailsView.Rows.Count - 1;
            if (commandRowIndex != -1)
            {
                DetailsViewRow row = MarginDetailsView.Rows[commandRowIndex];
                if (row.Controls[0].Controls.OfType<Button>().Where(b => b.CommandName == "Delete").Count() > 0)
                {
                    Button btnDelete = row.Controls[0].Controls.OfType<Button>().Where(b => b.CommandName == "Delete").FirstOrDefault();
                    btnDelete.Attributes["onclick"] = "if(!confirm('Do you want to delete this Margin?')){ return false; };";
                }
            }
            MarginGridView.DataBind();
        }

        protected void PricingGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Uses System.Drawing to be able to read the ID from a clicked row
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(PricingGridView, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void MarginGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Uses System.Drawing to be able to read the ID from a clicked row
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(MarginGridView, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        // Simply displays that there has been a change for creation, updating, and deleting
        // Will have to update it later to display which entry has been manipulated
        protected void PricingDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            ChangeConfirmation.Text = "New price inserted.";
            PricingGridView.SelectedIndex = -1;
            MarginGridView.SelectedIndex = -1;
        }

        protected void PricingDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            ChangeConfirmation.Text = "Price updated";
            PricingGridView.SelectedIndex = -1;
            MarginGridView.SelectedIndex = -1;
        }

        protected void PricingDetailsView_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            ChangeConfirmation.Text = "Price deleted.";
            PricingGridView.SelectedIndex = -1;
            MarginGridView.SelectedIndex = -1;
        }

        protected void MarginDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            ChangeConfirmation.Text = "New labor cost inserted.";
            PricingGridView.SelectedIndex = -1;
            MarginGridView.SelectedIndex = -1;
        }

        protected void MarginDetailsView_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            ChangeConfirmation.Text = "Labor cost deleted.";
            PricingGridView.SelectedIndex = -1;
            MarginGridView.SelectedIndex = -1;
        }

        protected void MarginDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            ChangeConfirmation.Text = "Labor cost updated.";
            PricingGridView.SelectedIndex = -1;
            MarginGridView.SelectedIndex = -1;
        }
    }
}
