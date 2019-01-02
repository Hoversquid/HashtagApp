<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DefaultScreen.aspx.cs" Inherits="QuoteLogin.DefaultScreen" %>
<%@ PreviousPageType VirtualPath="~/LoginPage.aspx" %> 
<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hashtag iFixit Selection</title>
    <link rel="stylesheet" href="QuoteStyle.css" />
</head>
<body>
    <form id="DefaultSelection" class="MainForm" runat="server">
        <cstate:QuoteControlState ID="qcs" runat="server" />
        <div class="LogoDiv">
            <asp:Image ImageUrl="~/hashtagifixit_logo.png" Width="50%" runat="server" />
        </div>
        <div style="width:50%; margin:auto;">
            <asp:Button ID="NewQuotePageButton" CssClass="DefaultFormButton" Text="New Quote" OnClick="NewQuotePageButton_Click" runat="server" />
            <asp:Button ID="EditLoginPageButton" CssClass="DefaultFormButton" Text="Edit Login Page" OnClick="EditLoginButton_Click" runat="server" />
            <asp:Button ID="EditPricingPageButton" CssClass="DefaultFormButton" Text="Edit Pricing Page" OnClick="EditPricingButton_Click" runat="server" />
            <asp:Button ID="QuoteViewPageButton" CssClass="DefaultFormButton" Text="Quote History" runat="server" OnClick="QuoteViewPageButton_Click" />
            <asp:Button ID="SignOutButton" CssClass="DefaultFormButton" Text="Sign Out" runat="server" OnClick="SignOutButton_Click" />
            </div>
    </form>
    
</body>
</html>
