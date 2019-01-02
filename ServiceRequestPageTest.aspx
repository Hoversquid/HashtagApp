<%@ Page MasterPageFile="~/MasterPage.Master" Language="C#" AutoEventWireup="true" CodeBehind="ServiceRequestPageTest.aspx.cs" Inherits="QuoteLogin.ServiceRequestPage" EnableEventValidation="false" %>
<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="server">
    <asp:SqlDataSource runat="server" ID="StoreNameDataSource" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [Store_Locations]" />
    <div class="SRLabelDiv">
        <asp:Panel ID="CustomerSelectPanel" runat="server">
            <asp:Table runat="server" HorizontalAlign="Center" CellPadding="10">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button ID="CustomerPageButton" runat="server" CausesValidation="false" Text="Select Customer" OnClick="CustomerPageButton_Click" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </asp:Panel>
        <div class="PrintDiv">
            <asp:Panel ID="ServiceRequestHeaderPanel" runat="server">
                <asp:Table CssClass="ServiceRequestTable" runat="server">
                    <asp:TableRow>
                        <asp:TableCell Width="33%">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" ControlToValidate="StoreNameDropdown" Text="*" InitialValue="-1" ErrorMessage="Select store location." Display="Dynamic" />
                            <asp:Label runat="server" Text="Hashtag iFix it LLC" />
                            <br />
                            <asp:DropDownList runat="server" ID="StoreNameDropdown">
                                <asp:ListItem Selected="True" Value="-1">--</asp:ListItem>
                                <asp:ListItem Value="1">Lowes Drive</asp:ListItem>
                                <asp:ListItem Value="2">Quin Lane</asp:ListItem>
                                <asp:ListItem Value="0">Unknown Store Origin</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="33%" Font-Bold="true" HorizontalAlign="Center">
                            <asp:Label runat="server" Text="Service Request" />
                            <br />
                            <asp:Label ID="ServiceRequestTypeText" runat="server" />
                        </asp:TableCell><asp:TableCell Width="33%" />
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
            <hr style="height: 1px" />
            <asp:Panel ID="NewCustomerPanel" runat="server">
                <asp:Table CssClass="ServiceRequestTable" runat="server" HorizontalAlign="Center">
                    <asp:TableRow>
                        <asp:TableCell Width="33%">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" ControlToValidate="NameText" Text="*" ErrorMessage="Enter first name." Display="Dynamic" />
                            <asp:Label runat="server" Text="Name" />
                            <br />
                            <asp:TextBox ID="NameText" CssClass="SRControl" runat="server" Enabled="false" />
                        </asp:TableCell><asp:TableCell Width="33%">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" ControlToValidate="PhoneText" Text="*" ErrorMessage="Enter phone." Display="Dynamic" />
                            <asp:Label runat="server" Text="Phone Number" />
                            <br />
                            <asp:TextBox ID="PhoneText" CssClass="SRControl" runat="server" Enabled="false" />
                        </asp:TableCell><asp:TableCell Width="33%">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" ControlToValidate="EmailText" Text="*" ErrorMessage="Enter email." Display="Dynamic" />
                            <asp:Label runat="server" Text="Email" />
                            <br />
                            <asp:TextBox ID="EmailText" CssClass="SRControl" runat="server" Enabled="false" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
            <asp:Panel ID="MainServicePanel" runat="server">
                <asp:Table CssClass="ServiceRequestTable" runat="server">
                    <asp:TableRow>
                        <asp:TableCell Width="33%">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" ControlToValidate="ModelText" Text="*" ErrorMessage="Enter model name." Display="Dynamic" />
                            <asp:Label runat="server" Text="Model" />
                            <br />
                            <asp:TextBox ID="ModelText" CssClass="SRControl" runat="server" />
                        </asp:TableCell><asp:TableCell Width="33%">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" ControlToValidate="MakeText" Text="*" ErrorMessage="Enter make name." Display="Dynamic" />
                            <asp:Label runat="server" CssClass="SRLabel" Text="Make" />
                            <br />
                            <asp:TextBox ID="MakeText" CssClass="SRControl" runat="server" />
                        </asp:TableCell><asp:TableCell Width="33%">
                            <asp:Label runat="server" Text="Date" />
                            <br />
                            <asp:Label ID="DateLabel" CssClass="SRControl" runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="33%">
                            <asp:Label runat="server" Text="Check in Time" />
                            <br />
                            <asp:Label runat="server" ID="CheckinLabel" />
                        </asp:TableCell><asp:TableCell Width="33%">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" ControlToValidate="DiagDropdown" InitialValue="-1" Text="*" ErrorMessage="Enter diagnostics." Display="Dynamic" />
                            <asp:Label runat="server" Text="Troubleshooting/Diagnostics" />
                            <br />
                            <asp:DropDownList runat="server" ID="DiagDropdown">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Accepted</asp:ListItem>
                                <asp:ListItem>Declined</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="33%">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" ControlToValidate="ExpectationText" Text="*" ErrorMessage="Enter expectation date." Display="Dynamic" />
                            <asp:CustomValidator runat="server" ID="datesValidator" OnServerValidate="DatesValidator_ServerValidate" CssClass="SRRequiredError" ErrorMessage="Expectation Date should be greater than Quote Date" Display="Dynamic" Text="*" ControlToValidate="ExpectationText" />
                            <asp:Label runat="server" Text="Expectation" />
                            <br />
                            <asp:TextBox ID="ExpectationText" CssClass="SRControl" TextMode="Date" CausesValidation="true" AutoPostBack="true" runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="33%">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" ControlToValidate="IssueText" Text="*" ErrorMessage="Enter device issue." Display="Dynamic" />
                            <asp:Label runat="server" Text="What is the issue with this device?" />
                            <br />
                            <asp:TextBox ID="IssueText" Font-Bold="false" TextMode="MultiLine" runat="server" CssClass="MultilineTextbox" Rows="6" />
                        </asp:TableCell><asp:TableCell Width="33%">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" ControlToValidate="TechWorkText" Text="*" ErrorMessage="Enter tech work." Display="Dynamic" />
                            <asp:Label runat="server" Text="Tech Work Needed" />
                            <br />
                            <asp:TextBox ID="TechWorkText" TextMode="MultiLine" CssClass="MultilineTextbox" runat="server" Rows="6" />
                        </asp:TableCell><asp:TableCell Width="33%">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" ControlToValidate="PasscodeText" Text="*" ErrorMessage="Enter pass-code." />
                            <asp:Label runat="server" Text="Pass-code (if pattern draw manual)" />
                            <br />
                            <asp:TextBox ID="PasscodeText" TextMode="MultiLine" CssClass="MultilineTextbox" runat="server" Rows="6" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <asp:Table runat="server" CssClass="ServiceRequestTable">
                    <asp:TableRow>
                        <asp:TableCell Width="25%">
                            <asp:RequiredFieldValidator ID="PaidRequired" runat="server" CssClass="SRRequiredError" ControlToValidate="PaidText" Text="*" ErrorMessage="Enter amount paid." Display="Dynamic" />
                            <asp:RangeValidator ID="PaidRange" runat="server" CssClass="SRRequiredError" ControlToValidate="PaidText" Text="*" ErrorMessage="Amount paid cannot be negative." Display="Dynamic" MinimumValue="0" MaximumValue="99999999" />
                            <asp:RegularExpressionValidator ID="PaidRegEx" runat="server" CssClass="SRRequiredError" ControlToValidate="PaidText" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                            <asp:Label runat="server" Text="Amount Paid" />
                            <br />
                            <asp:TextBox ID="PaidText" runat="server" CssClass="SRControl" AutoPostBack="true" />
                        </asp:TableCell><asp:TableCell Width="25%">
                            <asp:RequiredFieldValidator ID="AmountRequired" runat="server" CssClass="SRRequiredError" ControlToValidate="DueText" Text="*" ErrorMessage="Enter amount paid." Display="Dynamic" />
                            <asp:RangeValidator ID="AmountRange" runat="server" CssClass="SRRequiredError" ControlToValidate="DueText" Text="*" ErrorMessage="Amount paid cannot be negative." Display="Dynamic" MinimumValue="0" MaximumValue="99999999" />
                            <asp:RegularExpressionValidator ID="AmountRegEx" runat="server" CssClass="SRRequiredError" ControlToValidate="DueText" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                            <asp:Label runat="server" Text="Amount Due" />
                            <br />
                            <asp:TextBox ID="DueText" runat="server" CssClass="SRControl" Visible="false" />
                        </asp:TableCell><asp:TableCell Width="25%">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" ControlToValidate="WarrantyText" Text="*" ErrorMessage="Enter date." Display="Dynamic" />
                            <asp:Label runat="server" Text="Warranty/Date" />
                            <br />
                            <asp:TextBox ID="WarrantyText" runat="server" />
                        </asp:TableCell><asp:TableCell Width="25%">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" ControlToValidate="CourtesyText" Text="*" ErrorMessage="Enter courtesy." Display="Dynamic" />
                            <asp:Label runat="server" Text="Courtesy" />
                            <br />
                            <asp:TextBox ID="CourtesyText" CssClass="SRControl" runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <asp:Table CssClass="ServiceRequestTable" runat="server">
                    <asp:TableRow>
                        <asp:TableCell Width="70%">
                        <asp:Label runat="server" Text="Pre-Service Checklist - Yes this works (YES) - No this doesn't work (NO) - Can't verify (CV) - NA" Font-Size="X-Small" />
                        </asp:TableCell><asp:TableCell Font-Size="X-Small">
                                <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" ControlToValidate="VerifiedTechText" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                                <asp:Label runat="server" Text="Tech that verified:" />
                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox runat="server" CssClass="SRControl" ID="VerifiedTechText" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
        </div>
        <asp:Panel ID="ServiceTypePanel" runat="server">
                <asp:Table CssClass="ServiceRequestStyleTable" runat="server">
                    <asp:TableRow>
                        <asp:TableCell Width="200px">
                            <asp:Label runat="server" Text="Select type of service request: " />
                        </asp:TableCell><asp:TableCell HorizontalAlign="Left">
                            <asp:DropDownList ID="ServiceRequestType" runat="server" CssClass="SRControl" OnSelectedIndexChanged="ServiceRequestType_SelectedIndexChanged" DataSourceID="ServReqTypesDataSource" DataTextField="Name" DataValueField="Name" AutoPostBack="true" AppendDataBoundItems="true">
                                <asp:ListItem Selected="true">--</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <asp:SqlDataSource runat="server" ID="ServReqTypesDataSource" ConnectionString='<%$ ConnectionStrings:QuoteDBConnection %>' SelectCommand="SELECT [Name] FROM [Service_Request_Type]" />
            </asp:Panel>
        <div class="PrintDiv">
            <asp:Panel ID="PhoneServiceRequestPanel" runat="server" Visible="false">
                <hr />
                <asp:Table runat="server" CssClass="ServiceRequestTable">
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="PWRButtonDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" Font-Size="Smaller" />
                            <asp:Label runat="server" Text="PWR Button" />
                            <br />
                            <asp:DropDownList ID="PWRButtonDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>Stuck</asp:ListItem>
                                <asp:ListItem>Jammed</asp:ListItem>
                                <asp:ListItem>Missing</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="PWRONDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="PWR ON" />
                            <br />
                            <asp:DropDownList ID="PWRONDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>Boot Loop</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="VolumeControlDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Volume Control" />
                            <br />
                            <asp:DropDownList ID="VolumeControlDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>Up Only</asp:ListItem>
                                <asp:ListItem>Down Only</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TouchScreenDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Touch Screen Function" />
                            <br />
                            <asp:DropDownList ID="TouchScreenDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="FrontCameraDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Front Camera" />
                            <br />
                            <asp:DropDownList ID="FrontCameraDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="BackCameraDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Back Camera" />
                            <br />
                            <asp:DropDownList ID="BackCameraDropdown" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="BackCameraFlashDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Back Camera Flash" />
                            <br />
                            <asp:DropDownList ID="BackCameraFlashDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="ChargerPortDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Charger Port" />
                            <br />
                            <asp:DropDownList ID="ChargerPortDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="HeadphoneJackDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Headphone Jack" />
                            <br />
                            <asp:DropDownList ID="HeadphoneJackDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="SpeakerPhoneDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Speaker Phone" />
                            <br />
                            <asp:DropDownList ID="SpeakerPhoneDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="LoudSpeakerDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Loud Speaker" />
                            <br />
                            <asp:DropDownList ID="LoudSpeakerDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="EarpieceDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Earpiece" />
                            <br />
                            <asp:DropDownList ID="EarpieceDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MicDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Mic" />
                            <br />
                            <asp:DropDownList ID="MicDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="ProximityDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Proximity" />
                            <br />
                            <asp:DropDownList ID="ProximityDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TouchIDDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Touch ID" />
                            <br />
                            <asp:DropDownList ID="TouchIDDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="HomeButtonDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Home Button" />
                            <br />
                            <asp:DropDownList ID="HomeButtonDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="BodyDamageDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Body Damage" />
                            <br />
                            <asp:DropDownList ID="BodyDamageDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>Scuffs</asp:ListItem>
                                <asp:ListItem>Nics</asp:ListItem>
                                <asp:ListItem>Scuffs/Nics</asp:ListItem>
                                <asp:ListItem>Frame Bent</asp:ListItem>
                                <asp:ListItem>Frame Bent/Nics/Scuffs</asp:ListItem>
                                <asp:ListItem>Badly Damaged</asp:ListItem>
                                <asp:ListItem>Dents</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="LiquidDamageDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Liquid Damage" />
                            <br />
                            <asp:DropDownList ID="LiquidDamageDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>Tech Will Check</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="PenelopeDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Penelope Screws In" />
                            <br />
                            <asp:DropDownList ID="PenelopeDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="SilentDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Silent Switch" />
                            <br />
                            <asp:DropDownList ID="SilentDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
            <asp:Panel ID="ComputerServiceRequestPanel" runat="server" Visible="false">
                <hr />
                <asp:Table runat="server" CssClass="ServiceRequestTable">
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="ComputerPowerCordDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" Font-Size="Smaller" />
                            <asp:Label runat="server" Text="Power Cord Left" />
                            <br />
                            <asp:DropDownList ID="ComputerPowerCordDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="ComputerAccessoryDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" Font-Size="Smaller" />
                            <asp:Label runat="server" Text="Any other accessories left" />
                            <br />
                            <asp:DropDownList ID="ComputerAccessoryDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="ComputerKeyboardDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Keyboard keys work" />
                            <br />
                            <asp:DropDownList ID="ComputerKeyboardDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="ComputerPWRONButtonDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" Font-Size="Smaller" />
                            <asp:Label runat="server" Text="PWR On" />
                            <br />
                            <asp:DropDownList ID="ComputerPWRONButtonDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="ComputerPWROFFDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="PWR Off" />
                            <br />
                            <asp:DropDownList ID="ComputerPWROFFDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="RebootDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Reboot to Main Screen" />
                            <br />
                            <asp:DropDownList ID="RebootDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="VolumeCtrlDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Volume Control" />
                            <br />
                            <asp:DropDownList ID="VolumeCtrlDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="ComputerTouchScreenDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Touch Screen Functions" />
                            <br />
                            <asp:DropDownList ID="ComputerTouchScreenDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="ComputerFrontCameraDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Front Camera" />
                            <br />
                            <asp:DropDownList ID="ComputerFrontCameraDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell /><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MouseDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Mouse Functions" />
                            <br />
                            <asp:DropDownList ID="MouseDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="ComputerChargerPortDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Charger Port" />
                            <br />
                            <asp:DropDownList ID="ComputerChargerPortDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="ComputerHeadphoneJackDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Headphone Jack" />
                            <br />
                            <asp:DropDownList ID="ComputerHeadphoneJackDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="ComputerAudioSpeakerDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Audio Speaker" />
                            <br />
                            <asp:DropDownList ID="ComputerAudioSpeakerDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="ComputerWifiDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Wi-Fi Connects" />
                            <br />
                            <asp:DropDownList ID="ComputerWifiDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell /><asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="ComputerBodyDamageDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Body Damage" />
                            <br />
                            <asp:DropDownList ID="ComputerBodyDamageDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>Scuffs</asp:ListItem>
                                <asp:ListItem>Nics</asp:ListItem>
                                <asp:ListItem>Scuffs/Nics</asp:ListItem>
                                <asp:ListItem>Frame Bent</asp:ListItem>
                                <asp:ListItem>Frame Bent/Nics/Scuffs</asp:ListItem>
                                <asp:ListItem>Badly Damaged</asp:ListItem>
                                <asp:ListItem>Dents</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="ComputerLiquidDamageDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Liquid Damage" />
                            <br />
                            <asp:DropDownList ID="ComputerLiquidDamageDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>Tech Will Check</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
            <asp:Panel ID="TVServiceRequestPanel" runat="server" Visible="false">
                <hr />
                <asp:Table runat="server" CssClass="ServiceRequestTable">
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TVCrackedScreenDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" Font-Size="Smaller" />
                            <asp:Label runat="server" Text="Any Cracks on Screen" />
                            <br />
                            <asp:DropDownList ID="TVCrackedScreenDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TVCrackedFrameDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" Font-Size="Smaller" />
                            <asp:Label runat="server" Text="Any Cracks on Frame" />
                            <br />
                            <asp:DropDownList ID="TVCrackedFrameDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TVRemoteDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Customer Leave Remote" />
                            <br />
                            <asp:DropDownList ID="TVRemoteDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TVPowerCordDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" Font-Size="Smaller" />
                            <asp:Label runat="server" Text="Customer Leave Power Cord" />
                            <br />
                            <asp:DropDownList ID="TVPowerCordDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell /><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TVPWROnDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="PWR On" />
                            <br />
                            <asp:DropDownList ID="TVPWROnDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell /><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TVSoundDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Any Sound" />
                            <br />
                            <asp:DropDownList ID="TVSoundDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TVImageDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Any Image" />
                            <br />
                            <asp:DropDownList ID="TVImageDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TVRemoteWorkDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Remote Work" />
                            <br />
                            <asp:DropDownList ID="TVRemoteWorkDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
            <asp:Panel ID="TabletServiceRequestPanel" runat="server" Visible="false">
                <hr />
                <asp:Table runat="server" CssClass="ServiceRequestTable">
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletPWRButtonDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" Font-Size="Smaller" />
                            <asp:Label runat="server" Text="PWR Button" />
                            <br />
                            <asp:DropDownList ID="TabletPWRButtonDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>Stuck</asp:ListItem>
                                <asp:ListItem>Jammed</asp:ListItem>
                                <asp:ListItem>Missing</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletPWROnDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="PWR ON" />
                            <br />
                            <asp:DropDownList ID="TabletPWROnDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>Boot Loop</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletVolumeControlDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Volume Control" />
                            <br />
                            <asp:DropDownList ID="TabletVolumeControlDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>Up Only</asp:ListItem>
                                <asp:ListItem>Down Only</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletTouchScreenDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Touch Screen Function" />
                            <br />
                            <asp:DropDownList ID="TabletTouchScreenDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletFrontCameraDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Front Camera" />
                            <br />
                            <asp:DropDownList ID="TabletFrontCameraDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletBackCameraDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Back Camera" />
                            <br />
                            <asp:DropDownList ID="TabletBackCameraDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletBackCameraFlashDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Back Camera Flash" />
                            <br />
                            <asp:DropDownList ID="TabletBackCameraFlashDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletChargerPortDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Charger Port" />
                            <br />
                            <asp:DropDownList ID="TabletChargerPortDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletHeadphoneJackDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Headphone Jack" />
                            <br />
                            <asp:DropDownList ID="TabletHeadphoneJackDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletSpeakerPhoneDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Speaker Phone" />
                            <br />
                            <asp:DropDownList ID="TabletSpeakerPhoneDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletLoudSpeakerDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Loud Speaker" />
                            <br />
                            <asp:DropDownList ID="TabletLoudSpeakerDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletEarpieceDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Earpiece" />
                            <br />
                            <asp:DropDownList ID="TabletEarpieceDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletMicDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Mic" />
                            <br />
                            <asp:DropDownList ID="TabletMicDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletProximityDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Proximity" />
                            <br />
                            <asp:DropDownList ID="TabletProximityDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletTouchIDDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Touch ID" />
                            <br />
                            <asp:DropDownList ID="TabletTouchIDDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletHomeButtonDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Home Button" />
                            <br />
                            <asp:DropDownList ID="TabletHomeButtonDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletBodyDamageDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Body Damage" />
                            <br />
                            <asp:DropDownList ID="TabletBodyDamageDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>Scuffs</asp:ListItem>
                                <asp:ListItem>Nics</asp:ListItem>
                                <asp:ListItem>Scuffs/Nics</asp:ListItem>
                                <asp:ListItem>Frame Bent</asp:ListItem>
                                <asp:ListItem>Frame Bent/Nics/Scuffs</asp:ListItem>
                                <asp:ListItem>Badly Damaged</asp:ListItem>
                                <asp:ListItem>Dents</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletLiquidDamageDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Liquid Damage" />
                            <br />
                            <asp:DropDownList ID="TabletLiquidDamageDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>Tech Will Check</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletPenelopeDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Penelope Screws In" />
                            <br />
                            <asp:DropDownList ID="TabletPenelopeDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="TabletSilentDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Silent Switch" />
                            <br />
                            <asp:DropDownList ID="TabletSilentDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
            <asp:Panel ID="MacServiceRequestPanel" runat="server" Visible="false">
                <hr />
                <asp:Table runat="server" CssClass="ServiceRequestTable">
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" ControlToValidate="MacYearText" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" Font-Size="Smaller" />
                            <asp:Label runat="server" Text="Year" />
                            <br />
                            <asp:TextBox ID="MacYearText" CssClass="SRControl" runat="server" />
                        </asp:TableCell><asp:TableCell /><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MacPowerCordDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" Font-Size="Smaller" />
                            <asp:Label runat="server" Text="Power Cord Left" />
                            <br />
                            <asp:DropDownList ID="MacPowerCordDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MacAccessoryDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" Font-Size="Smaller" />
                            <asp:Label runat="server" Text="Any other accessories left" />
                            <br />
                            <asp:DropDownList ID="MacAccessoryDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MacKeyboardDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Keyboard keys work" />
                            <br />
                            <asp:DropDownList ID="MacKeyboardDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MacPWRONButtonDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" Font-Size="Smaller" />
                            <asp:Label runat="server" Text="PWR On" />
                            <br />
                            <asp:DropDownList ID="MacPWRONButtonDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MacPWROFFDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="PWR Off" />
                            <br />
                            <asp:DropDownList ID="MacPWROFFDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MacRebootDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Reboot to Main Screen" />
                            <br />
                            <asp:DropDownList ID="MacRebootDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MacVolumeCtrlDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Volume Control" />
                            <br />
                            <asp:DropDownList ID="MacVolumeCtrlDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MacTouchScreenDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Touch Screen Functions" />
                            <br />
                            <asp:DropDownList ID="MacTouchScreenDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MacFrontCameraDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Front Camera" />
                            <br />
                            <asp:DropDownList ID="MacFrontCameraDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell /><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MacMouseDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Mouse Functions" />
                            <br />
                            <asp:DropDownList ID="MacMouseDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MacChargerPortDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Charger Port" />
                            <br />
                            <asp:DropDownList ID="MacChargerPortDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MacHeadphoneJackDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Headphone Jack" />
                            <br />
                            <asp:DropDownList ID="MacHeadphoneJackDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MacAudioSpeakerDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Audio Speaker" />
                            <br />
                            <asp:DropDownList ID="MacAudioSpeakerDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MacWifiDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Wi-Fi Connects" />
                            <br />
                            <asp:DropDownList ID="MacWifiDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>CV</asp:ListItem>
                                <asp:ListItem>NA</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell /><asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MacBodyDamageDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Body Damage" />
                            <br />
                            <asp:DropDownList ID="MacBodyDamageDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                                <asp:ListItem>Scuffs</asp:ListItem>
                                <asp:ListItem>Nics</asp:ListItem>
                                <asp:ListItem>Scuffs/Nics</asp:ListItem>
                                <asp:ListItem>Frame Bent</asp:ListItem>
                                <asp:ListItem>Frame Bent/Nics/Scuffs</asp:ListItem>
                                <asp:ListItem>Badly Damaged</asp:ListItem>
                                <asp:ListItem>Dents</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell Width="175px" Font-Size="Smaller" Font-Bold="True">
                            <asp:RequiredFieldValidator runat="server" CssClass="SRRequiredError" InitialValue="-1" ControlToValidate="MacLiquidDamageDropdown" Text="*" ErrorMessage="Enter checklist value." Display="Dynamic" />
                            <asp:Label runat="server" Text="Liquid Damage" />
                            <br />
                            <asp:DropDownList ID="MacLiquidDamageDropdown" CssClass="SRControl" runat="server">
                                <asp:ListItem Value="-1">--</asp:ListItem>
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>Tech Will Check</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell><asp:TableCell />
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
        </div>
        <div class="PrintDiv">
            <div style="page-break-after: always; page-break-inside: avoid">
                <asp:Panel ID="CustomerInitialPanel" runat="server" Visible="false">
                <asp:Table CssClass="ServiceRequestStyleTable" runat="server">
                    <asp:TableRow>
                        <asp:TableCell Width="300px" HorizontalAlign="Left">
                            <asp:Label runat="server" Text="Would you like to authorize anyone other than yourself to pick up your device?" />
                        </asp:TableCell><asp:TableCell Width="100px">
                            <asp:Label runat="server" Text="YES" />
                        </asp:TableCell><asp:TableCell Width="20px">
                            <asp:Label runat="server" Text="or" />
                        </asp:TableCell><asp:TableCell Width="100px">
                            <asp:Label runat="server" Text="NO" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <asp:Table CssClass="ServiceRequestStyleTable" runat="server">
                    <asp:TableRow HorizontalAlign="Left">
                        <asp:TableCell Width="200px">
                            <asp:Label runat="server" Text="If YES please provide name: " />
                        </asp:TableCell><asp:TableCell>
                            <asp:Label runat="server" Text="____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <asp:Table CssClass="ServiceRequestStyleTable" runat="server">
                    <asp:TableRow>
                        <asp:TableCell Width="300px">
                            <asp:Label runat="server" Text="Is it OK to contact you after 5:30PM during the week and on Saturday?" />
                        </asp:TableCell><asp:TableCell Width="50px" HorizontalAlign="Center">
                            <asp:Label runat="server" Text="YES" />
                        </asp:TableCell><asp:TableCell Width="20px">
                            <asp:Label runat="server" Text="or" />
                        </asp:TableCell><asp:TableCell Width="40px" HorizontalAlign="Center">
                            <asp:Label runat="server" Text="NO" />
                        </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="CIN:__________" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <asp:Table CssClass="ServiceRequestStyleTable" runat="server">
                    <asp:TableRow HorizontalAlign="Left">
                        <asp:TableCell Width="300px">
                            <asp:Label runat="server" 
                                Text="By initialing here, you understand and agree that anything that doesn't work or can't be verified Hashtag iFix it LLC cannot and will not be held responsible for. " />
                        </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="Customer Initial Here: __________" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <asp:Table CssClass="ServiceRequestStyleTable" runat="server">
                    <asp:TableRow>
                        <asp:TableCell Width="300px" HorizontalAlign="Center">
                            <asp:Label runat="server" Text="By initialing here, you understand and agree that if you have had a Trouble Shooting and Diagnostics test done by another individual be it yourself or a business professional and you decide to go with this diagnoses and this part doesn't fix the issue you are still 100% responsible for payment of the part(s) or service(s) provided by Hashtag iFix iT at full retail price." />
                        </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                            <asp:Label runat="server" Text="Customer Initial Here: __________" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <hr />
                <asp:Table runat="server" CssClass="ServiceRequestStyleTable">
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Left" Font-Size="Smaller">
                            <asp:Label runat="server" Text="Device Release Acknowledgement:" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Left" Font-Size="Smaller">
                                <asp:Label runat="server" Text="I hereby acknowledge that I am the rightful owner or the authorized individual by the owner of this device. I acknowledge all functionality of this device is in working order as when it was initiallly brought in (with the addition of the repair.)" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <asp:Table runat="server" CssClass="ServiceRequestStyleTable">
                    <asp:TableRow>
                        <asp:TableCell Font-Size="Smaller">
                            <asp:Label runat="server" Text="Customer Signature:____________________________" />
                        </asp:TableCell><asp:TableCell Font-Size="Smaller">
                            <asp:Label runat="server" Text="Date:____________________________" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
            </div>
        </div>
        <asp:Panel runat="server" ID="SubmitButtonPanel" Visible="false">
            <asp:Table runat="server" CssClass="PageAction" ID="Table1" CellPadding="20" HorizontalAlign="Center">
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:Button ID="CreateServiceRequestButton" CausesValidation="true" runat="server" Width="200px" CssClass="TableFormButton" OnClick="CreateServiceRequestButton_Click" Text="Create Service Request" />
                    </asp:TableCell><asp:TableCell HorizontalAlign="Center">
                        <asp:Button ID="PrintServiceRequestButton" CausesValidation="false" Visible="false" runat="server" Width="200px" CssClass="TableFormButton" OnClick="PrintServiceRequestButton_Click" Text="Print Service Request" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:Table runat="server" CssClass="PageAction" ID="Table2" CellPadding="20" HorizontalAlign="Center">
                <asp:TableRow></asp:TableRow>
            </asp:Table>

        </asp:Panel>
        <asp:Button ID="ResetButton" CausesValidation="false" Visible="false" CssClass="TableForButton" OnClick="ResetButton_Click" runat="server" Text="Reset Page" />
        <asp:Panel runat="server" ID="PageActionPanel">
            <asp:Table runat="server" CssClass="PageAction" ID="PageActionTable" CellPadding="20" HorizontalAlign="Center">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button ID="PageSignOutButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Sign Out" OnClick="PageSignOutButton_Click" />
                    </asp:TableCell><asp:TableCell></asp:TableCell><asp:TableCell>
                        <asp:Button ID="PageBackButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Back" OnClick="PageBackButton_Click" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </asp:Panel>
    </div>
</asp:Content>
