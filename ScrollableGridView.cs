using System;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Drawing.Design;
using System.Web;
using System.ComponentModel;

namespace QuoteLogin
{
    public class ScrollableGridView : GridView
    {
        protected override void RenderChildren(HtmlTextWriter writer)
        {
            if (this.Controls.Count == 0) // nothing to render, use default
            {
                base.RenderChildren(writer);
                return;
            }

            // this method contains some specific code to allow showing a scrollbar within the table
            // the trick is to render the table header row 2x. 
            // the first div will render only the header
            // the second table will display only the rows within a sereprate scrollable div.
            // some additional javascript is needed to make sure the colums widths and header heights align.

            // select the header row in the grid
            WebControl ctrl = (WebControl)this.Controls[0]; // the table
            Control ctrlrow = ctrl.Controls[0]; // the table->row[0]

            // tricky bit here
            System.Web.UI.HtmlControls.HtmlGenericControl divhead = new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");            
            divhead.Attributes["class"] = "GridViewHeaderContainer"; //style is hardcoded, required by jquery
            divhead.Style.Add("overflow", "hidden");
            if (this.Width != Unit.Empty)
                divhead.Style.Add("width", this.Width.ToString()); // assign new width, overrule stylesheet.

            Table tablehead = new Table();
            tablehead.ApplyStyle(this.HeaderStyle);
            tablehead.Style.Add("width", "100%");
            tablehead.ID = ctrl.UniqueID + "$Header";
            tablehead.Controls.Add(ctrlrow);// this will automatically bind the row to the new parent control (and remove itself from previous container)
            divhead.Controls.Add(tablehead); 
            divhead.RenderControl(writer); // will render the whole table, this will make sure the header will align. only header will be visible

            System.Web.UI.HtmlControls.HtmlGenericControl divbody = new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");
            divbody.Attributes["class"] = "GridViewBodyContainer"; //style is hardcoded for jquery

            if (this.Width != Unit.Empty)
                divbody.Style.Add("width", this.Width.ToString()); // assign new width, overrule stylesheet.

            if (this.Height != Unit.Empty)
                divbody.Style.Add("height", this.Height.ToString()); // assign new height, overrule stylesheet.

            divbody.Style.Add("overflow", "hidden");
            divbody.Style.Add("overflow-y", "auto");

            ctrl.Style.Add("width", "100%");

            ctrl.Controls.AddAt(0, ctrlrow);// this will automatically bind the row to the parent control (and remove itself from previous container)
            divbody.Controls.AddAt(0, ctrl); // bind the table to the body div(and remove itself from previous container)
            divbody.RenderControl(writer); // will render the whole table again except header row, only the body part will be visible, parent div will be scrollable

            this.Controls.AddAt(0, ctrl); // restore to previous container, this way the control will not break

            // render the rest of the controls (in this case only the footer)
            for (int i = 1; i < this.Controls.Count; i++)
            {
                ctrl = (WebControl)this.Controls[i];
                ctrl.RenderControl(writer);
            }
        }

    }    
}

