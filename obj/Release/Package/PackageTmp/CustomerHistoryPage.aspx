<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerHistoryPage.aspx.cs" Inherits="QuoteLogin.CustomerHistoryPage" EnableEventValidation="false" %>

<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Quote History View</title>
    <link rel="stylesheet" href="QuoteStyle.css" />
    <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
    <script type="text/javascript">
        function PrintPanel() {
            var logo = document.getElementById('containerDIV');
            logo.style.display = 'inheirit';
            var panel = document.getElementById('QuoteDetailsViewPanel');
            panel.style.display = 'inheirit';
            var printWindow = window.open('', '', 'height=600,width=800');
            printWindow.document.write('<html><head><title>Quote Print Table</title>');
            printWindow.document.write('</head><body>');
            printWindow.document.write(logo.innerHTML);
            printWindow.document.write(panel.innerHTML);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.print();
            logo.style.display = 'none';
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
            if (clicked == false)//browser is closedf
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
    <form id="CustomerHistoryPageForm" class="MainForm" runat="server">
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
                            </asp:TableCell></asp:TableRow></asp:Table></div></div></div>
        <asp:Panel ID="SelectedCustomerPanel" runat="server" HorizontalAlign="Center">
            <asp:Label Text="Selected Customer: " runat="server" />
            <asp:Label ID="SelectedCustomerLabel" runat="server" Font-Bold="true" />
        </asp:Panel>
        <div class="LeftColumnGridDiv">
            <asp:Label runat="server" Text="Customer quote history: " />
            <asp:GridView ID="QuoteHistoryGridView" OnRowDataBound="QuoteHistoryGridView_RowDataBound" CssClass="AbsolutePos" OnSelectedIndexChanged="QuoteHistoryGridView_SelectedIndexChanged" runat="server" AutoGenerateColumns="False" DataKeyNames="QuoteID" DataSourceID="QuoteHistoryDataSource" CellPadding="4" ForeColor="#333333" GridLines="None" TabIndex="10" AllowPaging="True" PageSize="5" Width="296px" HorizontalAlign="Center">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="QuoteID" HeaderText="QuoteID" SortExpression="QuoteID" ReadOnly="True" Visible="False" />
                    <asp:BoundField DataField="CustID" HeaderText="CustID" SortExpression="CustID" Visible="False" />
                    <asp:BoundField DataField="Make" HeaderText="Make" SortExpression="Make" />
                    <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" />
                    <asp:BoundField DataField="QuoteTime" HeaderText="Date" SortExpression="QuoteTime" ReadOnly="True" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <EmptyDataTemplate>
                    <asp:Label runat="server" Text="No quotes found." />
                </EmptyDataTemplate>
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            <asp:SqlDataSource ID="QuoteHistoryDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT [QuoteID], [CustID], [Make], [QuoteTime], [Model] FROM [QuoteView] WHERE [CustID] = @CustID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="qcs" Name="CustID" Type="Int32" DefaultValue="" PropertyName="CustID" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <div class="RightColumnGridDiv">
            <asp:Label runat="server" Text="Customer Service Request History" />
            <asp:GridView ID="SRHistoryGridView" runat="server" DataKeyNames="Service_Request_ID" CellPadding="4" PageSize="5" ForeColor="#333333" GridLines="None" AllowPaging="True" AllowSorting="True" DataSourceID="ServiceRequestHistoryDataSource" AutoGenerateColumns="False" HorizontalAlign="Center" OnRowDataBound="SRHistoryGridView_RowDataBound" OnSelectedIndexChanged="SRHistoryGridView_SelectedIndexChanged" Width="260px">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="CustID" HeaderText="CustID" SortExpression="CustID" Visible="False" />
                    <asp:BoundField DataField="Make" HeaderText="Make" SortExpression="Make" />
                    <asp:TemplateField HeaderText="Device_Type" SortExpression="Device_Type">
                        <ItemTemplate>
                            <asp:Label ID="DeviceTypeLabel" runat="server" Text='<%# Bind("Device_Type") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Date_Formatted" HeaderText="Date" SortExpression="Date_Formatted" />
                    <asp:BoundField DataField="Service_Request_ID" HeaderText="Service_Request_ID" SortExpression="Service_Request_ID" Visible="False" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <EmptyDataTemplate>
                    <asp:Label runat="server" Text="No service requests found." />
                </EmptyDataTemplate>
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
        <asp:SqlDataSource runat="server" ID="ServiceRequestHistoryDataSource" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT [CustID], [Date_Formatted], [Make], [Service_Request_ID], [Device_Type] FROM [ServiceRequestView] WHERE [CustID] = @CustID">
            <SelectParameters>
                <asp:ControlParameter ControlID="qcs" Name="CustID" Type="Int32" DefaultValue="" PropertyName="CustID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Panel runat="server" ID="SelectSRPanel" Visible="false">
            <asp:Table runat="server" CssClass="PageAction" CellPadding="20" HorizontalAlign="Center">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button ID="SRSelectButton" CausesValidation="false" runat="server" Text="Select Service Request" OnClick="SRSelectButton_Click" />
                    </asp:TableCell></asp:TableRow></asp:Table></asp:Panel><asp:Panel runat="server" ID="QuoteDetailsViewPanel" Visible="false">
            <asp:DetailsView ID="PrintDetailsView" runat="server" AutoGenerateRows="False" DataKeyNames="QuoteID" DataSourceID="QuotePrintDataSource" CellPadding="5" Width="600px" Height="220px" ForeColor="#333333" GridLines="Horizontal" BorderWidth="2px" HorizontalAlign="Center">
                <AlternatingRowStyle BackColor="White" ForeColor="Black" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Width="20%" Font-Bold="True" HorizontalAlign="Left" CssClass="FieldHeaderClass" />
                <Fields>
                    <asp:BoundField DataField="QuoteID" HeaderText="QuoteID" ReadOnly="True" SortExpression="QuoteID" Visible="False" />
                    <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="Customer:" SortExpression="CustFName">
                        <ItemTemplate>
                            <asp:Label ID="FNameBinding" runat="server" Text='<%# Bind("CustFName") %>' />
                            <asp:Label ID="LNameBinding" runat="server" Text='<%# Bind("CustLName") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="Employee:" SortExpression="EmpFName">
                        <ItemTemplate>
                            <asp:Label ID="FNameBinding" runat="server" Text='<%# Bind("EmpFName") %>' />
                            <asp:Label ID="LNameBinding" runat="server" Text='<%# Bind("EmpLName") %>' />

                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Make" HeaderText="Make:" SortExpression="Make" />
                    <asp:BoundField DataField="Model" HeaderText="Model:" SortExpression="Model" />
                    <asp:BoundField DataField="Issue" HeaderText="Issue:" SortExpression="Issue" />
                    <asp:BoundField DataField="Final_Price" HeaderText="Price:" SortExpression="Final_Price" />
                    <asp:BoundField DataField="QuoteTime" HeaderText="Date:" ReadOnly="True" SortExpression="QuoteTime" />
                    <asp:BoundField DataField="Expiration" HeaderText="Quote Expires:" SortExpression="Expiration" DataFormatString="{0:d}"></asp:BoundField>
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="Black" />
            </asp:DetailsView>
            <asp:SqlDataSource ID="QuotePrintDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [QuoteView] WHERE ([QuoteID] = @QuoteID)" ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:ControlParameter ControlID="QuoteHistoryGridView" Name="QuoteID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:Panel>
        <asp:Panel ID="PrintQuotePanel" Visible="false" runat="server">
            <asp:Button ID="PrintQuoteButton" runat="server" Text="Print Quote" OnClientClick="return PrintPanel();" />
        </asp:Panel>
        <asp:Table runat="server" CssClass="PageAction" ID="PageActionTable" CellPadding="20" HorizontalAlign="Center">
            <asp:TableRow>
                <asp:TableCell>
                    <asp:Button ID="PageBackButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Back" OnClick="PageBackButton_Click" />
                </asp:TableCell><asp:TableCell>
                    <asp:Button ID="PageSignOutButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Sign Out" OnClick="PageSignOutButton_Click" />
                </asp:TableCell></asp:TableRow></asp:Table></form></body></html>