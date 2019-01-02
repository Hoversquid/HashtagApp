<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuoteConfirmationPage.aspx.cs" Inherits="QuoteLogin.QuoteConfirmationPage" %>

<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Quote Confirmation</title>
    <link rel="stylesheet" href="QuoteStyle.css" />
    <script type="text/javascript">
        function PrintPanel() {
            var logo = document.getElementById('containerDIV');
            logo.style.display = 'inheirit';
            var panel = document.getElementById('PanelContainerDiv');
            var printWindow = window.open('', '', 'height=600,width=800');
            printWindow.document.write('<html><head><title>Quote Summary</title>');
            printWindow.document.write('</head><body >');
            printWindow.document.write(logo.innerHTML);
            printWindow.document.write(panel.innerHTML);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.print();
        }

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
    <form id="MainForm" class="MainForm" runat="server">
        <cstate:QuoteControlState ID="qcs" runat="server" />
        <div id="containerDIV" style="display: none;">
            <div id="Logo" style="height: 120px; float: left; width: 299px;">
                <asp:Image ImageUrl="~/hashtagifixit_logo.png" Height="55px" ImageAlign="Left" runat="server" />
                <div style="clear: left; margin-left: 5px; margin-bottom: 10px;">
                    <asp:Table CssClass="ContactTable" runat="server" Width="294px" Height="50px" Font-Size="Small">
                        <asp:TableRow>
                            <asp:TableCell Height="25px">
                            <asp:Label Text="100 Quin Lane, Suite D" runat="server" />
                            </asp:TableCell><asp:TableCell Width="100px" Text="(931) 494-7587" runat="server" />
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell Height="25px">
                            <asp:Label Text="2243 Lowes Drive, Suite D" runat="server" />
                            </asp:TableCell><asp:TableCell>
                            <asp:Label Text="(931) 802-7137" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
            </div>
        </div>
        <div id="PanelContainerDiv">
            <div id="ClearDiv" style="clear: both;">
                <div class="LabelDiv">
                    <asp:Table ID="ConfirmationTable" CssClass="TableForm" Width="600px" CellPadding="4" CellSpacing="4" GridLines="Horizontal" runat="server">
                        <asp:TableRow ID="CustomerTableRow">
                            <asp:TableCell BackColor="#E9ECF1" Font-Bold="True" Width="20%">
                                <asp:Label ID="CustomerLabel" runat="server" Text="Customer:" />
                            </asp:TableCell><asp:TableCell BackColor="#F7F6F3">
                                <asp:Label ID="CustomerText" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell Font-Bold="True" BackColor="#E9ECF1">
                                <asp:Label ID="EmployeeLabel" runat="server" Text="Employee:" />
                            </asp:TableCell><asp:TableCell>
                                <asp:Label ID="EmployeeText" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell Font-Bold="True" BackColor="#E9ECF1">
                                <asp:Label ID="MakeNameLabel" runat="server" Text="Make:" />
                            </asp:TableCell><asp:TableCell BackColor="#F7F6F3">
                                <asp:Label ID="MakeNameText" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell Font-Bold="True" BackColor="#E9ECF1">
                                <asp:Label ID="ModelNameLabel" runat="server" Text="Model:" />
                            </asp:TableCell><asp:TableCell>
                                <asp:Label ID="ModelNameText" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell Font-Bold="True" BackColor="#E9ECF1">
                                <asp:Label ID="IssueDescLabel" runat="server" Text="Issue:" />
                            </asp:TableCell><asp:TableCell BackColor="#F7F6F3">
                                <asp:Label ID="IssueDescText" CssClass="WordWrapClass" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell Font-Bold="True" BackColor="#E9ECF1">
                                <asp:Label ID="PriceLabel" runat="server" Text="Price:" />
                            </asp:TableCell><asp:TableCell>
                                <asp:Label ID="PriceText" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell Font-Bold="True" BackColor="#E9ECF1"><asp:Label runat="server" Text="Date:" /></asp:TableCell><asp:TableCell BackColor="#F7F6F3">
                                <asp:Label runat="server" ID="DateText" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell BackColor="#E9ECF1" Font-Bold="true">
                            <asp:Label runat="server" Text="Quote Expires:" />
                            </asp:TableCell><asp:TableCell>
                                <asp:Label ID="ExpiresText" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
            </div>
        </div>
        <asp:SqlDataSource ID="ControlStateDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>">
        </asp:SqlDataSource>
        <asp:Panel runat="server" ID="SubmissionPanel">
        <div class="LabelDiv">
            <asp:Table runat="server" CssClass="PageAction" CellPadding="5" HorizontalAlign="Center">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button ID="BackButton" CausesValidation="false" CssClass="TableFormButton" Text="Back" runat="server" OnClick="BackButton_Click" />
                    </asp:TableCell><asp:TableCell>

                    </asp:TableCell><asp:TableCell>
                        <asp:Button ID="ConfirmButton" CausesValidation="false" CssClass="TableFormButton" Text="Confirm" OnClick="ConfirmButton_Click" runat="server"></asp:Button>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
        </asp:Panel>
        <asp:Panel ID="ConfirmationActionPanel" Visible="false" runat="server">
        <div class="LabelDiv">
            <asp:Table runat="server" CssClass="PageAction" CellPadding="5" HorizontalAlign="Center">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button ID="PrintButton" CausesValidation="false" CssClass="TableFormButton" Text="Print" runat="server" OnClientClick="return PrintPanel();" />
                    </asp:TableCell><asp:TableCell>
                        <asp:Button ID="ServiceRequestButton" CausesValidation="false" CssClass="TableFormButton" Text="Service Request" OnClick="ServiceRequestButton_Click" runat="server" Visible="false" />
                    </asp:TableCell><asp:TableCell>
                        <asp:Button ID="FinishButton" CausesValidation="false" CssClass="TableFormButton" Text="Finish Quote" OnClick="FinishButton_Click" runat="server" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>

        </asp:Panel>
    </form>
</body>
</html>
