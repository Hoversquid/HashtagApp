<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="QuoteLogin.LoginPage" %>

<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quote Login</title>
    <link rel="stylesheet" href="QuoteStyle.css" />
    <script>
</script>
</head>
<body>
    <form id="loginform" runat="server" method="post">
        <div class="MainForm">
            <div class="LogoDiv">
            <asp:Image ImageUrl="~/hashtagifixit_logo.png" ImageAlign="Middle" Width="50%" runat="server" />
        </div>
            <div class="LabelDiv">
                <asp:Label ID="UsernameLabel" runat="server" Text="User:" CssClass="MainLabel"></asp:Label>
                <asp:TextBox runat="server" ID="UsernameInput" type="text" class="inputbox" />
            </div>
            <div class="LabelDiv">
                <asp:Label ID="PasswordLabel" runat="server" Text="Password:" CssClass="MainLabel"></asp:Label>
                <asp:TextBox runat="server" ID="PasswordInput" type="password" class="inputbox" />
            </div>
            <div class="LabelDiv"><asp:Button ID="LoginButton" runat="server" Text="Login" OnClick="LoginButton_Click" /></div>
            <div class="LabelDiv"><asp:Label ID="IncorrectLabel" runat="server"></asp:Label></div>
        </div>
    </form>
</body>
</html>
