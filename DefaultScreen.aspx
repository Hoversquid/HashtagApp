<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DefaultScreen.aspx.cs" Inherits="QuoteLogin.DefaultScreen" %>

<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hashtag iFixit Selection</title>
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
    <form id="DefaultSelection" class="MainForm" runat="server">
        <cstate:QuoteControlState ID="qcs" runat="server" />
        <div class="LogoDiv">
            <asp:Image ImageUrl="~/hashtagifixit_logo.png" Width="50%" runat="server" />
        </div>
        <div style="width: 50%; margin: auto;">
            <asp:Button ID="QuickQuoteButton" CssClass="DefaultFormButton" Text="Quick Quote" OnClick="QuickQuoteButton_Click" runat="server" />
            <asp:Button ID="NewQuotePageButton" CssClass="DefaultFormButton" Text="New Quote / Customer Page" OnClick="NewQuotePageButton_Click" runat="server" />
            <asp:Button ID="EditLoginPageButton" CssClass="DefaultFormButton" Text="Edit Login Page" OnClick="EditLoginButton_Click" runat="server" />
            <asp:Button ID="EditPricingPageButton" CssClass="DefaultFormButton" Text="Edit Pricing Page" OnClick="EditPricingButton_Click" runat="server" />
            <asp:Button ID="QuoteViewPageButton" CssClass="DefaultFormButton" Text="Quote History" runat="server" OnClick="QuoteViewPageButton_Click" />
            <asp:Button ID="ServiceRequestFormButton" CssClass="DefaultFormButton" Text="Service Request Form Page" runat="server" OnClick="ServiceRequestFormButton_Click" />
            <asp:Button ID="ProceduresButton" CssClass="DefaultFormButton" Text="Opening / Closing Procedures" runat="server" OnClick="ProceduresButton_Click" />
            <asp:Button ID="SignOutButton" CssClass="DefaultFormButton" Text="Sign Out" runat="server" OnClick="SignOutButton_Click" />
        </div>
    </form>

</body>
</html>
