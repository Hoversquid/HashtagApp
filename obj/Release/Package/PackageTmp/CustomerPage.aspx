<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerPage.aspx.cs" Inherits="QuoteLogin.CustomerPage" EnableEventValidation="false" %>

<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>
<%@ Register Assembly="QuoteLogin" Namespace="QuoteLogin" TagPrefix="sgv" %>
<script type="text/javascript" src="Scripts/jquery-1.4.1.min.js"></script>
<script type="text/javascript" src="Scripts/ScrollableGridView.js"></script>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="QuoteStyle.css" />
    <title>Add New Customer</title>
    <script type="text/javascript">

        var clicked = false;
        function CheckBrowser() {
            if (clicked == false) {
                //Browser closed   
            } else {
                //redirected
                clicked = false;
            }
        }
        function bodyUnload() {
            if (clicked == false)//browser is closed  
            {
                var request = GetRequest();
                request.open("POST", "../LogOut.aspx", false);
                request.send();
            }
        }

        function GetRequest() {
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            return xmlhttp;
        }

    </script>
</head>
<body onunload="bodyUnload();" onclick="clicked=true;">
    <form id="CustForm" class="MainForm" runat="server">
        <cstate:QuoteControlState ID="qcs" runat="server" />
        <asp:Panel ID="SearchResults" CssClass="SearchResultsClass" runat="server" HorizontalAlign="Center" Direction="LeftToRight">
            <div class="LeftColumnGridDiv">
                <asp:Label runat="server" Text="Customer search results: " />
                <asp:GridView ID="CustGridView" CssClass="AbsolutePos" OnRowDataBound="CustGridView_RowDataBound" OnSelectedIndexChanged="CustGridView_SelectedIndexChanged" runat="server" AutoGenerateColumns="False" DataKeyNames="CustID" DataSourceID="CustData" CellPadding="4" ForeColor="#333333" GridLines="None" TabIndex="10" AllowPaging="True" PageSize="5" Width="296px" HorizontalAlign="Center">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="CustID" HeaderText="CustID" SortExpression="CustID" ReadOnly="True" Visible="False" />
                        <asp:BoundField DataField="F_Name" HeaderText="F_Name" SortExpression="F_Name" ReadOnly="True" />
                        <asp:BoundField DataField="L_Name" HeaderText="L_Name" SortExpression="L_Name" ReadOnly="True" />
                        <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" ReadOnly="True" Visible="False" />
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" ReadOnly="True" Visible="False" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" ReadOnly="True" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <EmptyDataTemplate>
                        <asp:Label runat="server" Text="No customers found." />
                    </EmptyDataTemplate>
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </div>
            <div class="RightColumnGridDiv">
                <asp:Label runat="server" Text="Currently selected customer: " />
                <asp:DetailsView ID="SelectedCustDetailsView" CssClass="AbsolutePos" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="CustID" DataSourceID="SelectedCustData" ForeColor="#333333" GridLines="None" BorderStyle="Solid" Height="197px" Width="284px" HorizontalAlign="Center">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                    <EditRowStyle BackColor="#999999" />
                    <FieldHeaderStyle BackColor="#E9ECF1" Width="30%" Font-Bold="True" HorizontalAlign="Left" />
                    <Fields>
                        <asp:BoundField DataField="CustID" HeaderText="CustID" InsertVisible="False" ReadOnly="True" SortExpression="CustID" Visible="False" ItemStyle-HorizontalAlign="Center">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="F_Name" HeaderText="F_Name" SortExpression="F_Name" />
                        <asp:BoundField DataField="L_Name" HeaderText="L_Name" SortExpression="L_Name" />
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                        <asp:BoundField DataField="Notes" HeaderText="Notes" ItemStyle-Height="60px" SortExpression="Notes">
                            <ItemStyle Height="60px" />
                        </asp:BoundField>
                    </Fields>
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
                </asp:DetailsView>

            </div>
        </asp:Panel>
        <asp:Panel ID="CustNameSelectPanel" runat="server" HorizontalAlign="Center">
            <asp:Table CssClass="InputTable" runat="server" HorizontalAlign="Center">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter first name:" />
                    </asp:TableCell><asp:TableCell>
                        <asp:TextBox runat="server" CssClass="TableFormInput" ID="CustFNameSearchText" AutoPostBack="False" />

                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell>
                            <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter last name:" />
                    </asp:TableCell><asp:TableCell>
                        <asp:TextBox runat="server" CssClass="TableFormInput" ID="CustLNameSearchText" AutoPostBack="False" />

                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell>

                    </asp:TableCell><asp:TableCell>
                        <asp:Button ID="SearchCustNameButton" OnClick="SearchCustNameButton_Click" CssClass="TableFormInput" Text="Search" runat="server" />

                    </asp:TableCell></asp:TableRow></asp:Table></asp:Panel><asp:Panel ID="CustList" CssClass="PanelClass" runat="server" Visible="false">
            <asp:GridView ID="AllCustList" AlternatingRowStyle-BorderWidth="2" OnSelectedIndexChanged="AllCustList_SelectedIndexChanged" CssClass="GridViewClass" runat="server" OnRowDataBound="AllCustList_RowDataBound" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="CustID" DataSourceID="AllCustData" ForeColor="#333333" GridLines="Horizontal" HorizontalAlign="Center" AllowPaging="True" BorderStyle="Solid" BorderWidth="2px" PageSize="8">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="CustID" HeaderText="CustID" InsertVisible="False" ReadOnly="True" SortExpression="CustID" Visible="False" />
                    <asp:BoundField DataField="F_Name" HeaderText="F_Name" SortExpression="F_Name" />
                    <asp:BoundField DataField="L_Name" HeaderText="L_Name" SortExpression="L_Name" />
                    <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                    <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                </Columns>
                <EditRowStyle BorderWidth="2" BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            <asp:Table runat="server" CssClass="PageAction" HorizontalAlign="Center">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button runat="server" CssClass="TableFormButton" Text="Back" OnClick="CustBackButton_Click" />
                    </asp:TableCell></asp:TableRow></asp:Table></asp:Panel><asp:Panel ID="CreateCustPanel" runat="server">
            <asp:Table CssClass="TableForm" runat="server" CellPadding="5" HorizontalAlign="Center">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:RequiredFieldValidator runat="server" CssClass="ErrorStar" ErrorMessage="First Name required." Text="*" ControlToValidate="CustFNameText" />
                    </asp:TableCell><asp:TableCell>
                        <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter customer first name:" />
                    </asp:TableCell><asp:TableCell>
                        <asp:TextBox runat="server" CssClass="TableFormInput" MaxLength="20" ID="CustFNameText" />
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" CssClass="ErrorStar" ErrorMessage="Last Name required." Text="*" ControlToValidate="CustLNameText" />
                    </asp:TableCell><asp:TableCell>
                        <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter customer last name:" />
                    </asp:TableCell><asp:TableCell>
                        <asp:TextBox runat="server" CssClass="TableFormInput" MaxLength="20" ID="CustLNameText" />
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" CssClass="ErrorStar" ErrorMessage="Phone number required." Text="*" ControlToValidate="CustPhoneText" />
                    </asp:TableCell><asp:TableCell>
                            <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter customer phone:" />
                    </asp:TableCell><asp:TableCell>
                        <asp:TextBox ID="CustPhoneText" CssClass="TableFormInput" MaxLength="50" runat="server" />
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" CssClass="ErrorStar" ErrorMessage="Email required." Text="*" ControlToValidate="CustEmailText" />
                    </asp:TableCell><asp:TableCell>
                            <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter customer email:" />
                    </asp:TableCell><asp:TableCell>
                        <asp:TextBox ID="CustEmailText" CssClass="TableFormInput" MaxLength="100" runat="server" />
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" CssClass="ErrorStar" ErrorMessage="Notes required." Text="*" ControlToValidate="CustNotesText" />
                    </asp:TableCell><asp:TableCell>
                            <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter customer notes:" />
                    </asp:TableCell><asp:TableCell>
                        <asp:TextBox ID="CustNotesText" TextMode="MultiLine" MaxLength="250" runat="server" Height="60px" Font-Names="Arial" Font-Size="Smaller" />
                    </asp:TableCell></asp:TableRow></asp:Table><asp:Table runat="server" CssClass="PageAction" HorizontalAlign="Center" CellPadding="20">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button ID="CreateNewCustButton" CssClass="TableFormButton" Text="Create" runat="server" OnClick="CreateNewCustButton_Click" />
                    </asp:TableCell><asp:TableCell>
                        <asp:Button ID="ClearCustFormButton" CausesValidation="false" CssClass="TableFormButton" Text="Clear" runat="server" OnClick="ClearCustFormButton_Click" />
                    </asp:TableCell><asp:TableCell>
                        <asp:Button ID="BackToSearchButton" Text="Back to search" CausesValidation="false" CssClass="TableFormButton" runat="server" OnClick="BackToSearchButton_Click" />
                    </asp:TableCell></asp:TableRow></asp:Table><asp:ValidationSummary runat="server" CssClass="RequiredError" />
        </asp:Panel>
        <asp:Panel ID="EditCustomerPanel" runat="server" Visible="false">
            <asp:DetailsView ID="EditCustomerDetailsView" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="CustID" DataSourceID="SelectedCustData" ForeColor="#333333" GridLines="None" BorderStyle="Solid" Height="197px" Width="284px" HorizontalAlign="Center" DefaultMode="Edit">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Width="30%" Font-Bold="True" HorizontalAlign="Left" />
                <Fields>
                    <asp:BoundField DataField="CustID" HeaderText="CustID" InsertVisible="False" ReadOnly="True" SortExpression="CustID" Visible="False" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="F_Name" SortExpression="F_Name">
                        <EditItemTemplate>
                            <asp:TextBox ID="F_NameBinding" runat="server" Text='<%# Bind("F_Name") %>' MaxLength="20" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="F_NameBinding" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="L_Name" SortExpression="L_Name">
                        <EditItemTemplate>
                            <asp:TextBox ID="L_NameBinding" runat="server" Text='<%# Bind("L_Name") %>' MaxLength="20" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="L_NameBinding" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email" SortExpression="Email">
                        <EditItemTemplate>
                            <asp:TextBox ID="EmailBinding" runat="server" Text='<%# Bind("Email") %>' MaxLength="100" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="EmailBinding" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Phone" SortExpression="Phone">
                        <EditItemTemplate>
                            <asp:TextBox ID="PhoneBinding" runat="server" Text='<%# Bind("Phone") %>' MaxLength="50" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="PhoneBinding" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Notes" SortExpression="Notes">
                        <EditItemTemplate>
                            <asp:TextBox ID="NotesBinding" runat="server" Text='<%# Bind("Notes") %>' TextMode="MultiLine" MaxLength="250" Font-Names="Arial" Font-Size="Smaller" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="NotesBinding" />
                        </EditItemTemplate>
                        <ItemStyle Height="60px" />
                    </asp:TemplateField>
                    <asp:CommandField ButtonType="Button" ShowEditButton="True" />
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
            </asp:DetailsView>

            <asp:ValidationSummary runat="server" CssClass="RequiredError" />
            <asp:Table runat="server" HorizontalAlign="Center" CellPadding="20">
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:Button ID="BackButton" runat="server" Text="Back to search" OnClick="BackButton_Click" CausesValidation="false" />
                    </asp:TableCell></asp:TableRow></asp:Table></asp:Panel>
        <asp:Panel ID="MakeCustomerSelectionPanel" runat="server" Visible="false" HorizontalAlign="Center">
            <asp:Button runat="server" ID="QuotePageButton" Text="Start Quote" OnClick="QuotePageButton_Click" Visible="false" />
            <asp:Button ID="LinkToServiceRequestButton" CssClass="TableForm" Text="Continue Service Request" runat="server" OnClick="LinkToServiceRequestButton_Click" Visible="false" />
        </asp:Panel>
        <asp:Panel ID="NewCustActionPanel" runat="server">
            <asp:Table runat="server" CssClass="PageAction" CellPadding="20" HorizontalAlign="Center">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button ID="NewCustButton1" CssClass="TableFormButton" CausesValidation="false" runat="server" Text="Enter New Customer" OnClick="NewCustButton_Click" />
                    </asp:TableCell><asp:TableCell>
                        <asp:Button ID="CustomerListButton" CssClass="TableFormButton" runat="server" CausesValidation="false" OnClick="CustomerListButton_Click" Text="Customer List" />
                    </asp:TableCell></asp:TableRow></asp:Table></asp:Panel><asp:Panel ID="CustSelectedActionPanel" CssClass="PageAction" runat="server">
            <asp:Table runat="server" CssClass="PageAction" CellPadding="20" ID="CustSelectedActionTable" HorizontalAlign="Center">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button ID="NewCustButton2" CssClass="TableFormButton" CausesValidation="false" runat="server" Text="Enter New Customer" OnClick="NewCustButton_Click" />
                    </asp:TableCell><asp:TableCell>
                        <asp:Button ID="CustListButton" CssClass="TableFormButton" runat="server" CausesValidation="false" OnClick="CustomerListButton_Click" Text="Customer List" />
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell>
                        <asp:Button ID="EditCustomerButton" CssClass="TableFormButton" runat="server" Text="Edit Customer" OnClick="EditCustomerButton_Click" />
                    </asp:TableCell><asp:TableCell>
                        <asp:Button ID="DeleteCustomerButton" CssClass="TableFormButton" runat="server" Text="Delete Customer" OnClick="DeleteCustomerButton_Click" OnClientClick="if(!confirm('Do you want to delete this Customer?')){ return false; };" />
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell>
                        <asp:Button runat="server" ID="CustHistoryButton" CssClass="TableFormButton" Text="Customer History" OnClick="CustHistoryButton_Click" />
                    </asp:TableCell></asp:TableRow></asp:Table></asp:Panel><asp:Table runat="server" CssClass="PageAction" ID="PageActionTable" CellPadding="20" HorizontalAlign="Center">
            <asp:TableRow>
                <asp:TableCell>
                    <asp:Button ID="PageSignOutButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Sign Out" OnClick="PageSignOutButton_Click" />
                </asp:TableCell><asp:TableCell>
                    <asp:Button ID="ResetButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Reset Page" OnClick="Reset_Click" />
                </asp:TableCell><asp:TableCell>
                    <asp:Button ID="PageBackButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Back" OnClick="PageBackButton_Click" />
                </asp:TableCell></asp:TableRow></asp:Table><asp:SqlDataSource ID="CustData" runat="server"
            ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>"
            OnInserted="CustData_Inserted"
            SelectCommand="SELECT * FROM [Customer] WHERE ([F_Name] = @F_Name) UNION SELECT * FROM [Customer] WHERE ([L_Name] = @L_Name)"
            InsertCommand="CreateNewCustomer"
            InsertCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="CustFNameSearchText" Name="F_Name" PropertyName="Text" ConvertEmptyStringToNull="False" />
                <asp:ControlParameter ControlID="CustLNameSearchText" Name="L_Name" PropertyName="Text" ConvertEmptyStringToNull="False" />
            </SelectParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="CustFNameText" Name="CustFName" PropertyName="Text" ConvertEmptyStringToNull="False" />
                <asp:ControlParameter ControlID="CustLNameText" Name="CustLName" PropertyName="Text" ConvertEmptyStringToNull="False" />
                <asp:ControlParameter ControlID="CustNotesText" Name="CustNotes" PropertyName="Text" ConvertEmptyStringToNull="False" />
                <asp:ControlParameter ControlID="CustEmailText" Name="CustEmail" PropertyName="Text" ConvertEmptyStringToNull="False" />
                <asp:ControlParameter ControlID="CustPhoneText" Name="CustPhone" PropertyName="Text" ConvertEmptyStringToNull="False" />
                <asp:Parameter Name="New_PK" Direction="Output" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SelectedCustData" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>"
            SelectCommand="SELECT * FROM [Customer] WHERE ([CustID] = @CustID)" DeleteCommand="DELETE FROM [Customer] WHERE [CustID] = @CustID" InsertCommand="INSERT INTO [Customer] ([F_Name], [L_Name], [Notes], [Email], [Phone]) VALUES (@F_Name, @L_Name, @Notes, @Email, @Phone)" ProviderName="System.Data.SqlClient" UpdateCommand="UPDATE [Customer] SET [F_Name] = @F_Name, [L_Name] = @L_Name, [Notes] = @Notes, [Email] = @Email, [Phone] = @Phone WHERE [CustID] = @CustID">
            <DeleteParameters>
                <asp:ControlParameter ControlID="qcs" Name="CustID" Type="Int32" DefaultValue="" PropertyName="CustID" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="F_Name" Type="String" />
                <asp:Parameter Name="L_Name" Type="String" />
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="Phone" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="qcs" Name="CustID" Type="Int32" DefaultValue="" PropertyName="CustID" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="F_Name" Type="String" />
                <asp:Parameter Name="L_Name" Type="String" />
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="Phone" Type="String" />
                <asp:Parameter Name="CustID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="AllCustData" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [Customer]"></asp:SqlDataSource>
    </form>
</body>
</html>
