using System;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BuybackFormState
{
    [Serializable()]
    internal struct BuybackProperties
    {
        public bool PowerOn;
        public int Scuffs;
        public bool LiquidDamage;
        public bool FindDevice;
        public bool GmailDeleted;
        public decimal BasePrice;
    }
}

namespace BuybackFormState.Controls
{
    [Serializable]
    [ToolboxData("<{0}:BuybackFormState runat='server'></{0}:BuybackFormState>")]
    public class BuybackFormState : WebControl
    {
        #region "Declarations"

        private BuybackProperties mCurrProps = new BuybackProperties();

        #endregion

        #region "Properties"
        [Browsable(true)]
        [Category("bool")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public decimal BasePrice
        {
            get
            {
                return mCurrProps.BasePrice;
            }
            set
            {
                mCurrProps.BasePrice = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("bool")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public bool PowerOn
        {
            get
            {
                return mCurrProps.PowerOn;
            }
            set
            {
                mCurrProps.PowerOn = value;
                SaveControlState();
            }
        }

        [Browsable(true)]
        [Category("int")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public int Scuffs
        {
            get
            {
                return mCurrProps.Scuffs;
            }
            set
            {
                mCurrProps.Scuffs = value;
                SaveControlState();
            }
        }

        [Browsable(true)]
        [Category("bool")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public bool LiquidDamage
        {
            get
            {
                return mCurrProps.LiquidDamage;
            }
            set
            {
                mCurrProps.LiquidDamage = value;
                SaveControlState();
            }
        }

        [Browsable(true)]
        [Category("bool")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public bool FindDevice
        {
            get
            {
                return mCurrProps.FindDevice;
            }
            set
            {
                mCurrProps.FindDevice = value;
                SaveControlState();
            }
        }

        [Browsable(true)]
        [Category("bool")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public bool GmailDeleted
        {
            get
            {
                return mCurrProps.GmailDeleted;
            }
            set
            {
                mCurrProps.GmailDeleted = value;
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
            mCurrProps = new BuybackProperties();
            mCurrProps = (BuybackProperties)savedState;
        }
        #endregion
    }
}


namespace ControlLibrary
{
    [Serializable()]
    internal struct CurrentProperties
    {
        // needs to be seperated into several control states, some of these are not needed to be passed around for all pages
        public bool IsQuickQuote;
        public bool ViewingHistory;
        public int EmpID;
        public int PermID;
        public int CustID;
        public int PricingID;
        public int MarginID;
        public int QuoteID;
        public int ServReqID;
        public int StoreID;
        public int DepositID;
        public string ServReqType;
        public string Make;
        public string Model;
        public string Issue;
        public decimal BasePrice;
        public decimal FinalPrice;
        public decimal AmountDue;
        public DateTimeOffset ServiceRequestTime;
        public string ServiceRequestType;
        public string CustFName;
        public string CustLName;
        public string CustPhone;
        public string CustEmail;
        public string ProcedureType;
    }
}


namespace ControlLibrary.Controls
{
    [Serializable]
    [ToolboxData("<{0}:QuoteControlState runat='server'></{0}:QuoteControlState>")]
    public class QuoteControlState : WebControl
    {
        #region "Declarations"

        private CurrentProperties mCurrProps = new CurrentProperties();

        #endregion

        #region "Properties"
        [Browsable(true)]
        [Category("bool")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public bool IsQuickQuote
        {
            get
            {
                return mCurrProps.IsQuickQuote;
            }
            set
            {
                mCurrProps.IsQuickQuote = value;
                SaveControlState();
            }
        }

        [Browsable(true)]
        [Category("bool")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public string ProcedureType
        {
            get
            {
                return mCurrProps.ProcedureType;
            }
            set
            {
                mCurrProps.ProcedureType = value;
                SaveControlState();
            }
        }

        [Browsable(true)]
        [Category("bool")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public bool ViewingHistory
        {
            get
            {
                return mCurrProps.ViewingHistory;
            }
            set
            {
                mCurrProps.ViewingHistory = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("ID")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public int EmpID
        {
            get
            {
                return mCurrProps.EmpID;
            }
            set
            {
                mCurrProps.EmpID = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("ID")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public int DepositID
        {
            get
            {
                return mCurrProps.DepositID;
            }
            set
            {
                mCurrProps.DepositID = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("ID")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public int StoreID
        {
            get
            {
                return mCurrProps.StoreID;
            }
            set
            {
                mCurrProps.StoreID = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("ID")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public int ServReqID
        {
            get
            {
                return mCurrProps.ServReqID;
            }
            set
            {
                mCurrProps.ServReqID = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("ID")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public string CustPhone
        {
            get
            {
                return mCurrProps.CustPhone;
            }
            set
            {
                mCurrProps.CustPhone = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("ID")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public string CustEmail
        {
            get
            {
                return mCurrProps.CustEmail;
            }
            set
            {
                mCurrProps.CustEmail = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("ID")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public string ServReqType
        {
            get
            {
                return mCurrProps.ServReqType;
            }
            set
            {
                mCurrProps.ServReqType = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("ID")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public string CustFName
        {
            get
            {
                return mCurrProps.CustFName;
            }
            set
            {
                mCurrProps.CustFName = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("ID")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public string CustLName
        {
            get
            {
                return mCurrProps.CustLName;
            }
            set
            {
                mCurrProps.CustLName = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("Type")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public string ServiceRequestType
        {
            get
            {
                return mCurrProps.ServiceRequestType;
            }
            set
            {
                mCurrProps.ServiceRequestType = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("ID")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public int QuoteID
        {
            get
            {
                return mCurrProps.QuoteID;
            }
            set
            {
                mCurrProps.QuoteID = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("DateTime")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public DateTimeOffset ServiceRequestTime
        {
            get
            {
                return mCurrProps.ServiceRequestTime;
            }
            set
            {
                mCurrProps.ServiceRequestTime = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("ID")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public int PricingID
        {
            get
            {
                return mCurrProps.PricingID;
            }
            set
            {
                mCurrProps.PricingID = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("ID")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public int MarginID
        {
            get
            {
                return mCurrProps.MarginID;
            }
            set
            {
                mCurrProps.MarginID = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("ID")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public int PermID
        {
            get
            {
                return mCurrProps.PermID;
            }
            set
            {
                mCurrProps.PermID = value;
                SaveControlState();
            }
        }
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

        [Browsable(true)]
        [Category("Name")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public string Make
        {
            get
            {
                return mCurrProps.Make;
            }
            set
            {
                mCurrProps.Make = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("Name")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public string Model
        {
            get
            {
                return mCurrProps.Model;
            }
            set
            {
                mCurrProps.Model = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("Text")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public string Issue
        {
            get
            {
                return mCurrProps.Issue;
            }
            set
            {
                mCurrProps.Issue = value;
                SaveControlState();
            }
        }

        [Browsable(true)]
        [Category("Amount")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public decimal BasePrice
        {
            get
            {
                return mCurrProps.BasePrice;
            }
            set
            {
                mCurrProps.BasePrice = value;
                SaveControlState();
            }
        }
        [Browsable(true)]
        [Category("Amount")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public decimal AmountDue
        {
            get
            {
                return mCurrProps.AmountDue;
            }
            set
            {
                mCurrProps.AmountDue = value;
                SaveControlState();
            }
        }

        [Browsable(true)]
        [Category("Amount")]
        [DefaultValue("")]
        [Localizable(true)]
        [NotifyParentProperty(true)]
        public decimal FinalPrice
        {
            get
            {
                return mCurrProps.FinalPrice;
            }
            set
            {
                mCurrProps.FinalPrice = value;
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