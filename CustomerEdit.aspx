<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerEdit.aspx.cs" Inherits="QuoteLogin.CustomerEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Customer Edit Page</title>
    <link rel="stylesheet" href="QuoteStyle.css" />
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
    <form class="MainForm" id="form1" runat="server">
        <asp:Panel ID="CustList" CssClass="PanelClass" runat="server" Visible="false">
            <div class="LabelDiv">
                <asp:GridView ID="AllCustList" AlternatingRowStyle-BorderWidth="2" OnSelectedIndexChanged="AllCustList_SelectedIndexChanged" CssClass="GridViewClass" runat="server" OnRowDataBound="AllCustList_RowDataBound" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="CustID" DataSourceID="CustDataSource" ForeColor="#333333" GridLines="Horizontal" AllowPaging="True" BorderStyle="Solid" BorderWidth="2px" PageSize="8">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="CustID" HeaderText="CustID" InsertVisible="False" ReadOnly="True" SortExpression="CustID" Visible="False" />
                        <asp:TemplateField HeaderText="Customer" SortExpression="F_Name">
                            <ItemTemplate>
                                <asp:Label ID="FirstNameBinding" runat="server" Text='<%# Bind("F_Name") %>' />
                                <asp:Label ID="LastNameBinding" runat="server" Text='<%# Bind("L_Name") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="L_Name" HeaderText="L_Name" SortExpression="L_Name" Visible="False" />
                        <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" Visible="False" />
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
                <asp:SqlDataSource ID="CustDataSource" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [Customer]"></asp:SqlDataSource>
            </div>

            <asp:Panel ID="EditCustomerNoSelectionPanel" runat="server">
                <div class="LabelDiv">
                    <asp:Table CssClass="LoginTable" runat="server" CellPadding="5" CellSpacing="1">
                        <asp:TableRow>
                            <asp:TableCell>
                            <asp:Label Text="Select Action:" CssClass="TableFormLabel" runat="server" />
                            </asp:TableCell><asp:TableCell Width="200px">
                                <asp:DropDownList ID="AddUserAction" OnSelectedIndexChanged="AddUserAction_SelectedIndexChanged" AutoPostBack="true" CssClass="inputbox" runat="server">
                                    <asp:ListItem Selected="True">--</asp:ListItem>
                                    <asp:ListItem>Add New Customer</asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
            </asp:Panel>
            <asp:Panel ID="EditCustomerSelectedPanel" runat="server">
                <div class="LabelDiv">
                    <asp:Table CssClass="LoginTable" runat="server" CellPadding="5" CellSpacing="1">
                        <asp:TableRow>
                            <asp:TableCell>
                            <asp:Label Text="Select Action:" CssClass="TableFormLabel" runat="server" />
                            </asp:TableCell><asp:TableCell Width="200px">
                                <asp:DropDownList ID="DropDownList1" OnSelectedIndexChanged="AddUserAction_SelectedIndexChanged" AutoPostBack="true" CssClass="inputbox" runat="server">
                                    <asp:ListItem Selected="True">--</asp:ListItem>
                                    <asp:ListItem>Add New Customer</asp:ListItem>
                                    <asp:ListItem>Edit Customer Email</asp:ListItem>
                                    <asp:ListItem>Edit Customer Phone</asp:ListItem>
                                    <asp:ListItem>Edit Customer Notes</asp:ListItem>
                                    <asp:ListItem>Delete Customer</asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
            </asp:Panel>
            <asp:Panel ID="AddCustPanel" runat="server">
                <div class="LabelDiv">
                    <asp:Table CssClass="TableForm" runat="server" CellPadding="5" HorizontalAlign="Center">
                        <asp:TableRow>
                            <asp:TableCell>
                        <asp:RequiredFieldValidator runat="server" CssClass="ErrorStar" Text="First Name required." ControlToValidate="CustFNameText" />
                            </asp:TableCell><asp:TableCell>
                        <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter customer first name:" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox runat="server" CssClass="TableFormInput" ID="CustFNameText" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" CssClass="ErrorStar" Text="Last Name required." ControlToValidate="CustLNameText" />
                            </asp:TableCell><asp:TableCell>
                        <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter customer last name:" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox runat="server" CssClass="TableFormInput" ID="CustLNameText" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" CssClass="ErrorStar" Text="Phone number required." ControlToValidate="CustPhoneText" />
                            </asp:TableCell><asp:TableCell>
                            <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter customer phone:" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="CustPhoneText" CssClass="TableFormInput" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" CssClass="ErrorStar" Text="Email required." ControlToValidate="CustEmailText" />
                            </asp:TableCell><asp:TableCell>
                            <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter customer email:" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="CustEmailText" CssClass="TableFormInput" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" CssClass="ErrorStar" Text="Notes required." ControlToValidate="CustNotesText" />
                            </asp:TableCell><asp:TableCell>
                            <asp:Label CssClass="TableFormLabel" runat="server" Text="Enter customer notes:" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="CustNotesText" CssClass="TableFormInput" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
                <div class="LabelDiv">
                    <asp:Table runat="server" CssClass="PageAction" HorizontalAlign="Center" CellPadding="20">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Button ID="CreateNewCustButton" CssClass="TableFormButton" Text="Create" runat="server" OnClick="CreateNewCustButton_Click" />
                            </asp:TableCell><asp:TableCell>
                                <asp:Button ID="ClearCustFormButton" CausesValidation="false" CssClass="TableFormButton" Text="Clear" runat="server" OnClick="ClearCustFormButton_Click" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
            </asp:Panel>
            <asp:Panel ID="EditCustomerNamePanel" Visible="false" runat="server">
                <div class="LabelDiv">
                    <asp:Table runat="server" CssClass="LoginTable" CellPadding="5" CellSpacing="1">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:RequiredFieldValidator ControlToValidate="EditCustomerFName" runat="server" CssClass="RequiredError" Text="Enter customer name."  >

                                </asp:RequiredFieldValidator>
                            </asp:TableCell><asp:TableCell>
                                <asp:Label Text="New Customer FName:" CssClass="TableFormLabel" runat="server" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="EditCustomerFName" CssClass="inputbox" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:RequiredFieldValidator ControlToValidate="EditCustomerName" runat="server" CssClass="RequiredError" Text="Enter customer name."  >

                                </asp:RequiredFieldValidator>
                            </asp:TableCell><asp:TableCell>
                                <asp:Label Text="New Customer LName:" CssClass="TableFormLabel" runat="server" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="EditCustomerLName" CssClass="inputbox" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                
                            </asp:TableCell><asp:TableCell>
                                
                            </asp:TableCell><asp:TableCell>
                                <asp:Button ID="EditEmployeeButton" Text="Submit" OnClick="EditEmployeeButton_Click" CssClass="inputbox" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
            </asp:Panel>
            <asp:Panel ID="EditCustomerEmailPanel" Visible="false" runat="server">
                <div class="LabelDiv">
                    <asp:Table runat="server" CssClass="LoginTable" CellPadding="5" CellSpacing="1">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:RequiredFieldValidator ControlToValidate="EditCustomerEmail" runat="server" CssClass="RequiredError" Text="Enter customer email."  >

                                </asp:RequiredFieldValidator>
                            </asp:TableCell><asp:TableCell>
                                <asp:Label Text="New Customer Email:" CssClass="TableFormLabel" runat="server" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="EditCustomerEmail" CssClass="inputbox" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                
                            </asp:TableCell><asp:TableCell>
                                
                            </asp:TableCell><asp:TableCell>
                                <asp:Button ID="Button1" Text="Submit" OnClick="EditEmployeeButton_Click" CssClass="inputbox" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
            </asp:Panel>
            <asp:Panel ID="Panel1" Visible="false" runat="server">
                <div class="LabelDiv">
                    <asp:Table runat="server" CssClass="LoginTable" CellPadding="5" CellSpacing="1">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:RequiredFieldValidator ControlToValidate="EditCustomerEmail" runat="server" CssClass="RequiredError" Text="Enter customer email."  >

                                </asp:RequiredFieldValidator>
                            </asp:TableCell><asp:TableCell>
                                <asp:Label Text="New Customer Email:" CssClass="TableFormLabel" runat="server" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="TextBox1" CssClass="inputbox" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                
                            </asp:TableCell><asp:TableCell>
                                
                            </asp:TableCell><asp:TableCell>
                                <asp:Button ID="Button2" Text="Submit" OnClick="EditEmployeeButton_Click" CssClass="inputbox" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
            </asp:Panel>
            <asp:Panel ID="UpdateCustomerPanel" runat="server">
            </asp:Panel>
            <asp:Panel ID="DeleteCustomerPanel" runat="server">
            </asp:Panel>
            <div class="LabelDiv">
                <asp:Table runat="server" CssClass="PageAction" ID="PageActionTable" CellPadding="20" HorizontalAlign="Center">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Button ID="PageSignOutButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Sign Out" OnClick="PageSignOutButton_Click" />
                        </asp:TableCell><asp:TableCell>
                            <asp:Button ID="PageBackButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Back" OnClick="PageBackButton_Click" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>
        </asp:Panel>
    </form>
</body>
</html>
