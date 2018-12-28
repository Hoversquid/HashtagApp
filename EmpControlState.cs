using System;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ControlLibrary
{
    [Serializable()]
    internal struct CurrentProperties
    {
        public int CustID;
    }
}

namespace ControlLibrary.Controls
{
    [Serializable]
    [ToolboxData("<{0}:EmpControlState runat=server></{0}:EmpControlState>")]
    public class QuoteControlState : WebControl
    {
        #region "Declarations"

        private CurrentProperties mCurrProps = new CurrentProperties();
        
        #endregion

        #region "Properties"

        [Browsable(true)]
        [Category("ID")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public int CustID
        {
            get
            {
                return mCurrProps.CustID;
            }
            set
            {
                mCurrProps.CustID = value;
                SaveControlState();
            }
        }

        #endregion

        #region "Methods"

        protected override void OnInit(System.EventArgs e)
        {
            Page.RegisterRequiresControlState(this);
            base.OnInit(e);
        }

        protected override object SaveControlState()
        {
            return this.mCurrProps;
        }

        protected override void LoadControlState(object savedState)
        {
            mCurrProps = new CurrentProperties();
            mCurrProps = (CurrentProperties)savedState;
        }
        #endregion

    }
}