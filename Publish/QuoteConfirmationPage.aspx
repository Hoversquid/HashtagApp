<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuoteConfirmationPage.aspx.cs" Inherits="QuoteLogin.QuoteConfirmationPage" %>

<%@ PreviousPageType VirtualPath="~/QuotePageAdmin.aspx" %>
<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Quote Confirmation</title>
    <script type = "text/javascript">
        function PrintPanel() {
            var panel = document.getElementById("<%=QuotePanel.ClientID %>");
            var printWindow = window.open('', '', 'height=250,width=400');
            printWindow.document.write('<html><head><title>DIV Contents</title>');
            printWindow.document.write('</head><body >');
            printWindow.document.write(panel.innerHTML);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.print();
        }
    </script>
    <link rel="stylesheet" href="QuoteStyle.css" />
    
</head>
<body>
    <form id="MainForm" class="MainForm" runat="server">
        <div class="LabelDiv">
            <cstate:QuoteControlState ID="qcs" runat="server" />
            <asp:Panel runat="server" ID="QuotePanel">
                <asp:Table ID="ConfirmationTable" CellPadding="4" CellSpacing="4" CssClass="TableForm" GridLines="Horizontal" runat="server">
                    <asp:TableRow>
                        <asp:TableCell Font-Bold="True">
                            <asp:Label ID="FNameLabel" runat="server" Text="F_Name:" />
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="FNameText" runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Font-Bold="True">
                            <asp:Label ID="LNameLabel" runat="server" Text="L_Name:" />
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="LNameText" runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Font-Bold="True">
                            <asp:Label ID="EmpNameLabel" Text="Employee:" runat="server" />
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="EmpNameText" runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Font-Bold="True">
                            <asp:Label ID="MakeNameLabel" runat="server" Text="Make:" />
                        </asp:TableCell><asp:TableCell Font-Bold="True">
                            <asp:Label ID="MakeNameText" runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Font-Bold="True">
                            <asp:Label ID="ModelNameLabel" runat="server" Text="Model:" />
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="ModelNameText" runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Font-Bold="True">
                            <asp:Label ID="IssueDescLabel" runat="server" Text="Issue:" />
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="IssueDescText" runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Font-Bold="True">
                            <asp:Label ID="PriceLabel" runat="server" Text="Price:" />
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="PriceText" runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Font-Bold="True"><asp:Label runat="server" Text="Date:" /></asp:TableCell>
                        <asp:TableCell>
                            <asp:Label runat="server" ID="DateText" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Center">
                        <div class="ExpiryDate">
                            <asp:Label runat="server" ID="ExpiryDateLabel" Text="Quote expires in two (2) days." />
                        </div>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
            <asp:SqlDataSource ID="ControlStateDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>"
                SelectCommand="SELECT C.[F_Name], C.[L_Name], E.[Name] FROM [Customer] C, [Employee] E WHERE E.[EmpID] = @EmpID AND C.[CustID] = @CustID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="qcs" Name="EmpID" PropertyName="EmpID" />
                    <asp:ControlParameter ControlID="qcs" Name="CustID" PropertyName="CustID" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <div class="LabelDiv">
            <asp:Table runat="server" CssClass="TableForm" CellPadding="5">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button ID="BackButton" CausesValidation="false" CssClass="PageAction" Text="Back" runat="server" OnClick="BackButton_Click" />
                    </asp:TableCell><asp:TableCell>

                    </asp:TableCell><asp:TableCell>
                        <asp:Button ID="ConfirmButton" CausesValidation="false" CssClass="PageAction" Text="Confirm" OnClientClick="return PrintPanel();" OnClick="ConfirmButton_Click" runat="server"></asp:Button>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
    </form>
</body>
</html>
