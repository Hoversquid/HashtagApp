using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Security.Principal;
using System.Security.Authentication;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuoteLogin
{
    public partial class ServiceRequestPage : System.Web.UI.Page
    {
        public int EmpID
        {
            get { return qcs.EmpID; }
        }
        public int PermID
        {
            get { return qcs.PermID; }
        }
        public int QuoteID
        {
            get { return qcs.QuoteID; }
        }
        public int StoreName
        {
            get { return qcs.StoreID; }
        }
        public DateTimeOffset ServiceReqTime
        {
            get { return qcs.ServiceRequestTime; }
        }
        public decimal FinalPrice
        {
            get { return qcs.FinalPrice; }
        }
        public decimal AmountDue
        {
            get { return qcs.AmountDue; }
        }
        public string ServiceReqType
        {
            get { return qcs.ServiceRequestType; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
            LoadControlState(qcs);

            if (!IsPostBack)
            {

                // Removing the reset button for now, need to get PreviousPages set correctly first
                ResetButton.Visible = false;

                if (PreviousPage is QuoteConfirmationPage qcp)
                {
                    // This connects from a quote that was just made
                    qcs.QuoteID = qcp.QuoteID;
                    qcs.EmpID = qcp.EmpID;
                    qcs.CustID = qcp.CustID;
                    qcs.FinalPrice = qcp.FinalPrice;
                    qcs.Make = qcp.Make.Trim();
                    qcs.Model = qcp.Model.Trim();
                    qcs.CustFName = qcp.CustFName.Trim();
                    qcs.CustLName = qcp.CustLName.Trim();
                    qcs.CustPhone = qcp.CustPhone.Trim();
                    qcs.CustEmail = qcp.CustEmail.Trim();
                    qcs.Issue = qcp.Issue.Trim();

                    MakeText.Text = qcs.Make;
                    ModelText.Text = qcs.Model;
                    NameText.Text = qcs.CustFName + " " + qcs.CustLName;
                    PhoneText.Text = qcs.CustPhone;
                    EmailText.Text = qcs.CustEmail;
                    IssueText.Text = qcs.Issue;

                    // If Service Request is generated from the rendering of a quote, set the time to when it is made
                    qcs.ServiceRequestTime = DateTimeOffset.Now;
                    CheckinLabel.Text = ServiceReqTime.ToLocalTime().ToString("t");
                    DateLabel.Text = ServiceReqTime.Date.ToString("d");

                    CreateServiceRequestButton.Visible = true;
                    ResetButton.Visible = false;
                    DueText.Visible = true;
                    DueText.Enabled = false;

                    CustomerSelectPanel.Visible = false;
                    writeDBToControlText(NameText, qcs.CustFName + " " + qcs.CustLName);
                    writeDBToControlText(PhoneText, qcs.CustPhone);
                    writeDBToControlText(EmailText, qcs.CustEmail);
                }

                else if (PreviousPage is CustomerPage cp)
                {
                    // This is for after a Customer is linked to a Service Request being made
                    qcs.CustID = cp.CustID;
                    qcs.EmpID = cp.EmpID;
                    qcs.ServiceRequestTime = DateTimeOffset.Now;
                    qcs.QuoteID = 0;
                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString()))
                    {
                        SqlCommand cmd = new SqlCommand("SELECT * FROM [Customer] WHERE @CustID = [CustID]", con);
                        cmd.Parameters.AddWithValue("@CustID", qcs.CustID);
                        DataTable table = new DataTable();
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        con.Open();
                        adapter.Fill(table);
                        con.Close();
                        DataRow row = table.Rows[0];
                        qcs.CustFName = row["F_Name"].ToString().Trim();
                        qcs.CustLName = row["L_Name"].ToString().Trim();
                        qcs.CustPhone = row["Phone"].ToString().Trim();
                        qcs.CustEmail = row["Email"].ToString().Trim();
                    }
                    PaidText.AutoPostBack = false;
                    DateLabel.Text = ServiceReqTime.ToString("d");
                    CheckinLabel.Text = ServiceReqTime.ToLocalTime().ToString("t");
                    DueText.Visible = true;
                    ResetButton.Visible = false;
                    writeDBToControlText(NameText, qcs.CustFName + " " + qcs.CustLName);
                    writeDBToControlText(PhoneText, qcs.CustPhone);
                    writeDBToControlText(EmailText, qcs.CustEmail);
                }

                else if (PreviousPage is DefaultScreen ds)
                {
                    // This is for a new Service Request made from the Default Screen
                    qcs.QuoteID = 0;
                    qcs.CustID = 0;
                    qcs.EmpID = ds.EmpID;
                    qcs.PermID = ds.PermID;
                    PaidText.AutoPostBack = false;
                    qcs.ServiceRequestTime = DateTimeOffset.Now;
                    DateLabel.Text = ServiceReqTime.ToString("d");
                    CheckinLabel.Text = ServiceReqTime.ToLocalTime().ToString("t");
                    DueText.Visible = true;
                    
                    MainServicePanel.Visible = false;
                    ServiceTypePanel.Visible = false;

                }

                // This section pulls from the history of Service Requests and Quotes
                else if (PreviousPage is QuoteViewPage qvp)
                {
                    // ViewingHistory is a bool showing if the ServiceRequest exists in the database or has yet to be made
                    if (qvp.ViewingHistory)
                    {
                        qcs.ViewingHistory = true;
                        qcs.EmpID = qvp.EmpID;
                        qcs.ServReqID = qvp.ServReqID;
                        qcs.StoreID = qvp.StoreID;
                        qcs.ServiceRequestType = qvp.ServReqType.Trim();
                        ServiceRequestType.Visible = false;
                        ServiceTypePanel.Visible = false;
                        CustomerSelectPanel.Visible = false;
                        NewCustomerPanel.Visible = true;
                        PrintServiceRequestButton.Visible = true;
                        CreateServiceRequestButton.Visible = false;

                        // I have this set to select from a static list of store names with their IDs on the design page
                        // Should be changed as soon as possible
                        writeDBToControlText(StoreNameDropdown, qcs.StoreID);

                        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString()))
                        {
                            if (ServiceReqType == "Phone")
                            {
                                changeServiceReqType("Phone");
                                SqlCommand cmd = new SqlCommand("SELECT * FROM [Phone_Service_Request] WHERE [Service_Request_ID] = @ID", con);
                                cmd.Parameters.AddWithValue("@ID", qcs.ServReqID);
                                con.Open();
                                DataTable dataTable = new DataTable();
                                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                                sqlDataAdapter.Fill(dataTable);
                                DataRow row = dataTable.Rows[0];

                                qcs.ServiceRequestTime = (DateTimeOffset)row["Check_In_Date"];
                                DateLabel.Text = ServiceReqTime.ToString("MM/dd/yyyy");
                                CheckinLabel.Text = ServiceReqTime.ToString("hh:mm tt");
                                writeDBToControlText(ModelText, row["Model"]);
                                writeDBToControlText(MakeText, row["Make"]);
                                writeDBToControlText(NameText, row["Name"]);
                                writeDBToControlText(PhoneText, row["Phone_Number"]);
                                writeDBToControlText(DiagDropdown, row["Troubleshooting"]);
                                ExpectationText.Text = ((DateTimeOffset)row["Expectation_Date"]).ToString("yyyy-MM-dd");
                                ExpectationText.Enabled = false;
                                writeDBToControlText(EmailText, row["Email"]);
                                writeDBToControlText(IssueText, row["Device_Issue"]);
                                writeDBToControlText(TechWorkText, row["Tech_Work_Needed"]);
                                writeDBToControlText(PasscodeText, row["Passcode"]);
                                writeDBToControlText(PaidText, row["Amount_Paid"]);
                                writeDBToControlText(DueText, row["Amount_Due"]);
                                DueText.Visible = true;
                                writeDBToControlText(WarrantyText, row["Warranty_and_Date"]);
                                writeDBToControlText(CourtesyText, row["Courtesy"]);
                                writeDBToControlText(VerifiedTechText, row["Verified_Tech"]);
                                writeDBToControlText(PWRButtonDropdown, row["PWR_Button"]);
                                writeDBToControlText(PWRONDropdown, row["PWR_On"]);
                                writeDBToControlText(VolumeControlDropdown, row["Volume_Control"]);
                                writeDBToControlText(TouchScreenDropdown, row["Touch_Screen"]);
                                writeDBToControlText(FrontCameraDropdown, row["Front_Camera"]);
                                writeDBToControlText(BackCameraDropdown, row["Back_Camera"]);
                                writeDBToControlText(BackCameraFlashDropdown, row["Back_Camera_Flash"]);
                                writeDBToControlText(ChargerPortDropdown, row["Charger_Port"]);
                                writeDBToControlText(HeadphoneJackDropdown, row["Headphone_Jack"]);
                                writeDBToControlText(SpeakerPhoneDropdown, row["Speaker_Phone"]);
                                writeDBToControlText(LoudSpeakerDropdown, row["Loud_Speaker"]);
                                writeDBToControlText(EarpieceDropdown, row["Earpiece"]);
                                writeDBToControlText(MicDropdown, row["Mic"]);
                                writeDBToControlText(ProximityDropdown, row["Proximity"]);
                                writeDBToControlText(TouchIDDropdown, row["Touch_ID"]);
                                writeDBToControlText(HomeButtonDropdown, row["Home_Button"]);
                                writeDBToControlText(BodyDamageDropdown, row["Body_Damage"]);
                                writeDBToControlText(LiquidDamageDropdown, row["Liquid_Damage"]);
                                writeDBToControlText(PenelopeDropdown, row["Penelope"]);
                                writeDBToControlText(SilentDropdown, row["Silent_Switch"]);
                                con.Close();

                            }
                            else if (ServiceReqType == "Computer")
                            {
                                changeServiceReqType("Computer");
                                SqlCommand cmd = new SqlCommand("SELECT * FROM [Computer_Service_Request] WHERE [Service_Request_ID] = @ID", con);
                                cmd.Parameters.AddWithValue("@ID", qcs.ServReqID);
                                con.Open();
                                DataTable dataTable = new DataTable();
                                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                                sqlDataAdapter.Fill(dataTable);
                                DataRow row = dataTable.Rows[0];

                                qcs.ServiceRequestTime = (DateTimeOffset)row["Check_In_Date"];
                                DateLabel.Text = ServiceReqTime.ToString("MM/dd/yyyy");
                                CheckinLabel.Text = ServiceReqTime.ToString("hh:mm tt");
                                writeDBToControlText(ModelText, row["Model"]);
                                writeDBToControlText(MakeText, row["Make"]);
                                writeDBToControlText(NameText, row["Name"]);
                                writeDBToControlText(PhoneText, row["Phone_Number"]);
                                writeDBToControlText(DiagDropdown, row["Troubleshooting"]);
                                ExpectationText.Text = ((DateTimeOffset)row["Expectation_Date"]).ToString("yyyy-MM-dd");
                                ExpectationText.Enabled = false;
                                writeDBToControlText(EmailText, row["Email"]);
                                writeDBToControlText(IssueText, row["Device_Issue"]);
                                writeDBToControlText(TechWorkText, row["Tech_Work_Needed"]);
                                writeDBToControlText(PasscodeText, row["Passcode"]);
                                writeDBToControlText(PaidText, row["Amount_Paid"]);
                                writeDBToControlText(DueText, row["Amount_Due"]);
                                DueText.Visible = true;
                                writeDBToControlText(WarrantyText, row["Warranty_and_Date"]);
                                writeDBToControlText(CourtesyText, row["Courtesy"]);
                                writeDBToControlText(VerifiedTechText, row["Verified_Tech"]);
                                writeDBToControlText(ComputerPowerCordDropdown, row["Power_Cord_Left"]);
                                writeDBToControlText(ComputerAccessoryDropdown, row["Accessories_Left"]);
                                writeDBToControlText(ComputerKeyboardDropdown, row["Keyboard_Works"]);
                                writeDBToControlText(ComputerPWRONButtonDropdown, row["PWR_On"]);
                                writeDBToControlText(ComputerPWROFFDropdown, row["PWR_Off"]);
                                writeDBToControlText(RebootDropdown, row["Reboot_To_Main"]);
                                writeDBToControlText(VolumeCtrlDropdown, row["Volume_Control"]);
                                writeDBToControlText(ComputerTouchScreenDropdown, row["Touch_Screen"]);
                                writeDBToControlText(ComputerFrontCameraDropdown, row["Front_Camera"]);
                                writeDBToControlText(MouseDropdown, row["Mouse"]);
                                writeDBToControlText(ComputerChargerPortDropdown, row["Charger_Port"]);
                                writeDBToControlText(ComputerHeadphoneJackDropdown, row["Headphone"]);
                                writeDBToControlText(ComputerAudioSpeakerDropdown, row["Audio_Speaker"]);
                                writeDBToControlText(ComputerWifiDropdown, row["Wifi"]);
                                writeDBToControlText(ComputerBodyDamageDropdown, row["Body_Damage"]);
                                writeDBToControlText(ComputerLiquidDamageDropdown, row["Liquid_Damage"]);

                                con.Close();
                            }
                            else if (ServiceReqType == "Mac")
                            {
                                changeServiceReqType("Mac");
                                SqlCommand cmd = new SqlCommand("SELECT * FROM [Mac_Service_Request] WHERE [Service_Request_ID] = @ID", con);
                                cmd.Parameters.AddWithValue("@ID", qcs.ServReqID);
                                con.Open();
                                DataTable dataTable = new DataTable();
                                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                                sqlDataAdapter.Fill(dataTable);
                                DataRow row = dataTable.Rows[0];

                                qcs.ServiceRequestTime = (DateTimeOffset)row["Check_In_Date"];
                                DateLabel.Text = ServiceReqTime.ToString("MM/dd/yyyy");
                                CheckinLabel.Text = ServiceReqTime.ToString("hh:mm tt");
                                writeDBToControlText(ModelText, row["Model"]);
                                writeDBToControlText(MakeText, row["Make"]);
                                writeDBToControlText(NameText, row["Name"]);
                                writeDBToControlText(PhoneText, row["Phone_Number"]);
                                writeDBToControlText(DiagDropdown, row["Troubleshooting"]);
                                ExpectationText.Text = ((DateTimeOffset)row["Expectation_Date"]).ToString("yyyy-MM-dd");
                                ExpectationText.Enabled = false;
                                writeDBToControlText(EmailText, row["Email"]);
                                writeDBToControlText(IssueText, row["Device_Issue"]);
                                writeDBToControlText(TechWorkText, row["Tech_Work_Needed"]);
                                writeDBToControlText(PasscodeText, row["Passcode"]);
                                writeDBToControlText(PaidText, row["Amount_Paid"]);
                                writeDBToControlText(DueText, row["Amount_Due"]);
                                DueText.Visible = true;
                                writeDBToControlText(WarrantyText, row["Warranty_and_Date"]);
                                writeDBToControlText(CourtesyText, row["Courtesy"]);
                                writeDBToControlText(VerifiedTechText, row["Verified_Tech"]);
                                writeDBToControlText(MacYearText, row["Year"]);
                                writeDBToControlText(MacPowerCordDropdown, row["Power_Cord_Left"]);
                                writeDBToControlText(MacAccessoryDropdown, row["Accessories_Left"]);
                                writeDBToControlText(MacKeyboardDropdown, row["Keyboard_Works"]);
                                writeDBToControlText(MacPWRONButtonDropdown, row["PWR_On"]);
                                writeDBToControlText(MacPWROFFDropdown, row["PWR_Off"]);
                                writeDBToControlText(MacRebootDropdown, row["Reboot_To_Main"]);
                                writeDBToControlText(MacVolumeCtrlDropdown, row["Volume_Control"]);
                                writeDBToControlText(MacTouchScreenDropdown, row["Touch_Screen"]);
                                writeDBToControlText(MacFrontCameraDropdown, row["Front_Camera"]);
                                writeDBToControlText(MacMouseDropdown, row["Mouse"]);
                                writeDBToControlText(MacChargerPortDropdown, row["Charger_Port"]);
                                writeDBToControlText(MacHeadphoneJackDropdown, row["Headphone"]);
                                writeDBToControlText(MacAudioSpeakerDropdown, row["Audio_Speaker"]);
                                writeDBToControlText(MacWifiDropdown, row["Wifi"]);
                                writeDBToControlText(MacBodyDamageDropdown, row["Body_Damage"]);
                                writeDBToControlText(MacLiquidDamageDropdown, row["Liquid_Damage"]);

                                con.Close();

                            }
                            else if (ServiceReqType == "TV")
                            {
                                changeServiceReqType("TV");
                                SqlCommand cmd = new SqlCommand("SELECT * FROM [TV_Service_Request] WHERE [Service_Request_ID] = @ID", con);
                                cmd.Parameters.AddWithValue("@ID", qcs.ServReqID);
                                con.Open();
                                DataTable dataTable = new DataTable();
                                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                                sqlDataAdapter.Fill(dataTable);
                                DataRow row = dataTable.Rows[0];

                                qcs.ServiceRequestTime = (DateTimeOffset)row["Check_In_Date"];
                                DateLabel.Text = ServiceReqTime.ToString("MM/dd/yyyy");
                                CheckinLabel.Text = ServiceReqTime.ToString("hh:mm tt");

                                writeDBToControlText(ModelText, row["Model"]);
                                writeDBToControlText(MakeText, row["Make"]);
                                writeDBToControlText(NameText, row["Name"]);
                                writeDBToControlText(DiagDropdown, row["Troubleshooting"]);
                                ExpectationText.Text = ((DateTimeOffset)row["Expectation_Date"]).ToString("yyyy-MM-dd");
                                ExpectationText.Enabled = false;
                                writeDBToControlText(PhoneText, row["Phone_Number"]);
                                writeDBToControlText(EmailText, row["Email"]);
                                writeDBToControlText(IssueText, row["Device_Issue"]);
                                writeDBToControlText(TechWorkText, row["Tech_Work_Needed"]);
                                writeDBToControlText(PasscodeText, row["Passcode"]);
                                writeDBToControlText(PaidText, row["Amount_Paid"]);
                                writeDBToControlText(DueText, row["Amount_Due"]);
                                DueText.Visible = true;
                                writeDBToControlText(WarrantyText, row["Warranty_and_Date"]);
                                writeDBToControlText(CourtesyText, row["Courtesy"]);
                                writeDBToControlText(VerifiedTechText, row["Verified_Tech"]);
                                writeDBToControlText(TVCrackedScreenDropdown, row["Screen_Cracks"]);
                                writeDBToControlText(TVCrackedFrameDropdown, row["Frame_Cracks"]);
                                writeDBToControlText(TVRemoteDropdown, row["Remote_Left"]);
                                writeDBToControlText(TVPowerCordDropdown, row["Power_Cord_Left"]);
                                writeDBToControlText(TVPWROnDropdown, row["PWR_On"]);
                                writeDBToControlText(TVImageDropdown, row["Any_Image"]);
                                writeDBToControlText(TVSoundDropdown, row["Any_Sound"]);
                                writeDBToControlText(TVRemoteWorkDropdown, row["Remote_Work"]);
                                con.Close();
                            }
                            else if (ServiceReqType == "Tablet")
                            {
                                changeServiceReqType("Tablet");
                                SqlCommand cmd = new SqlCommand("SELECT * FROM [Tablet_Service_Request] WHERE [Service_Request_ID] = @ID", con);
                                cmd.Parameters.AddWithValue("@ID", qcs.ServReqID);
                                con.Open();
                                DataTable dataTable = new DataTable();
                                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                                sqlDataAdapter.Fill(dataTable);
                                DataRow row = dataTable.Rows[0];

                                qcs.ServiceRequestTime = (DateTimeOffset)row["Check_In_Date"];
                                DateLabel.Text = ServiceReqTime.ToString("MM/dd/yyyy");
                                CheckinLabel.Text = ServiceReqTime.ToString("hh:mm tt");
                                writeDBToControlText(ModelText, row["Model"]);
                                writeDBToControlText(MakeText, row["Make"]);
                                writeDBToControlText(NameText, row["Name"]);
                                writeDBToControlText(PhoneText, row["Phone_Number"]);
                                writeDBToControlText(DiagDropdown, row["Troubleshooting"]);
                                ExpectationText.Text = ((DateTimeOffset)row["Expectation_Date"]).ToString("yyyy-MM-dd");
                                ExpectationText.Enabled = false;
                                writeDBToControlText(EmailText, row["Email"]);
                                writeDBToControlText(IssueText, row["Device_Issue"]);
                                writeDBToControlText(TechWorkText, row["Tech_Work_Needed"]);
                                writeDBToControlText(PasscodeText, row["Passcode"]);
                                writeDBToControlText(PaidText, row["Amount_Paid"]);
                                writeDBToControlText(DueText, row["Amount_Due"]);
                                DueText.Visible = true;
                                writeDBToControlText(WarrantyText, row["Warranty_and_Date"]);
                                writeDBToControlText(CourtesyText, row["Courtesy"]);
                                writeDBToControlText(VerifiedTechText, row["Verified_Tech"]);
                                writeDBToControlText(TabletPWRButtonDropdown, row["PWR_Button"]);
                                writeDBToControlText(TabletPWROnDropdown, row["PWR_On"]);
                                writeDBToControlText(TabletVolumeControlDropdown, row["Volume_Control"]);
                                writeDBToControlText(TabletTouchScreenDropdown, row["Touch_Screen"]);
                                writeDBToControlText(TabletFrontCameraDropdown, row["Front_Camera"]);
                                writeDBToControlText(TabletBackCameraDropdown, row["Back_Camera"]);
                                writeDBToControlText(TabletBackCameraFlashDropdown, row["Back_Camera_Flash"]);
                                writeDBToControlText(TabletChargerPortDropdown, row["Charger_Port"]);
                                writeDBToControlText(TabletHeadphoneJackDropdown, row["Headphone_Jack"]);
                                writeDBToControlText(TabletSpeakerPhoneDropdown, row["Speaker_Phone"]);
                                writeDBToControlText(TabletLoudSpeakerDropdown, row["Loud_Speaker"]);
                                writeDBToControlText(TabletEarpieceDropdown, row["Earpiece"]);
                                writeDBToControlText(TabletMicDropdown, row["Mic"]);
                                writeDBToControlText(TabletProximityDropdown, row["Proximity"]);
                                writeDBToControlText(TabletTouchIDDropdown, row["Touch_ID"]);
                                writeDBToControlText(TabletHomeButtonDropdown, row["Home_Button"]);
                                writeDBToControlText(TabletBodyDamageDropdown, row["Body_Damage"]);
                                writeDBToControlText(TabletLiquidDamageDropdown, row["Liquid_Damage"]);
                                writeDBToControlText(TabletPenelopeDropdown, row["Penelope"]);
                                writeDBToControlText(TabletSilentDropdown, row["Silent_Switch"]);
                                con.Close();
                            }
                            else
                            {
                                System.Diagnostics.Debug.WriteLine("Type " + qvp.ServReqType + "not recognized.");
                                Response.Redirect("~/DefaultScreen.aspx");
                            }
                        }
                    }
                    else
                    {

                        // This code links to a quote if a service request is being made from a previously made quote
                        qcs.QuoteID = qvp.QuoteID;
                        qcs.FinalPrice = qvp.FinalPrice;
                        qcs.Make = qvp.Make;
                        qcs.Model = qvp.Model;
                        qcs.CustFName = qvp.CustFName;
                        qcs.CustLName = qvp.CustLName;
                        qcs.CustPhone = qvp.CustPhone;
                        qcs.CustEmail = qvp.CustEmail;
                        qcs.Issue = qvp.Issue;

                        MakeText.Text = qcs.Make;
                        ModelText.Text = qcs.Model;
                        NameText.Text = qcs.CustFName + " " + qcs.CustLName;
                        PhoneText.Text = qcs.CustPhone;
                        EmailText.Text = qcs.CustEmail;
                        IssueText.Text = qcs.Issue;

                        // If Service Request is generated from the rendering of a quote, set the time to when it is made
                        qcs.ServiceRequestTime = DateTimeOffset.Now;
                        CheckinLabel.Text = ServiceReqTime.ToLocalTime().ToString("t");
                        DateLabel.Text = ServiceReqTime.Date.ToString("d");

                        CreateServiceRequestButton.Visible = true;
                        ResetButton.Visible = false;
                        DueText.Visible = true;
                        DueText.Enabled = false;
                        CustomerSelectPanel.Visible = false;
                    }

                }

                // Pulls Service Request from Customer History
                else if (PreviousPage is CustomerHistoryPage chp)
                {
                    qcs.EmpID = chp.EmpID;
                    qcs.ServReqID = chp.ServReqID;
                    qcs.StoreID = chp.StoreID;
                    qcs.ServiceRequestType = chp.ServReqType;
                    ServiceRequestType.Visible = false;
                    ServiceTypePanel.Visible = false;
                    CustomerSelectPanel.Visible = false;
                    NewCustomerPanel.Visible = true;
                    PrintServiceRequestButton.Visible = true;
                    CreateServiceRequestButton.Visible = false;

                    // I have this set to select from a static list of store names with their IDs on the design page
                    // Should be changed as soon as possible
                    writeDBToControlText(StoreNameDropdown, qcs.StoreID);

                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString()))
                    {
                        if (ServiceReqType == "Phone")
                        {
                            changeServiceReqType("Phone");
                            SqlCommand cmd = new SqlCommand("SELECT * FROM [Phone_Service_Request] WHERE [Service_Request_ID] = @ID", con);
                            cmd.Parameters.AddWithValue("@ID", qcs.ServReqID);
                            con.Open();
                            DataTable dataTable = new DataTable();
                            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                            sqlDataAdapter.Fill(dataTable);
                            DataRow row = dataTable.Rows[0];

                            qcs.ServiceRequestTime = (DateTimeOffset)row["Check_In_Date"];
                            DateLabel.Text = ServiceReqTime.ToString("MM/dd/yyyy");
                            CheckinLabel.Text = ServiceReqTime.ToString("hh:mm tt");
                            writeDBToControlText(ModelText, row["Model"]);
                            writeDBToControlText(MakeText, row["Make"]);
                            writeDBToControlText(NameText, row["Name"]);
                            writeDBToControlText(PhoneText, row["Phone_Number"]);
                            writeDBToControlText(DiagDropdown, row["Troubleshooting"]);
                            ExpectationText.Text = ((DateTimeOffset)row["Expectation_Date"]).ToString("yyyy-MM-dd");
                            ExpectationText.Enabled = false;
                            writeDBToControlText(EmailText, row["Email"]);
                            writeDBToControlText(IssueText, row["Device_Issue"]);
                            writeDBToControlText(TechWorkText, row["Tech_Work_Needed"]);
                            writeDBToControlText(PasscodeText, row["Passcode"]);
                            writeDBToControlText(PaidText, row["Amount_Paid"]);
                            writeDBToControlText(DueText, row["Amount_Due"]);
                            DueText.Visible = true;
                            writeDBToControlText(WarrantyText, row["Warranty_and_Date"]);
                            writeDBToControlText(CourtesyText, row["Courtesy"]);
                            writeDBToControlText(VerifiedTechText, row["Verified_Tech"]);
                            writeDBToControlText(PWRButtonDropdown, row["PWR_Button"]);
                            writeDBToControlText(PWRONDropdown, row["PWR_On"]);
                            writeDBToControlText(VolumeControlDropdown, row["Volume_Control"]);
                            writeDBToControlText(TouchScreenDropdown, row["Touch_Screen"]);
                            writeDBToControlText(FrontCameraDropdown, row["Front_Camera"]);
                            writeDBToControlText(BackCameraDropdown, row["Back_Camera"]);
                            writeDBToControlText(BackCameraFlashDropdown, row["Back_Camera_Flash"]);
                            writeDBToControlText(ChargerPortDropdown, row["Charger_Port"]);
                            writeDBToControlText(HeadphoneJackDropdown, row["Headphone_Jack"]);
                            writeDBToControlText(SpeakerPhoneDropdown, row["Speaker_Phone"]);
                            writeDBToControlText(LoudSpeakerDropdown, row["Loud_Speaker"]);
                            writeDBToControlText(EarpieceDropdown, row["Earpiece"]);
                            writeDBToControlText(MicDropdown, row["Mic"]);
                            writeDBToControlText(ProximityDropdown, row["Proximity"]);
                            writeDBToControlText(TouchIDDropdown, row["Touch_ID"]);
                            writeDBToControlText(HomeButtonDropdown, row["Home_Button"]);
                            writeDBToControlText(BodyDamageDropdown, row["Body_Damage"]);
                            writeDBToControlText(LiquidDamageDropdown, row["Liquid_Damage"]);
                            writeDBToControlText(PenelopeDropdown, row["Penelope"]);
                            writeDBToControlText(SilentDropdown, row["Silent_Switch"]);
                            con.Close();

                        }
                        else if (ServiceReqType == "Computer")
                        {
                            changeServiceReqType("Computer");
                            SqlCommand cmd = new SqlCommand("SELECT * FROM [Computer_Service_Request] WHERE [Service_Request_ID] = @ID", con);
                            cmd.Parameters.AddWithValue("@ID", qcs.ServReqID);
                            con.Open();
                            DataTable dataTable = new DataTable();
                            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                            sqlDataAdapter.Fill(dataTable);
                            DataRow row = dataTable.Rows[0];

                            qcs.ServiceRequestTime = (DateTimeOffset)row["Check_In_Date"];
                            DateLabel.Text = ServiceReqTime.ToString("MM/dd/yyyy");
                            CheckinLabel.Text = ServiceReqTime.ToString("hh:mm tt");
                            writeDBToControlText(ModelText, row["Model"]);
                            writeDBToControlText(MakeText, row["Make"]);
                            writeDBToControlText(NameText, row["Name"]);
                            writeDBToControlText(PhoneText, row["Phone_Number"]);
                            writeDBToControlText(DiagDropdown, row["Troubleshooting"]);
                            ExpectationText.Text = ((DateTimeOffset)row["Expectation_Date"]).ToString("yyyy-MM-dd");
                            ExpectationText.Enabled = false;
                            writeDBToControlText(EmailText, row["Email"]);
                            writeDBToControlText(IssueText, row["Device_Issue"]);
                            writeDBToControlText(TechWorkText, row["Tech_Work_Needed"]);
                            writeDBToControlText(PasscodeText, row["Passcode"]);
                            writeDBToControlText(PaidText, row["Amount_Paid"]);
                            writeDBToControlText(DueText, row["Amount_Due"]);
                            DueText.Visible = true;
                            writeDBToControlText(WarrantyText, row["Warranty_and_Date"]);
                            writeDBToControlText(CourtesyText, row["Courtesy"]);
                            writeDBToControlText(VerifiedTechText, row["Verified_Tech"]);
                            writeDBToControlText(ComputerPowerCordDropdown, row["Power_Cord_Left"]);
                            writeDBToControlText(ComputerAccessoryDropdown, row["Accessories_Left"]);
                            writeDBToControlText(ComputerKeyboardDropdown, row["Keyboard_Works"]);
                            writeDBToControlText(ComputerPWRONButtonDropdown, row["PWR_On"]);
                            writeDBToControlText(ComputerPWROFFDropdown, row["PWR_Off"]);
                            writeDBToControlText(RebootDropdown, row["Reboot_To_Main"]);
                            writeDBToControlText(VolumeCtrlDropdown, row["Volume_Control"]);
                            writeDBToControlText(ComputerTouchScreenDropdown, row["Touch_Screen"]);
                            writeDBToControlText(ComputerFrontCameraDropdown, row["Front_Camera"]);
                            writeDBToControlText(MouseDropdown, row["Mouse"]);
                            writeDBToControlText(ComputerChargerPortDropdown, row["Charger_Port"]);
                            writeDBToControlText(ComputerHeadphoneJackDropdown, row["Headphone"]);
                            writeDBToControlText(ComputerAudioSpeakerDropdown, row["Audio_Speaker"]);
                            writeDBToControlText(ComputerWifiDropdown, row["Wifi"]);
                            writeDBToControlText(ComputerBodyDamageDropdown, row["Body_Damage"]);
                            writeDBToControlText(ComputerLiquidDamageDropdown, row["Liquid_Damage"]);

                            con.Close();
                        }
                        else if (ServiceReqType == "Mac")
                        {
                            changeServiceReqType("Mac");
                            SqlCommand cmd = new SqlCommand("SELECT * FROM [Mac_Service_Request] WHERE [Service_Request_ID] = @ID", con);
                            cmd.Parameters.AddWithValue("@ID", qcs.ServReqID);
                            con.Open();
                            DataTable dataTable = new DataTable();
                            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                            sqlDataAdapter.Fill(dataTable);
                            DataRow row = dataTable.Rows[0];

                            qcs.ServiceRequestTime = (DateTimeOffset)row["Check_In_Date"];
                            DateLabel.Text = ServiceReqTime.ToString("MM/dd/yyyy");
                            CheckinLabel.Text = ServiceReqTime.ToString("hh:mm tt");
                            writeDBToControlText(ModelText, row["Model"]);
                            writeDBToControlText(MakeText, row["Make"]);
                            writeDBToControlText(NameText, row["Name"]);
                            writeDBToControlText(PhoneText, row["Phone_Number"]);
                            writeDBToControlText(DiagDropdown, row["Troubleshooting"]);
                            ExpectationText.Text = ((DateTimeOffset)row["Expectation_Date"]).ToString("yyyy-MM-dd");
                            ExpectationText.Enabled = false;
                            writeDBToControlText(EmailText, row["Email"]);
                            writeDBToControlText(IssueText, row["Device_Issue"]);
                            writeDBToControlText(TechWorkText, row["Tech_Work_Needed"]);
                            writeDBToControlText(PasscodeText, row["Passcode"]);
                            writeDBToControlText(PaidText, row["Amount_Paid"]);
                            writeDBToControlText(DueText, row["Amount_Due"]);
                            DueText.Visible = true;
                            writeDBToControlText(WarrantyText, row["Warranty_and_Date"]);
                            writeDBToControlText(CourtesyText, row["Courtesy"]);
                            writeDBToControlText(VerifiedTechText, row["Verified_Tech"]);
                            writeDBToControlText(MacYearText, row["Year"]);
                            writeDBToControlText(MacPowerCordDropdown, row["Power_Cord_Left"]);
                            writeDBToControlText(MacAccessoryDropdown, row["Accessories_Left"]);
                            writeDBToControlText(MacKeyboardDropdown, row["Keyboard_Works"]);
                            writeDBToControlText(MacPWRONButtonDropdown, row["PWR_On"]);
                            writeDBToControlText(MacPWROFFDropdown, row["PWR_Off"]);
                            writeDBToControlText(MacRebootDropdown, row["Reboot_To_Main"]);
                            writeDBToControlText(MacVolumeCtrlDropdown, row["Volume_Control"]);
                            writeDBToControlText(MacTouchScreenDropdown, row["Touch_Screen"]);
                            writeDBToControlText(MacFrontCameraDropdown, row["Front_Camera"]);
                            writeDBToControlText(MacMouseDropdown, row["Mouse"]);
                            writeDBToControlText(MacChargerPortDropdown, row["Charger_Port"]);
                            writeDBToControlText(MacHeadphoneJackDropdown, row["Headphone"]);
                            writeDBToControlText(MacAudioSpeakerDropdown, row["Audio_Speaker"]);
                            writeDBToControlText(MacWifiDropdown, row["Wifi"]);
                            writeDBToControlText(MacBodyDamageDropdown, row["Body_Damage"]);
                            writeDBToControlText(MacLiquidDamageDropdown, row["Liquid_Damage"]);

                            con.Close();

                        }
                        else if (ServiceReqType == "TV")
                        {
                            changeServiceReqType("TV");
                            SqlCommand cmd = new SqlCommand("SELECT * FROM [TV_Service_Request] WHERE [Service_Request_ID] = @ID", con);
                            cmd.Parameters.AddWithValue("@ID", qcs.ServReqID);
                            con.Open();
                            DataTable dataTable = new DataTable();
                            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                            sqlDataAdapter.Fill(dataTable);
                            DataRow row = dataTable.Rows[0];

                            qcs.ServiceRequestTime = (DateTimeOffset)row["Check_In_Date"];
                            DateLabel.Text = ServiceReqTime.ToString("MM/dd/yyyy");
                            CheckinLabel.Text = ServiceReqTime.ToString("hh:mm tt");

                            writeDBToControlText(ModelText, row["Model"]);
                            writeDBToControlText(MakeText, row["Make"]);
                            writeDBToControlText(NameText, row["Name"]);
                            writeDBToControlText(DiagDropdown, row["Troubleshooting"]);
                            ExpectationText.Text = ((DateTimeOffset)row["Expectation_Date"]).ToString("yyyy-MM-dd");
                            ExpectationText.Enabled = false;
                            writeDBToControlText(PhoneText, row["Phone_Number"]);
                            writeDBToControlText(EmailText, row["Email"]);
                            writeDBToControlText(IssueText, row["Device_Issue"]);
                            writeDBToControlText(TechWorkText, row["Tech_Work_Needed"]);
                            writeDBToControlText(PasscodeText, row["Passcode"]);
                            writeDBToControlText(PaidText, row["Amount_Paid"]);
                            writeDBToControlText(DueText, row["Amount_Due"]);
                            DueText.Visible = true;
                            writeDBToControlText(WarrantyText, row["Warranty_and_Date"]);
                            writeDBToControlText(CourtesyText, row["Courtesy"]);
                            writeDBToControlText(VerifiedTechText, row["Verified_Tech"]);
                            writeDBToControlText(TVCrackedScreenDropdown, row["Screen_Cracks"]);
                            writeDBToControlText(TVCrackedFrameDropdown, row["Frame_Cracks"]);
                            writeDBToControlText(TVRemoteDropdown, row["Remote_Left"]);
                            writeDBToControlText(TVPowerCordDropdown, row["Power_Cord_Left"]);
                            writeDBToControlText(TVPWROnDropdown, row["PWR_On"]);
                            writeDBToControlText(TVImageDropdown, row["Any_Image"]);
                            writeDBToControlText(TVSoundDropdown, row["Any_Sound"]);
                            writeDBToControlText(TVRemoteWorkDropdown, row["Remote_Work"]);
                            con.Close();
                        }
                        else if (ServiceReqType == "Tablet")
                        {
                            changeServiceReqType("Tablet");
                            SqlCommand cmd = new SqlCommand("SELECT * FROM [Tablet_Service_Request] WHERE [Service_Request_ID] = @ID", con);
                            cmd.Parameters.AddWithValue("@ID", qcs.ServReqID);
                            con.Open();
                            DataTable dataTable = new DataTable();
                            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                            sqlDataAdapter.Fill(dataTable);
                            DataRow row = dataTable.Rows[0];

                            qcs.ServiceRequestTime = (DateTimeOffset)row["Check_In_Date"];
                            DateLabel.Text = ServiceReqTime.ToString("MM/dd/yyyy");
                            CheckinLabel.Text = ServiceReqTime.ToString("hh:mm tt");
                            writeDBToControlText(ModelText, row["Model"]);
                            writeDBToControlText(MakeText, row["Make"]);
                            writeDBToControlText(NameText, row["Name"]);
                            writeDBToControlText(PhoneText, row["Phone_Number"]);
                            writeDBToControlText(DiagDropdown, row["Troubleshooting"]);
                            ExpectationText.Text = ((DateTimeOffset)row["Expectation_Date"]).ToString("yyyy-MM-dd");
                            ExpectationText.Enabled = false;
                            writeDBToControlText(EmailText, row["Email"]);
                            writeDBToControlText(IssueText, row["Device_Issue"]);
                            writeDBToControlText(TechWorkText, row["Tech_Work_Needed"]);
                            writeDBToControlText(PasscodeText, row["Passcode"]);
                            writeDBToControlText(PaidText, row["Amount_Paid"]);
                            writeDBToControlText(DueText, row["Amount_Due"]);
                            DueText.Visible = true;
                            writeDBToControlText(WarrantyText, row["Warranty_and_Date"]);
                            writeDBToControlText(CourtesyText, row["Courtesy"]);
                            writeDBToControlText(VerifiedTechText, row["Verified_Tech"]);
                            writeDBToControlText(TabletPWRButtonDropdown, row["PWR_Button"]);
                            writeDBToControlText(TabletPWROnDropdown, row["PWR_On"]);
                            writeDBToControlText(TabletVolumeControlDropdown, row["Volume_Control"]);
                            writeDBToControlText(TabletTouchScreenDropdown, row["Touch_Screen"]);
                            writeDBToControlText(TabletFrontCameraDropdown, row["Front_Camera"]);
                            writeDBToControlText(TabletBackCameraDropdown, row["Back_Camera"]);
                            writeDBToControlText(TabletBackCameraFlashDropdown, row["Back_Camera_Flash"]);
                            writeDBToControlText(TabletChargerPortDropdown, row["Charger_Port"]);
                            writeDBToControlText(TabletHeadphoneJackDropdown, row["Headphone_Jack"]);
                            writeDBToControlText(TabletSpeakerPhoneDropdown, row["Speaker_Phone"]);
                            writeDBToControlText(TabletLoudSpeakerDropdown, row["Loud_Speaker"]);
                            writeDBToControlText(TabletEarpieceDropdown, row["Earpiece"]);
                            writeDBToControlText(TabletMicDropdown, row["Mic"]);
                            writeDBToControlText(TabletProximityDropdown, row["Proximity"]);
                            writeDBToControlText(TabletTouchIDDropdown, row["Touch_ID"]);
                            writeDBToControlText(TabletHomeButtonDropdown, row["Home_Button"]);
                            writeDBToControlText(TabletBodyDamageDropdown, row["Body_Damage"]);
                            writeDBToControlText(TabletLiquidDamageDropdown, row["Liquid_Damage"]);
                            writeDBToControlText(TabletPenelopeDropdown, row["Penelope"]);
                            writeDBToControlText(TabletSilentDropdown, row["Silent_Switch"]);
                            con.Close();
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine("Type " + chp.ServReqType + "not recognized.");
                            Response.Redirect("~/DefaultScreen.aspx");
                        }
                    }
                }

            }
            else if (PaidText.Text != "" && PaidRequired.IsValid && PaidRange.IsValid && PaidRegEx.IsValid && qcs.QuoteID > 0 && !qcs.ViewingHistory)
            {
                qcs.AmountDue = (qcs.FinalPrice - Convert.ToDecimal(PaidText.Text));
                
                DueText.Text = qcs.AmountDue.ToString();
            }
            
            else if (IsPostBack)
            {
                // please cut this, it's stupid
            }
            else
            {
                Response.Redirect("DefaultScreen.aspx");
            }


            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
            Response.Cache.SetNoStore();
        }
        protected void PageBackButton_Click(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                Server.Transfer("~/DefaultScreen.aspx");
            }
            else
            {
                FormsAuthentication.RedirectToLoginPage();
            }
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
        private void changeServiceReqType(string selected)
        {
            switch (selected.Trim())
            {
                case "Phone":
                    qcs.ServiceRequestType = "Phone";
                    ServiceRequestTypeText.Text = "Phone";
                    PhoneServiceRequestPanel.Visible = true;
                    CustomerInitialPanel.Visible = true;
                    MacServiceRequestPanel.Visible = false;
                    ComputerServiceRequestPanel.Visible = false;
                    TVServiceRequestPanel.Visible = false;
                    TabletServiceRequestPanel.Visible = false;
                    SubmitButtonPanel.Visible = true;
                    break;

                case "Computer":
                    ServiceRequestTypeText.Text = "Computer";
                    qcs.ServiceRequestType = "Computer";
                    ComputerServiceRequestPanel.Visible = true;
                    CustomerInitialPanel.Visible = true;
                    MacServiceRequestPanel.Visible = false;
                    PhoneServiceRequestPanel.Visible = false;
                    TVServiceRequestPanel.Visible = false;
                    SubmitButtonPanel.Visible = true;
                    TabletServiceRequestPanel.Visible = false;
                    CheckinLabel.Text = ServiceReqTime.ToLocalTime().ToString("t");
                    DateLabel.Text = ServiceReqTime.Date.ToString("d");
                    break;

                case "TV":
                    ServiceRequestTypeText.Text = "TV";
                    qcs.ServiceRequestType = "TV";
                    TVServiceRequestPanel.Visible = true;
                    CustomerInitialPanel.Visible = true;
                    MacServiceRequestPanel.Visible = false;
                    ComputerServiceRequestPanel.Visible = false;
                    PhoneServiceRequestPanel.Visible = false;
                    TabletServiceRequestPanel.Visible = false;
                    SubmitButtonPanel.Visible = true;
                    CheckinLabel.Text = ServiceReqTime.ToLocalTime().ToString("t");
                    DateLabel.Text = ServiceReqTime.Date.ToString("d");
                    break;

                case "Tablet":
                    ServiceRequestTypeText.Text = "Tablet";
                    qcs.ServiceRequestType = "Tablet";
                    TabletServiceRequestPanel.Visible = true;
                    CustomerInitialPanel.Visible = true;
                    MacServiceRequestPanel.Visible = false;
                    ComputerServiceRequestPanel.Visible = false;
                    PhoneServiceRequestPanel.Visible = false;
                    TVServiceRequestPanel.Visible = false;
                    SubmitButtonPanel.Visible = true;
                    CheckinLabel.Text = ServiceReqTime.ToLocalTime().ToString("t");
                    DateLabel.Text = ServiceReqTime.Date.ToString("d");
                    break;
                case "Mac":
                    ServiceRequestTypeText.Text = "Mac";
                    qcs.ServiceRequestType = "Mac";
                    MacServiceRequestPanel.Visible = true;
                    CustomerInitialPanel.Visible = true;
                    TabletServiceRequestPanel.Visible = false;
                    ComputerServiceRequestPanel.Visible = false;
                    PhoneServiceRequestPanel.Visible = false;
                    TVServiceRequestPanel.Visible = false;
                    SubmitButtonPanel.Visible = true;
                    CheckinLabel.Text = ServiceReqTime.ToLocalTime().ToString("t");
                    DateLabel.Text = ServiceReqTime.Date.ToString("d");
                    break;

                default:
                    System.Diagnostics.Debug.WriteLine(ServiceRequestType.SelectedValue + "not recognized");
                    MainServicePanel.Visible = true;
                    CustomerInitialPanel.Visible = true;
                    TVServiceRequestPanel.Visible = false;
                    ComputerServiceRequestPanel.Visible = false;
                    PhoneServiceRequestPanel.Visible = false;
                    TabletServiceRequestPanel.Visible = false;
                    SubmitButtonPanel.Visible = false;
                    break;
            }
        }
        protected void ServiceRequestType_SelectedIndexChanged(object sender, EventArgs e)
        {
            changeServiceReqType(ServiceRequestType.SelectedValue.Trim());
        }
        private void writeDBToControlText(WebControl ctrl, object entryValue)
        {
            string strVal;
            if (entryValue is DateTimeOffset dto)
            {
                strVal = dto.ToString("d");
            }
            else
            {
                strVal = entryValue.ToString().Trim();
            }
            if (ctrl is TextBox tb)
            {
                tb.Text = strVal;
            }
            else if (ctrl is Label lb)
            {
                lb.Text = strVal;
            }
            else if (ctrl is DropDownList ddl)
            {
                foreach (ListItem li in ddl.Items)
                {
                    if (li.Value == strVal)
                    {
                        ddl.SelectedValue = li.Value;
                        ddl.Enabled = false;
                    }
                }
            }
            ctrl.Enabled = false;
        }


        protected void ResetButton_Click(object sender, EventArgs e)
        {
            string selected = ServiceRequestType.SelectedValue.Trim();
            ServiceRequestType.ClearSelection();
            qcs.ServiceRequestTime = DateTimeOffset.Now;
            Server.Transfer("/ServiceRequestPage.aspx");
        }
        protected void DatesValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime startDate = Convert.ToDateTime(DateLabel.Text);
            DateTime endDate = Convert.ToDateTime(ExpectationText.Text);
            System.Diagnostics.Debug.WriteLine("Start date: " + startDate + " End date: " + endDate);

            if (endDate < startDate)
            {
                args.IsValid = false;
            }
        }


        protected bool IsGroupValid(string sValidationGroup)
        {
            foreach (BaseValidator validator in Page.Validators)
            {
                if (validator.ValidationGroup == sValidationGroup)
                {
                    bool fValid = validator.IsValid;
                    if (fValid)
                    {
                        validator.Validate();
                        fValid = validator.IsValid;
                        validator.IsValid = true;
                    }
                    if (!fValid)
                        return false;
                }

            }
            return true;
        }

        // Sends to DB based on ServiceRequest Type selected
        private void SendToDB(int quoteID, string model, string make, string issue, decimal amtDue)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuoteDBConnection"].ToString()))
            {
                if (qcs.ServiceRequestType == "Phone")
                {
                    SqlCommand cmd = new SqlCommand("CreatePhoneServiceRequest", con)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@QuoteTableID", quoteID);
                    cmd.Parameters.AddWithValue("@StoreID", StoreNameDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Device_Type", ServiceRequestType.SelectedValue);
                    cmd.Parameters.AddWithValue("@Model", model);
                    cmd.Parameters.AddWithValue("@Make", make);
                    cmd.Parameters.AddWithValue("@CheckInDate", qcs.ServiceRequestTime);
                    cmd.Parameters.AddWithValue("@Troubleshoot", DiagDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@ExDate", ExpectationText.Text);
                    cmd.Parameters.AddWithValue("@Name", qcs.CustFName + " " + qcs.CustLName);
                    cmd.Parameters.AddWithValue("@Phone", qcs.CustPhone);
                    cmd.Parameters.AddWithValue("@Email", qcs.CustEmail);
                    cmd.Parameters.AddWithValue("@DeviceIssue", issue);
                    cmd.Parameters.AddWithValue("@TechWork", TechWorkText.Text);
                    cmd.Parameters.AddWithValue("@Passcode", PasscodeText.Text);
                    cmd.Parameters.AddWithValue("@Amt_Paid", PaidText.Text);
                    cmd.Parameters.AddWithValue("@Amt_Due", amtDue);
                    cmd.Parameters.AddWithValue("@WarrantyDate", WarrantyText.Text);
                    cmd.Parameters.AddWithValue("@Courtesy", CourtesyText.Text);
                    cmd.Parameters.AddWithValue("@Verified_Tech", VerifiedTechText.Text);
                    cmd.Parameters.AddWithValue("@PWRButton", PWRButtonDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@PWROn", PWRONDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@VolumeControl", VolumeControlDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@TouchScreen", TouchScreenDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Front_Camera", FrontCameraDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Back_Camera", BackCameraDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Back_Camera_Flash", BackCameraFlashDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Charger_Port", ChargerPortDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Headphone_Jack", HeadphoneJackDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Speaker_Phone", SpeakerPhoneDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Loud_Speaker", LoudSpeakerDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Earpiece", EarpieceDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Mic", MicDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Proximity", ProximityDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Touch_ID", TouchIDDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Home_Button", HomeButtonDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Body_Damage", BodyDamageDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Liquid_Damage", LiquidDamageDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Penelope", PenelopeDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Silent_Switch", SilentDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@CustID", qcs.CustID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                else if (qcs.ServiceRequestType == "Computer")
                {
                    SqlCommand cmd = new SqlCommand("CreateComputerServiceRequest", con)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@QuoteTableID", quoteID);
                    cmd.Parameters.AddWithValue("@StoreID", StoreNameDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Device_Type", ServiceRequestType.SelectedValue);
                    cmd.Parameters.AddWithValue("@Model", model);
                    cmd.Parameters.AddWithValue("@Make", make);
                    cmd.Parameters.AddWithValue("@CheckInDate", qcs.ServiceRequestTime);
                    cmd.Parameters.AddWithValue("@Troubleshoot", DiagDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@ExDate", ExpectationText.Text);
                    cmd.Parameters.AddWithValue("@Name", qcs.CustFName + " " + qcs.CustLName);
                    cmd.Parameters.AddWithValue("@Phone", qcs.CustPhone);
                    cmd.Parameters.AddWithValue("@Email", qcs.CustEmail);
                    cmd.Parameters.AddWithValue("@DeviceIssue", issue);
                    cmd.Parameters.AddWithValue("@TechWork", TechWorkText.Text);
                    cmd.Parameters.AddWithValue("@Passcode", PasscodeText.Text);
                    cmd.Parameters.AddWithValue("@Amt_Paid", PaidText.Text);
                    cmd.Parameters.AddWithValue("@Amt_Due", amtDue);
                    cmd.Parameters.AddWithValue("@WarrantyDate", WarrantyText.Text);
                    cmd.Parameters.AddWithValue("@Courtesy", CourtesyText.Text);
                    cmd.Parameters.AddWithValue("@Verified_Tech", VerifiedTechText.Text);
                    cmd.Parameters.AddWithValue("@Power_Cord_Left", ComputerPowerCordDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Accessories_Left", ComputerAccessoryDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Keyboard_Works", ComputerKeyboardDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@PWR_On", ComputerPWRONButtonDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@PWR_Off", ComputerPWROFFDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Reboot_To_Main", RebootDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Volume_Control", VolumeCtrlDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Touch_Screen", ComputerTouchScreenDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Front_Camera", ComputerFrontCameraDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Mouse", MouseDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Charger_Port", ComputerChargerPortDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Headphone", ComputerHeadphoneJackDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Audio_Speaker", ComputerAudioSpeakerDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Wifi", ComputerWifiDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Body_Damage", ComputerBodyDamageDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Liquid_Damage", ComputerLiquidDamageDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@CustID", qcs.CustID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                else if (qcs.ServiceRequestType == "TV")
                {
                    SqlCommand cmd = new SqlCommand("CreateTVServiceRequest", con)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@QuoteTableID", quoteID);
                    cmd.Parameters.AddWithValue("@StoreID", StoreNameDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Device_Type", ServiceRequestType.SelectedValue);
                    cmd.Parameters.AddWithValue("@Model", model);
                    cmd.Parameters.AddWithValue("@Make", make);
                    cmd.Parameters.AddWithValue("@CheckInDate", qcs.ServiceRequestTime);
                    cmd.Parameters.AddWithValue("@Troubleshoot", DiagDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@ExDate", ExpectationText.Text);
                    cmd.Parameters.AddWithValue("@Name", qcs.CustFName + " " + qcs.CustLName);
                    cmd.Parameters.AddWithValue("@Phone", qcs.CustPhone);
                    cmd.Parameters.AddWithValue("@Email", qcs.CustEmail);
                    cmd.Parameters.AddWithValue("@DeviceIssue", issue);
                    cmd.Parameters.AddWithValue("@TechWork", TechWorkText.Text);
                    cmd.Parameters.AddWithValue("@Passcode", PasscodeText.Text);
                    cmd.Parameters.AddWithValue("@Amt_Paid", PaidText.Text);
                    cmd.Parameters.AddWithValue("@Amt_Due", amtDue);
                    cmd.Parameters.AddWithValue("@WarrantyDate", WarrantyText.Text);
                    cmd.Parameters.AddWithValue("@Courtesy", CourtesyText.Text);
                    cmd.Parameters.AddWithValue("@Verified_Tech", VerifiedTechText.Text);
                    cmd.Parameters.AddWithValue("@Screen_Cracks", TVCrackedScreenDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Frame_Cracks", TVCrackedFrameDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Remote_Left", TVRemoteDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Power_Cord_Left", TVPowerCordDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@PWR_On", TVPWROnDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Any_Image", TVImageDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Any_Sound", TVSoundDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Remote_Work", TVRemoteWorkDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@CustID", qcs.CustID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                else if (qcs.ServiceRequestType == "Tablet")
                {
                    SqlCommand cmd = new SqlCommand("CreateTabletServiceRequest", con)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@QuoteTableID", quoteID);
                    cmd.Parameters.AddWithValue("@StoreID", StoreNameDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Device_Type", ServiceRequestType.SelectedValue);
                    cmd.Parameters.AddWithValue("@Model", model);
                    cmd.Parameters.AddWithValue("@Make", make);
                    cmd.Parameters.AddWithValue("@CheckInDate", qcs.ServiceRequestTime);
                    cmd.Parameters.AddWithValue("@Troubleshoot", DiagDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@ExDate", ExpectationText.Text);
                    cmd.Parameters.AddWithValue("@Name", qcs.CustFName + " " + qcs.CustLName);
                    cmd.Parameters.AddWithValue("@Phone", qcs.CustPhone);
                    cmd.Parameters.AddWithValue("@Email", qcs.CustEmail);
                    cmd.Parameters.AddWithValue("@DeviceIssue", issue);
                    cmd.Parameters.AddWithValue("@TechWork", TechWorkText.Text);
                    cmd.Parameters.AddWithValue("@Passcode", PasscodeText.Text);
                    cmd.Parameters.AddWithValue("@Amt_Paid", PaidText.Text);
                    cmd.Parameters.AddWithValue("@Amt_Due", amtDue);
                    cmd.Parameters.AddWithValue("@WarrantyDate", WarrantyText.Text);
                    cmd.Parameters.AddWithValue("@Courtesy", CourtesyText.Text);
                    cmd.Parameters.AddWithValue("@Verified_Tech", VerifiedTechText.Text);
                    cmd.Parameters.AddWithValue("@PWRButton", TabletPWRButtonDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@PWROn", TabletPWROnDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@VolumeControl", TabletVolumeControlDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@TouchScreen", TabletTouchScreenDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Front_Camera", TabletFrontCameraDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Back_Camera", TabletBackCameraDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Back_Camera_Flash", TabletBackCameraFlashDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Charger_Port", TabletChargerPortDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Headphone_Jack", TabletHeadphoneJackDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Speaker_Phone", TabletSpeakerPhoneDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Loud_Speaker", TabletLoudSpeakerDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Earpiece", TabletEarpieceDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Mic", TabletMicDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Proximity", TabletProximityDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Touch_ID", TabletTouchIDDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Home_Button", TabletHomeButtonDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Body_Damage", TabletBodyDamageDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Liquid_Damage", TabletLiquidDamageDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Penelope", TabletPenelopeDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Silent_Switch", TabletSilentDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@CustID", qcs.CustID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                else if (qcs.ServiceRequestType == "Mac")
                {
                    SqlCommand cmd = new SqlCommand("CreateMacServiceRequest", con)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@QuoteTableID", quoteID);
                    cmd.Parameters.AddWithValue("@StoreID", StoreNameDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Device_Type", ServiceRequestType.SelectedValue);
                    cmd.Parameters.AddWithValue("@Model", model);
                    cmd.Parameters.AddWithValue("@Make", make);
                    cmd.Parameters.AddWithValue("@CheckInDate", qcs.ServiceRequestTime);
                    cmd.Parameters.AddWithValue("@Troubleshoot", DiagDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@ExDate", ExpectationText.Text);
                    cmd.Parameters.AddWithValue("@Name", qcs.CustFName + " " + qcs.CustLName);
                    cmd.Parameters.AddWithValue("@Phone", qcs.CustPhone);
                    cmd.Parameters.AddWithValue("@Email", qcs.CustEmail);
                    cmd.Parameters.AddWithValue("@DeviceIssue", issue);
                    cmd.Parameters.AddWithValue("@TechWork", TechWorkText.Text);
                    cmd.Parameters.AddWithValue("@Passcode", PasscodeText.Text);
                    cmd.Parameters.AddWithValue("@Amt_Paid", PaidText.Text);
                    cmd.Parameters.AddWithValue("@Amt_Due", amtDue);
                    cmd.Parameters.AddWithValue("@WarrantyDate", WarrantyText.Text);
                    cmd.Parameters.AddWithValue("@Courtesy", CourtesyText.Text);
                    cmd.Parameters.AddWithValue("@Verified_Tech", VerifiedTechText.Text);
                    cmd.Parameters.AddWithValue("@Year", MacYearText.Text);
                    cmd.Parameters.AddWithValue("@Power_Cord_Left", MacPowerCordDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Accessories_Left", MacAccessoryDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Keyboard_Works", MacKeyboardDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@PWR_On", MacPWRONButtonDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@PWR_Off", MacPWROFFDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Reboot_To_Main", MacRebootDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Volume_Control", MacVolumeCtrlDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Touch_Screen", MacTouchScreenDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Front_Camera", MacFrontCameraDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Mouse", MacMouseDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Charger_Port", MacChargerPortDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Headphone", MacHeadphoneJackDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Audio_Speaker", MacAudioSpeakerDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Wifi", MacWifiDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Body_Damage", MacBodyDamageDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@Liquid_Damage", MacLiquidDamageDropdown.SelectedValue);
                    cmd.Parameters.AddWithValue("@CustID", qcs.CustID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                ClientScript.RegisterStartupScript(this.GetType(), "CallPrint", "PrintPanel()", true);
            }
        }

        protected void CreateServiceRequestButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int quoteID;
                decimal amtDue;
                string issue, make, model;

                // if coming from Quote
                if (qcs.QuoteID > 0)
                {
                    quoteID = qcs.QuoteID;
                    amtDue = qcs.AmountDue;
                    issue = qcs.Issue;
                    make = qcs.Make;
                    model = qcs.Model;
                }

                // if QuoteID == 0, info comes from ServiceRequest
                else
                {
                    quoteID = 0;
                    amtDue = Convert.ToDecimal(DueText.Text);
                    issue = IssueText.Text;
                    make = MakeText.Text;
                    model = ModelText.Text;
                }

                SendToDB(quoteID, model, make, issue, amtDue);
            }
        }

        protected void PrintServiceRequestButton_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "CallPrint", "PrintPanel()", true);
        }

        protected void CustomerPageButton_Click(object sender, EventArgs e)
        {
            Server.Transfer("CustomerPage.aspx");
        }
    }
}
 