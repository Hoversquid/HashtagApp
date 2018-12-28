<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginEditPage.aspx.cs" Inherits="QuoteLogin.LoginEditPage" EnableEventValidation="false" %>

<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Logins</title>
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
    <form id="LoginEditForm" runat="server">
        <cstate:QuoteControlState ID="qcs" runat="server" />
        <div class="MainForm">
            <div class="LabelDiv">
                <asp:GridView ID="LoginGridView" CssClass="GridViewClass" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" AllowSorting="True" OnRowDataBound="LoginGridView_RowDataBound" OnSelectedIndexChanging="LoginGridView_SelectedIndexChanging" OnSelectedIndexChanged="LoginGridView_SelectedIndexChanged" DataKeyNames="UserID" AllowPaging="True" PageSize="8">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="UserID" SortExpression="UserID" HeaderText="UserID" ReadOnly="True" Visible="False" />
                        <asp:BoundField DataField="TypeID" SortExpression="TypeID" HeaderText="TypeID" Visible="False" />
                        <asp:TemplateField HeaderText="Employee" SortExpression="FName">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("FName") %>'></asp:Label>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("LName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="User" HeaderText="User" SortExpression="User" />
                        <asp:BoundField DataField="Permissions" HeaderText="Permissions" SortExpression="Permissions" />
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
                <asp:SqlDataSource ID="AdminLoginViewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT LV.[UserID], UP.[TypeID], LV.[FName], LV.[LName], LV.[User], LV.[Permissions]  FROM [LoginView] LV, [UserPermissions] UP WHERE (UP.UserID) = LV.UserID" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

                <asp:SqlDataSource ID="SManagerLoginViewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT LV.[UserID], UP.[TypeID], LV.[FName], LV.[LName], LV.[User], LV.[Permissions]  FROM [LoginView] LV, [UserPermissions] UP WHERE (UP.UserID) = LV.UserID AND (UP.[TypeID] &gt; 2)" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

                <asp:SqlDataSource ID="AssistManagerLoginViewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT LV.[UserID], UP.[TypeID], LV.[FName], LV.[LName], LV.[User], LV.[Permissions]  FROM [LoginView] LV, [UserPermissions] UP WHERE (UP.UserID) = LV.UserID AND (UP.[TypeID] &gt; 3)" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            </div>

            <asp:Panel ID="EditLoginActionNoUserPanel" runat="server">
                <div class="LabelDiv">
                    <asp:Table CssClass="LoginTable" runat="server" CellPadding="5" CellSpacing="1">
                        <asp:TableRow>
                            <asp:TableCell>
                            <asp:Label Text="Select Action:" CssClass="TableFormLabel" runat="server" />
                            </asp:TableCell><asp:TableCell Width="200px">
                                <asp:DropDownList ID="AddUserAction" OnSelectedIndexChanged="AddUserAction_SelectedIndexChanged" AutoPostBack="true" CssClass="inputbox" runat="server">
                                    <asp:ListItem Selected="True">--</asp:ListItem>
                                    <asp:ListItem>Add New User</asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
            </asp:Panel>
            <asp:Panel ID="EditLoginActionUserSelectedPanel" Visible="false" runat="server">
                <div class="LabelDiv">
                    <asp:Table ID="UserSelectedTable" CssClass="LoginTable" runat="server" CellPadding="5" CellSpacing="1">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Label ID="EditLoginActionLabel" Text="Select Action:" CssClass="TableFormLabel" runat="server" />
                            </asp:TableCell><asp:TableCell Width="200px">
                                <asp:DropDownList ID="EditLoginAction" OnSelectedIndexChanged="EditLoginAction_SelectedIndexChanged" AutoPostBack="true" CssClass="inputbox" runat="server">
                                    <asp:ListItem Selected="True">--</asp:ListItem>
                                    <asp:ListItem>Add New User</asp:ListItem>
                                    <asp:ListItem>Edit Employee Name</asp:ListItem>
                                    <asp:ListItem>Edit User Name</asp:ListItem>
                                    <asp:ListItem>Edit Permissions</asp:ListItem>
                                    <asp:ListItem>Edit Password</asp:ListItem>
                                    <asp:ListItem>Delete Entry</asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
            </asp:Panel>
            <asp:Panel ID="AddUserPanel" Visible="false" runat="server">
                <div id="EditLoginDiv" class="LabelDiv">
                    <asp:Table ID="AddUserTable" CssClass="LoginTable" runat="server" CellPadding="5" CellSpacing="1">
                        <asp:TableRow>
                            <asp:TableCell Width="250px">
                                <asp:RequiredFieldValidator ID="AddEmpValidator" CssClass="RequiredError" runat="server" ControlToValidate="AddEmpFNameText" Display="Dynamic" ErrorMessage="Enter employee name." />
                                <asp:RegularExpressionValidator ID="AddEmpRegExValidator" CssClass="RequiredError" runat="server" ValidationExpression="[^\s]+" ControlToValidate="AddEmpFNameText" Display="Dynamic" ErrorMessage="Enter valid name." />
                            </asp:TableCell><asp:TableCell>
                                    <asp:Label CssClass="TableFormLabel" Text="First Name:" runat="server" />
                                    
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="AddEmpFNameText" CssClass="inputbox" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="RequiredError" ControlToValidate="AddEmpLNameText" Display="Dynamic" ErrorMessage="Enter name." />
                                <asp:RegularExpressionValidator ID="AddUserRegExValidator" runat="server" CssClass="RequiredError" ValidationExpression="[^\s]+" ControlToValidate="AddEmpLNameText" Display="Dynamic" ErrorMessage="Enter valid name." />
                            </asp:TableCell><asp:TableCell>
                                    <asp:Label CssClass="TableFormLabel" Text="Last Name:" runat="server" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="AddEmpLNameText" CssClass="inputbox" runat="server" />

                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:RequiredFieldValidator ID="AddUserValidator" runat="server" CssClass="RequiredError" ControlToValidate="AddUserText" Display="Dynamic" ErrorMessage="Enter user name." />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" CssClass="RequiredError" ValidationExpression="[^\s]+" ControlToValidate="AddUserText" Display="Dynamic" ErrorMessage="Enter valid name." />
                            </asp:TableCell><asp:TableCell>
                                    <asp:Label CssClass="TableFormLabel" Text="Signin Name:" runat="server" />
                                    
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="AddUserText" CssClass="inputbox" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:RequiredFieldValidator ID="AddPassValidator1" runat="server" CssClass="RequiredError" ControlToValidate="AddPassText1" Display="Dynamic" ErrorMessage="Enter password." />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" CssClass="RequiredError" ValidationExpression="[^\s]+" ControlToValidate="AddPassText1" Display="Dynamic" ErrorMessage="Enter valid name." />
                            </asp:TableCell><asp:TableCell>
                                    <asp:Label CssClass="TableFormLabel" Text="Password:" runat="server" />
                                    
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="AddPassText1" CssClass="inputbox" TextMode="Password" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:RequiredFieldValidator ID="AddPassValidator2" runat="server" CssClass="RequiredError" ControlToValidate="AddPassText2" ErrorMessage="Enter password verification." Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" CssClass="RequiredError" ValidationExpression="[^\s]+" ControlToValidate="AddPassText2" Display="Dynamic" ErrorMessage="Enter valid name." />
                                <asp:CompareValidator runat="server" ControlToCompare="AddPassText1" CssClass="RequiredError" ControlToValidate="AddPassText2" Display="Dynamic" ErrorMessage="Passwords don't match." />
                            </asp:TableCell><asp:TableCell>
                                    <asp:Label CssClass="TableFormLabel" Text="Confirm Password:" runat="server" />
                                    
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="AddPassText2" CssClass="inputbox" TextMode="Password" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:RequiredFieldValidator ID="AddPermValidator" runat="server" CssClass="RequiredError" InitialValue="-1" ControlToValidate="AddPermDropDown" ErrorMessage="Enter permissions." Display="Dynamic" />
                            </asp:TableCell><asp:TableCell>
                                    <asp:Label CssClass="TableFormLabel" Text="Permissions:" runat="server" />
                                    
                            </asp:TableCell><asp:TableCell Wrap="True">
                                <asp:DropDownList ID="AddPermDropDown" runat="server" CssClass="inputbox" DataTextField="TypeName" DataValueField="PermTypeID" AppendDataBoundItems="true">
                                    <asp:ListItem Selected="True" Value="-1">--</asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                
                            </asp:TableCell><asp:TableCell>
                                
                            </asp:TableCell><asp:TableCell>
                                <asp:Button ID="AddUserButton" CssClass="inputbox" CausesValidation="true" Text="Submit" OnClick="AddUserButton_Click" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
            </asp:Panel>
            <asp:Panel ID="EditEmployeePanel" Visible="false" runat="server">
                <div class="LabelDiv">
                    <asp:Table runat="server" CssClass="LoginTable" CellPadding="5" CellSpacing="1">
                        <asp:TableRow>
                            <asp:TableCell Width="250px">
                                <asp:RequiredFieldValidator ControlToValidate="EditEmployeeFName" runat="server" CssClass="RequiredError" Text="Enter employee name." Display="Dynamic" />
                                <asp:RegularExpressionValidator ControlToValidate="EditEmployeeFName" runat="server" ValidationExpression="[^\s]+" CssClass="RequiredError" Text="Enter valid employee name." Display="Dynamic" />
                            </asp:TableCell><asp:TableCell>
                                <asp:Label Text="New Employee FName:" CssClass="TableFormLabel" runat="server" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="EditEmployeeFName" CssClass="inputbox" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:RequiredFieldValidator ControlToValidate="EditEmployeeLName" runat="server" CssClass="RequiredError" Text="Enter employee name." Display="Dynamic" />
                                <asp:RegularExpressionValidator ControlToValidate="EditEmployeeLName" runat="server" ValidationExpression="[^\s]+" CssClass="RequiredError" Text="Enter valid employee name." Display="Dynamic" />
                            </asp:TableCell><asp:TableCell>
                                <asp:Label Text="New Employee LName:" CssClass="TableFormLabel" runat="server" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="EditEmployeeLName" CssClass="inputbox" runat="server" />
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
            <asp:Panel ID="UserNameEditPanel" Visible="false" runat="server">
                <div class="LabelDiv">
                    <asp:Table CssClass="LoginTable" runat="server" CellPadding="5" CellSpacing="1">
                        <asp:TableRow>
                            <asp:TableCell Width="250px">
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="EditUserText" ErrorMessage="Enter user name." Display="Dynamic"  CssClass="RequiredError" />
                                <asp:RegularExpressionValidator ControlToValidate="EditUserText" ValidationExpression="[^\s]+" runat="server" CssClass="RequiredError" Text="Enter valid user name." Display="Dynamic" />

                            </asp:TableCell><asp:TableCell>
                            <asp:Label CssClass="TableFormLabel" Text="New Username:" runat="server" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox runat="server" CssClass="inputbox" ID="EditUserText" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                
                            </asp:TableCell><asp:TableCell>
                                
                            </asp:TableCell><asp:TableCell>
                                <asp:Button ID="EditUserButton" Text="Submit" OnClick="EditUserButton_Click" CssClass="inputbox" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
            </asp:Panel>
            <asp:Panel ID="PermEditPanel" Visible="false" runat="server">
                <div class="LabelDiv">
                    <asp:Table runat="server" CssClass="LoginTable" CellPadding="5" CellSpacing="1">
                        <asp:TableRow>
                            <asp:TableCell Width="250px">
                            <asp:RequiredFieldValidator runat="server" CssClass="RequiredError" Text="Enter new permissions."  ControlToValidate="PermissionsDropDown" InitialValue="-1" />
                                
                            </asp:TableCell><asp:TableCell>
                            <asp:Label CssClass="TableFormLabel" Text="New Permissions:" runat="server" />
                            </asp:TableCell><asp:TableCell>
                                <asp:DropDownList ID="PermissionsDropDown" CssClass="inputbox" AppendDataBoundItems="true" DataTextField="TypeName" DataValueField="PermTypeID" runat="server">
                                    <asp:ListItem Value="-1" Selected="True">--</asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                
                            </asp:TableCell><asp:TableCell>
                                
                            </asp:TableCell><asp:TableCell>
                                <asp:Button ID="PermEditButton" CssClass="inputbox" Text="Submit" runat="server" OnClick="PermEditButton_Click" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
            </asp:Panel>
            <asp:Panel ID="PassEditPanel" Visible="false" runat="server">
                <div class="LabelDiv">
                    <asp:Table runat="server" CssClass="LoginTable" CellPadding="5" CellSpacing="1">
                        <asp:TableRow>
                            <asp:TableCell Width="250px">
                                <asp:RequiredFieldValidator CssClass="RequiredError" runat="server" ControlToValidate="EditPasswordText1" ErrorMessage="Enter new password." />
                                <asp:RegularExpressionValidator CssClass="RequiredError" runat="server" ControlToValidate="EditPasswordText1" ValidationExpression="[^\s]+" ErrorMessage="Enter valid password." />
                            </asp:TableCell><asp:TableCell>
                            <asp:Label runat="server" CssClass="TableFormLabel" Text="Enter password:" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="EditPasswordText1" CssClass="inputbox" TextMode="Password" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                            <asp:RequiredFieldValidator CssClass="RequiredError" runat="server" ControlToValidate="EditPasswordText2" Text="Verify new password."  />
                                <asp:RegularExpressionValidator CssClass="RequiredError" runat="server" ControlToValidate="EditPasswordText2" ValidationExpression="[^\s]+" ErrorMessage="Enter valid password." />
                                <asp:CompareValidator runat="server" ControlToCompare="EditPasswordText1" CssClass="RequiredError" ControlToValidate="EditPasswordText2" Display="Dynamic" ErrorMessage="Passwords don't match." />
                            </asp:TableCell><asp:TableCell>
                            <asp:Label runat="server" CssClass="TableFormLabel" Text="Verify password:" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="EditPasswordText2" CssClass="inputbox" TextMode="Password" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                
                            </asp:TableCell><asp:TableCell>
                                
                            </asp:TableCell><asp:TableCell>
                                <asp:Button ID="EditPassButton" CssClass="inputbox" Text="Submit" OnClick="EditPassButton_Click" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
            </asp:Panel>
            <asp:Panel ID="DeleteEditPanel" Visible="false" runat="server">
                <div class="LabelDiv">
                    <asp:Table CssClass="LoginTable" runat="server">
                        <asp:TableRow>
                            <asp:TableCell Width="250px">
                                <asp:Label ID="RequiredName" CssClass="RequiredError" runat="server" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="DeleteUserText" ErrorMessage="Name required." Display="Dynamic" CssClass="RequiredError" />
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="DeleteUserText" ValidationExpression="[^\s]+" ErrorMessage="Valid name required." Display="Dynamic" CssClass="RequiredError" />

                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:Label Text="Enter user name to verify deletion:" runat="server" />
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="DeleteUserText" CssClass="inputbox" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell></asp:TableCell>
                            <asp:TableCell></asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Button ID="DeleteUserButton" OnClick="DeleteUserButton_Click" Text="Submit" CssClass="inputbox" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>

                </div>
            </asp:Panel>
            <div class="LabelDiv">
                <asp:Table runat="server" CssClass="PageAction" ID="PageActionTable" CellPadding="20" HorizontalAlign="Center">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Button ID="PageSignOutButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Sign Out" OnClick="PageSignOutButton_Click" />
                        </asp:TableCell><asp:TableCell></asp:TableCell><asp:TableCell>
                            <asp:Button ID="PageBackButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Back" OnClick="PageBackButton_Click" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>
            <asp:SqlDataSource ID="AdminPermissionsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [PermissionsType]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SManagerPermissionsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [PermissionsType] WHERE ([PermTypeID] &gt; 2) "></asp:SqlDataSource>
            <asp:SqlDataSource ID="AssistManagerPermissionsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [PermissionsType] WHERE ([PermTypeID] &gt; 3) "></asp:SqlDataSource>

        </div>
    </form>
</body>
</html>
