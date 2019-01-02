<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="QuoteLogin.LoginPage" %>

<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quote Login</title>
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
    <form id="loginform" runat="server" method="post">
        <div class="MainForm">
            <div class="LogoDiv">
                <asp:Image ImageUrl="~/hashtagifixit_logo.png" ImageAlign="Middle" Width="50%" runat="server" />
            </div>
            <div class="LabelDiv">
                <asp:Table CssClass="TableForm" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="UsernameLabel" runat="server" Text="User:" CssClass="TableFormLabel" />
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox runat="server" ID="UsernameInput" type="text" class="TableFormInput" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="PasswordLabel" runat="server" Text="Password:" CssClass="TableFormLabel" />
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox runat="server" ID="PasswordInput" type="password" class="TableFormInput" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>
            <div class="LabelDiv">
                <asp:Button ID="LoginButton" runat="server" Text="Login" OnClick="LoginButton_Click" />
            </div>
            <div class="LabelDiv">
                <asp:Label ID="IncorrectLabel" runat="server"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
