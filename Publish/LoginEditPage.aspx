<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginEditPage.aspx.cs" Inherits="QuoteLogin.LoginEditPage" %>
<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Logins</title>
    <link rel="stylesheet" href="QuoteStyle.css" />
</head>
<body>
    <form id="LoginEditForm" runat="server">
        <cstate:QuoteControlState ID="qcs" runat="server" />
        <div class="MainForm">
            <div class="LabelDiv">
                <asp:GridView ID="AdminLoginGridView" Visible="False" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" AllowSorting="True" OnSelectedIndexChanging="LoginGridView_SelectedIndexChanging" OnSelectedIndexChanged="LoginGridView_SelectedIndexChanged" Width="350px" DataKeyNames="UserID" DataSourceID="AdminLoginViewDataSource">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:CommandField ButtonType="Button" ShowSelectButton="True" />
                        <asp:BoundField DataField="UserID" SortExpression="UserID" HeaderText="UserID" ReadOnly="True" Visible="False" />
                        <asp:BoundField DataField="TypeID" SortExpression="TypeID" HeaderText="TypeID" Visible="False" />
                        <asp:BoundField DataField="Employee_Name" SortExpression="Employee_Name" HeaderText="Employee_Name" />
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
                <asp:SqlDataSource ID="AdminLoginViewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT LV.[UserID], UP.[TypeID], LV.[Employee Name] AS Employee_Name, LV.[User], LV.[Permissions]  FROM [LoginView] LV, [UserPermissions] UP WHERE (UP.UserID) = LV.UserID"></asp:SqlDataSource>

                <asp:GridView ID="SManagerLoginView" runat="server" Visible="False" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" AllowSorting="True" OnSelectedIndexChanging="LoginGridView_SelectedIndexChanging" OnSelectedIndexChanged="LoginGridView_SelectedIndexChanged" Width="350px" DataKeyNames="UserID" DataSourceID="SManagerLoginViewDataSource">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:CommandField ButtonType="Button" ShowSelectButton="True" />
                        <asp:BoundField DataField="UserID" SortExpression="UserID" HeaderText="UserID" ReadOnly="True" Visible="False" />
                        <asp:BoundField DataField="TypeID" SortExpression="TypeID" HeaderText="TypeID" Visible="False" />
                        <asp:BoundField DataField="Employee_Name" SortExpression="Employee_Name" HeaderText="Employee_Name" />
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
                <asp:SqlDataSource ID="SManagerLoginViewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT LV.[UserID], UP.[TypeID], LV.[Employee Name] AS Employee_Name, LV.[User], LV.[Permissions]  FROM [LoginView] LV, [UserPermissions] UP WHERE (UP.UserID) = LV.UserID AND (UP.[TypeID] &gt; 2)"></asp:SqlDataSource>

                <asp:GridView ID="AssistManagerLoginView" runat="server" Visible="False" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" AllowSorting="True" OnSelectedIndexChanging="LoginGridView_SelectedIndexChanging" OnSelectedIndexChanged="LoginGridView_SelectedIndexChanged" Width="350px" DataKeyNames="UserID" DataSourceID="AssistManagerLoginViewDataSource">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:CommandField ButtonType="Button" ShowSelectButton="True" />
                        <asp:BoundField DataField="UserID" SortExpression="UserID" HeaderText="UserID" ReadOnly="True" Visible="False" />
                        <asp:BoundField DataField="TypeID" SortExpression="TypeID" HeaderText="TypeID" Visible="False" />
                        <asp:BoundField DataField="Employee_Name" SortExpression="Employee_Name" HeaderText="Employee_Name" />
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
                <asp:SqlDataSource ID="AssistManagerLoginViewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT LV.[UserID], UP.[TypeID], LV.[Employee Name] AS Employee_Name, LV.[User], LV.[Permissions]  FROM [LoginView] LV, [UserPermissions] UP WHERE (UP.UserID) = LV.UserID AND (UP.[TypeID] &gt; 3)"></asp:SqlDataSource>
            </div>

            <asp:Panel ID="EditLoginActionNoUserPanel" runat="server">
                <div class="LabelDiv">
                    <asp:Label Text="Select Action:" CssClass="MainLabel" runat="server" />
                    <asp:DropDownList ID="AddUserAction" OnSelectedIndexChanged="AddUserAction_SelectedIndexChanged" AutoPostBack="true" CssClass="inputbox" runat="server">
                        <asp:ListItem Selected="True">--</asp:ListItem>
                        <asp:ListItem>Add New User</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </asp:Panel>
            <asp:Panel ID="EditLoginActionUserSelectedPanel" Visible="false" runat="server">
                <div class="LabelDiv">
                    <asp:Table ID="UserSelectedTable" runat="server">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Label ID="EditLoginActionLabel" Text="Select Action:" CssClass="MainLabel" runat="server" />
                            </asp:TableCell><asp:TableCell>
                                <asp:DropDownList ID="EditLoginAction" OnSelectedIndexChanged="EditLoginAction_SelectedIndexChanged" AutoPostBack="true" CssClass="inputbox" runat="server">
                                    <asp:ListItem Selected="True">--</asp:ListItem>
                                    <asp:ListItem>Add New User</asp:ListItem>
                                    <asp:ListItem>Edit Employee Name</asp:ListItem>
                                    <asp:ListItem>Edit User Name</asp:ListItem>
                                    <asp:ListItem>Edit Permissions</asp:ListItem>
                                    <asp:ListItem>Edit Password</asp:ListItem>
                                    <asp:ListItem>Delete Entry</asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell></asp:TableRow></asp:Table></div></asp:Panel><asp:Panel ID="AddUserPanel" Visible="false" runat="server">
                <div id="EditLoginDiv" class="LabelDiv">
                    <asp:Table ID="AddUserTable" runat="server">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:RequiredFieldValidator ID="AddEmpValidator" runat="server" CssClass="ErrorStar" ControlToValidate="AddEmpText" ErrorMessage="Enter employee name" Text="*" />
                            </asp:TableCell><asp:TableCell>
                                <div>
                                    <asp:Label CssClass="MainLabel" Text="Employee Name:" runat="server" />
                                    <asp:TextBox ID="AddEmpText" CssClass="inputbox" runat="server" />
                                </div>
                            </asp:TableCell></asp:TableRow><asp:TableRow>
                            <asp:TableCell>
                                <asp:RequiredFieldValidator ID="AddUserValidator" runat="server" CssClass="ErrorStar" ControlToValidate="AddUserText" ErrorMessage="Enter user name" Text="*" />
                            </asp:TableCell><asp:TableCell>
                                <div>
                                    <asp:Label CssClass="MainLabel" Text="User Signin Name:" runat="server" />
                                    <asp:TextBox ID="AddUserText" CssClass="inputbox" runat="server" />
                                </div>
                            </asp:TableCell></asp:TableRow><asp:TableRow>
                            <asp:TableCell>
                                <asp:RequiredFieldValidator ID="AddPassValidator1" runat="server" CssClass="ErrorStar" ControlToValidate="AddPassText1" ErrorMessage="Enter password" Text="*" />
                            </asp:TableCell><asp:TableCell>
                                <div>
                                    <asp:Label CssClass="MainLabel" Text="Password:" runat="server" />
                                    <asp:TextBox ID="AddPassText1" CssClass="inputbox" runat="server" />
                                </div>
                            </asp:TableCell></asp:TableRow><asp:TableRow>
                            <asp:TableCell>
                                <asp:RequiredFieldValidator ID="AddPassValidator2" runat="server" CssClass="ErrorStar" ControlToValidate="AddPassText2" ErrorMessage="Enter password verification" Text="*" />
                            </asp:TableCell><asp:TableCell>
                                <div class="TableDiv">
                                    <asp:Label CssClass="MainLabel" Text="Confirm Password:" runat="server" />
                                    <asp:TextBox ID="AddPassText2" CssClass="inputbox" runat="server" />
                                </div>
                            </asp:TableCell></asp:TableRow><asp:TableRow>
                            <asp:TableCell>
                                <asp:RequiredFieldValidator ID="AddPermValidator" runat="server" CssClass="ErrorStar" InitialValue="-1" ControlToValidate="AddPermDropDown" ErrorMessage="Enter permissions" Text="*" />
                            </asp:TableCell><asp:TableCell>
                                <div class="TableDiv">
                                    <asp:Label CssClass="MainLabel" Text="Permissions:" runat="server" />
                                    <asp:DropDownList ID="AddPermDropDown" CssClass="inputbox" runat="server" DataTextField="TypeName" DataValueField="PermTypeID" AppendDataBoundItems="true">
                                        <asp:ListItem Selected="True" Value="-1">--</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </asp:TableCell></asp:TableRow><asp:TableRow>
                            <asp:TableCell>
                                <div class="LabelDiv">
                                    <asp:Button ID="AddUserButton" CssClass="inputbox" Text="Add New User" OnClick="AddUserButton_Click" runat="server" />
                                </div>
                            </asp:TableCell></asp:TableRow></asp:Table><div class="LabelDiv">
                        <asp:Label ID="PasswordMatchError" CssClass="RequiredError" runat="server" />
                    </div>
                    <div class="TableDiv">
                        <asp:ValidationSummary ID="AddEmpValidationSummary" CssClass="RequiredError" runat="server" />
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel ID="EditEmployeePanel" Visible="false" runat="server">
                <div class="LabelDiv">
                    <asp:Table CssClass="TableForm" runat="server">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:RequiredFieldValidator ControlToValidate="EditEmployee" runat="server" CssClass="RequiredError" ErrorMessage="Enter employee name." Text="*" >

                                </asp:RequiredFieldValidator>
                            </asp:TableCell><asp:TableCell>
                                <asp:Label Text="New Employee Name:" CssClass="TableFormLabel" runat="server" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="EditEmployee" CssClass="inputbox" runat="server" />
                            </asp:TableCell></asp:TableRow></asp:Table></div><div class="LabelDiv">
                    <asp:ValidationSummary ID="EditEmpValidationSummary" CssClass="RequiredError" runat="server" />
                </div>
                <div class="LabelDiv">
                    <asp:Button ID="EditEmployeeButton" Text="Edit Name" OnClick="EditEmployeeButton_Click" CssClass="MainLabel" runat="server" />
                </div>

            </asp:Panel>
            <asp:Panel ID="UserNameEditPanel" Visible="false" class="LabelDiv" runat="server">
                <div class="LabelDiv">
                    <asp:Table CssClass="TableForm" runat="server">
                        <asp:TableRow>
                            <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="EditUserText" ErrorMessage="Enter user name." Text="*" CssClass="ErrorStar" />
                            </asp:TableCell><asp:TableCell>
                            <asp:Label CssClass="TableFormLabel" Text="New Username:" runat="server" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox runat="server" CssClass="inputbox" ID="EditUserText" />
                            </asp:TableCell></asp:TableRow></asp:Table></div><div class="LabelDiv">
                    <asp:ValidationSummary runat="server" CssClass="RequiredError" />
                </div>
                <div class="LabelDiv">
                    <asp:Button ID="EditUserButton" Text="Edit User Name" OnClick="EditUserButton_Click" CssClass="MainLabel" runat="server" />
                </div>
            </asp:Panel>
            <asp:Panel ID="PermEditPanel" class="LabelDiv" Visible="false" runat="server">
                <div class="LabelDiv">
                    <asp:Table runat="server" CssClass="TableForm">
                        <asp:TableRow>
                            <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" CssClass="ErrorStar" ErrorMessage="Enter new permissions." Text="*" ControlToValidate="PermissionsDropDown" InitialValue="-1" />
                            </asp:TableCell><asp:TableCell>
                            <asp:Label CssClass="TableFormLabel" Text="New Permissions:" runat="server" />
                            </asp:TableCell><asp:TableCell>
                                <asp:DropDownList ID="PermissionsDropDown" AppendDataBoundItems="true" runat="server" CssClass="inputbox">
                                    <asp:ListItem Value="-1" Selected="True">--</asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell></asp:TableRow></asp:Table></div><div class="LabelDiv">
                    <asp:ValidationSummary runat="server" CssClass="RequiredError" />
                </div>
                <div class="LabelDiv">
                    <asp:Button ID="PermEditButton" CssClass="MainLabel" Text="Change Permission" runat="server" OnClick="PermEditButton_Click" />
                </div>
            </asp:Panel>
            <asp:Panel ID="PassEditPanel" class="LabelDiv" Visible="false" runat="server">
                <div class="LabelDiv">
                    <asp:Table runat="server" CssClass="TableForm">
                        <asp:TableRow>
                            <asp:TableCell>
                            <asp:RequiredFieldValidator CssClass="ErrorStar" runat="server" ControlToValidate="EditPasswordText1" ErrorMessage="Enter new password." Text="*" />
                            </asp:TableCell><asp:TableCell>
                            <asp:Label runat="server" CssClass="TableFormLabel" Text="Enter password:" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="EditPasswordText1" CssClass="inputbox" TextMode="Password" runat="server" />
                            </asp:TableCell></asp:TableRow><asp:TableRow>
                            <asp:TableCell>
                            <asp:RequiredFieldValidator CssClass="ErrorStar" runat="server" ControlToValidate="EditPasswordText2" ErrorMessage="Enter new password." Text="*" />
                            </asp:TableCell><asp:TableCell>
                            <asp:Label runat="server" CssClass="TableFormLabel" Text="Verify password:" />
                            </asp:TableCell><asp:TableCell>
                                <asp:TextBox ID="EditPasswordText2" CssClass="inputbox" TextMode="Password" runat="server" />
                            </asp:TableCell></asp:TableRow></asp:Table></div><div class="LabelDiv">
                    <asp:ValidationSummary runat="server" CssClass="RequiredError" />
                </div>
                <div class="LabelDiv">
                    <asp:Label ID="IncorrectPassMatch" CssClass="RequiredError" runat="server" />
                </div>
                <div class="LabelDiv">
                    <asp:Button ID="EditPassButton" CssClass="MainLabel" Text="Change password" OnClick="EditPassButton_Click" runat="server" />
                </div>
            </asp:Panel>
            <asp:Panel ID="DeleteEditPanel" class="LabelDiv" Visible="false" runat="server">
                <div class="LabelDiv">
                    <asp:Label Text="Enter employee name to verify deletion:" runat="server" />
                </div>
                <div class="LabelDiv">
                <asp:Table CssClass="TableForm" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:TextBox ID="DeleteUserText" runat="server" />
                        </asp:TableCell><asp:TableCell>
                            <asp:Button ID="DeleteUserButton" OnClick="DeleteUserButton_Click" Text="Delete User" CssClass="inputbox" runat="server" />
                        </asp:TableCell></asp:TableRow></asp:Table>
                    </div>
                <div class="LabelDiv">
                    <asp:Label ID="RequiredName" CssClass="RequiredError" runat="server"></asp:Label></div></asp:Panel><div class="LabelDiv">
                <asp:Button ID="LoginEditBackButton" CssClass="MainLabel" Text="Back" runat="server" OnClick="LoginEditBackButton_Click" CausesValidation="false" />
                <asp:Button ID="LoginEditSignoutButton" CssClass="inputbox" Text="Sign out" runat="server" OnClick="LoginEditSignoutButton_Click" CausesValidation="false" />
            </div>
            <asp:SqlDataSource ID="AdminPermissionsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [PermissionsType]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SManagerPermissionsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [PermissionsType] WHERE ([PermTypeID] &gt; 2) "></asp:SqlDataSource>
            <asp:SqlDataSource ID="AssistManagerPermissionsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [PermissionsType] WHERE ([PermTypeID] &gt; 3) "></asp:SqlDataSource>

        </div>
    </form>
</body>
</html>
