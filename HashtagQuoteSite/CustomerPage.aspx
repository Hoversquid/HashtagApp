<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerPage.aspx.cs" Inherits="QuoteLogin.CustomerPage" EnableEventValidation = "false" %>

<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="QuoteStyle.css" />
    <title>Add New Customer</title>
</head>
<body>
    <form id="CustForm" class="MainForm" runat="server">
        <cstate:QuoteControlState ID="qcs" runat="server"></cstate:QuoteControlState>
        <div class="LabelDiv">
            <div class="LeftColumnGridDiv">
            <asp:GridView
                ID="CustGridView" OnRowDataBound="CustGridView_RowDataBound" OnSelectedIndexChanged="CustGridView_SelectedIndexChanged" runat="server" AutoGenerateColumns="False" DataKeyNames="CustID" DataSourceID="CustData" CellPadding="4" ForeColor="#333333" GridLines="None" AllowSorting="True" Height="190px">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="CustID" HeaderText="CustID" SortExpression="CustID" ReadOnly="True" Visible="False" />
                    <asp:BoundField DataField="F_Name" HeaderText="F_Name" SortExpression="F_Name" ReadOnly="True" />
                    <asp:BoundField DataField="L_Name" HeaderText="L_Name" SortExpression="L_Name" ReadOnly="True" />
                    <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" ReadOnly="True" Visible="False" />
                    <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" ReadOnly="True" Visible="False" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" ReadOnly="True" Visible="False" />
                    <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" ReadOnly="True" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
                </div>
            <div class="RightColumnGridDiv">
            <asp:DetailsView ID="SelectedCustDetailsView" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="CustID" DataSourceID="SelectedCustData" ForeColor="#333333" GridLines="None" BorderStyle="Solid" Height="190px">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>
                    <asp:BoundField DataField="CustID" HeaderText="CustID" InsertVisible="False" ReadOnly="True" SortExpression="CustID" Visible="False" />
                    <asp:BoundField DataField="F_Name" HeaderText="F_Name" SortExpression="F_Name" />
                    <asp:BoundField DataField="L_Name" HeaderText="L_Name" SortExpression="L_Name" />
                    <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                    <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                    <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:DetailsView>

                </div>
            <asp:Panel ID="CustNameSelectPanel" runat="server">
                <asp:Table CssClass="InputTable" runat="server">
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

                        
                        </asp:TableCell></asp:TableRow></asp:Table></asp:Panel></div><asp:Panel ID="CreateCustPanel" runat="server">
            <div class="LabelDiv">
                <asp:Table CssClass="TableForm" runat="server" CellPadding="5">
                    <asp:TableRow>
                        <asp:TableCell>
                        <asp:RequiredFieldValidator runat="server" CssClass="ErrorStar" ErrorMessage="First Name required." Text="*" ControlToValidate="CustFNameText" />
                        </asp:TableCell><asp:TableCell>
                        <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter customer first name:" />
                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox runat="server" CssClass="TableFormInput" ID="CustFNameText" />
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" CssClass="ErrorStar" ErrorMessage="Last Name required." Text="*" ControlToValidate="CustLNameText" />
                        </asp:TableCell><asp:TableCell>
                        <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter customer last name:" />
                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox runat="server" CssClass="TableFormInput" ID="CustLNameText" />
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell>
                        </asp:TableCell><asp:TableCell>
                            <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter customer phone:" />
                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox ID="CustPhoneText" CssClass="TableFormInput" runat="server" />
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell>
                        </asp:TableCell><asp:TableCell>
                            <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter customer email:" />
                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox ID="CustEmailText" CssClass="TableFormInput" runat="server" />
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell>
                        </asp:TableCell><asp:TableCell>
                            <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter customer address:" />
                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox ID="CustAddressText" CssClass="TableFormInput" runat="server" />
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell>
                        </asp:TableCell><asp:TableCell>
                            <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter customer notes:" />
                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox ID="CustNotesText" CssClass="TableFormInput" runat="server" />
                        </asp:TableCell></asp:TableRow></asp:Table></div><div class="LabelDiv">
                <asp:Table runat="server" CssClass="TableForm" CellPadding="10">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Button ID="CreateNewCustButton" CssClass="TableFormButton" Text="Create" runat="server" OnClick="CreateNewCustButton_Click" />
                        </asp:TableCell><asp:TableCell>
                            <asp:Button ID="ClearCustFormButton" CausesValidation="false" CssClass="TableFormButton" Text="Clear" runat="server" OnClick="ClearCustFormButton_Click" />
                        </asp:TableCell><asp:TableCell>
                            <asp:Button ID="BackToSearchButton" Text="Back to search" CausesValidation="false" CssClass="TableFormButton" runat="server" OnClick="Reset_Click" />
                        </asp:TableCell></asp:TableRow></asp:Table></div><div class="LabelDiv">
                <asp:ValidationSummary runat="server" CssClass="RequiredError" />
            </div>
        </asp:Panel>

        <asp:Panel ID="NewCustActionPanel" runat="server">
            <div class="LabelDiv">
                <asp:Table runat="server" CssClass="TableForm" ID="Table1" CellPadding="20">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Button ID="NewCustButton" CausesValidation="false" runat="server" Text="Enter New Customer" OnClick="NewCustButton_Click" />
                        </asp:TableCell><asp:TableCell>
                            <asp:Button ID="CustomerListButton" runat="server" CausesValidation="false" OnClick="CustomerListButton_Click" Text="Customer List"/>
                                        </asp:TableCell><asp:TableCell>
                            <asp:Button runat="server" CausesValidation="false" OnClick="Reset_Click" Text="Reset"/>
                        </asp:TableCell></asp:TableRow></asp:Table></div></asp:Panel><asp:Panel ID="CustSelectedActionPanel" runat="server">
            <div class="LabelDiv">
                <asp:Table runat="server" CssClass="TableForm" ID="CustSelectedActionTable" CellPadding="20">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Button ID="QuotePageButton" CssClass="TableFormButton" runat="server" Text="Start Quote" OnClick="QuotePageButton_Click" />
                        </asp:TableCell><asp:TableCell>
                            <asp:Button ID="ClearCustButton" OnClick="Reset_Click" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Reset" />
                        </asp:TableCell></asp:TableRow></asp:Table></div></asp:Panel><div class="LabelDiv">
            <asp:Table runat="server" CssClass="PageAction" ID="PageActionTable" CellPadding="20">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button ID="PageSignOutButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Sign Out" OnClick="PageSignOutButton_Click" />
                    </asp:TableCell><asp:TableCell></asp:TableCell><asp:TableCell>
                        <asp:Button ID="PageBackButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Back" OnClick="PageBackButton_Click" />
                    </asp:TableCell></asp:TableRow></asp:Table></div><asp:SqlDataSource ID="CustData" runat="server"
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
                <asp:ControlParameter ControlID="CustAddressText" Name="CustAddress" PropertyName="Text" ConvertEmptyStringToNull="False" />
                <asp:ControlParameter ControlID="CustNotesText" Name="CustNotes" PropertyName="Text" ConvertEmptyStringToNull="False" />
                <asp:ControlParameter ControlID="CustEmailText" Name="CustEmail" PropertyName="Text" ConvertEmptyStringToNull="False" />
                <asp:ControlParameter ControlID="CustPhoneText" Name="CustPhone" PropertyName="Text" ConvertEmptyStringToNull="False" />
                <asp:Parameter Name="New_PK" Direction="Output" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SelectedCustData" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>"
            SelectCommand="SELECT * FROM [Customer] WHERE ([CustID] = @CustID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="qcs" Name="CustID" PropertyName="CustID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
