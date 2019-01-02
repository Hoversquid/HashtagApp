<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuoteViewPage.aspx.cs" Inherits="QuoteLogin.QuoteViewPage" EnableEventValidation="false" %>

<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Quote History View</title>
    <link rel="stylesheet" href="QuoteStyle.css" />
    <script type="text/javascript">
        function PrintPanel() {
            var logo = document.getElementById('containerDIV');
            logo.style.display = 'inheirit';
            var panel = document.getElementById('PrintPanelDivContainer');
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
            panel.style.display = 'none';
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
    <script type="text/javascript" src="Scripts/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="Scripts/ScrollableGridView.js"></script>
</head>
<body onunload="bodyUnload();" onclick="clicked=true;">
    <form id="QuoteViewForm" runat="server">
        <div class="MainForm">
            <cstate:QuoteControlState ID="qcs" runat="server" />
            <asp:Label runat="server">View History Type: </asp:Label>
            <asp:DropDownList runat="server" ID="ViewTypeDropdown" OnSelectedIndexChanged="ViewTypeDropdown_SelectedIndexChanged" AutoPostBack="true">
                <asp:ListItem Selected="true">--</asp:ListItem>
                <asp:ListItem>Service Request</asp:ListItem>
                <asp:ListItem>Quote</asp:ListItem>
            </asp:DropDownList>
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
                                </asp:TableCell></asp:TableRow></asp:Table></div></div></div><asp:Panel ID="QuoteViewPanel" runat="server" Visible="false">
                <div class="GridDiv">
                    <asp:GridView ID="QuoteGridView" OnRowDataBound="QuoteGridView_RowDataBound" CssClass="GridWidth" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="QuoteViewDataSource" OnSelectedIndexChanged="QuoteGridView_SelectedIndexChanged" ForeColor="#333333" GridLines="None" DataKeyNames="QuoteID" AllowSorting="True" HorizontalAlign="Center" AllowPaging="True" PageSize="8">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="QuoteID" HeaderText="QuoteID" ReadOnly="True" SortExpression="QuoteID" Visible="False" />
                        <asp:TemplateField HeaderText="Customer" SortExpression="CustFName">
                            <ItemTemplate>
                                <asp:Label ID="CustFNameBinding" runat="server" Text='<%# Bind("CustFName") %>' />
                                <asp:Label ID="CustLNameBinding" runat="server" Text='<%# Bind("CustLName") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Make" HeaderText="Make" SortExpression="Make" />
                        <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" />
                        <asp:BoundField DataField="Issue" HeaderText="Issue" SortExpression="Issue" Visible="false" />
                        <asp:BoundField DataField="Base_Price" HeaderText="Base_Price" SortExpression="Base_Price" />
                        <asp:BoundField DataField="Final_Price" HeaderText="Final_Price" SortExpression="Final_Price" />
                        <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="Employee" SortExpression="EmpFName">
                            <ItemTemplate>
                                <asp:Label ID="FNameBinding" runat="server" Text='<%# Bind("EmpFName") %>' />
                                <asp:Label ID="LNameBinding" runat="server" Text='<%# Bind("EmpLName") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="QuoteTime" HeaderText="QuoteTime" SortExpression="QuoteTime" ReadOnly="True" />
                        <asp:TemplateField HeaderText="Pricing" SortExpression="Pricing_Name">
                            <ItemTemplate>
                                <asp:Label ID="PricingNameBinding" runat="server" Text='<%# Bind("Pricing_Name") %>' />
                                <asp:Label runat="server" Text=":" />
                                <asp:Label ID="PricingAmountBinding" runat="server" Text='<%# Bind("Pricing_Amount") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Labor" SortExpression="Margin_Name">
                            <ItemTemplate>
                                <asp:Label ID="MarginNameBinding" runat="server" Text='<%# Bind("Margin_Name") %>' />
                                <asp:Label runat="server" Text=":" />
                                <asp:Label ID="MarginPercentBinding" runat="server" Text='<%# Bind("Margin_Percent") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
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
                    <asp:SqlDataSource ID="QuoteViewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [QuoteView]" ProviderName="System.Data.SqlClient" />
                </div>
            </asp:Panel> 
            <asp:Panel ID="ServiceReqViewPanel" runat="server" Visible="false">
                <div class="GridDiv">
                    <asp:GridView ID="ServiceReqGridView" runat="server" Width="500px" OnRowDataBound="ServiceReqGridView_RowDataBound" CssClass="GridWidth" OnSelectedIndexChanged="ServiceReqGridView_SelectedIndexChanged" DataKeyNames="Service_Request_ID" AutoGenerateColumns="False" CellPadding="4" PageSize="8" DataSourceID="ServiceReqDataSource" ForeColor="#333333" GridLines="None" HorizontalAlign="Center" AllowPaging="True" AllowSorting="True"><AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:TemplateField HeaderText="Device_Type" SortExpression="Device_Type">
                                <ItemTemplate><asp:Label ID="deviceTypeLabel" runat="server" Text='<%# Bind("Device_Type") %>'></asp:Label></ItemTemplate></asp:TemplateField><asp:BoundField DataField="Make" HeaderText="Make" SortExpression="Make" />
                            <asp:BoundField DataField="Date_Formatted" HeaderText="Request_Date" SortExpression="Date_Formatted" />

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
                    <asp:SqlDataSource ID="ServiceReqDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" 
                        SelectCommand="SELECT [Name], [Device_Type], [Quote_ID], [Service_Request_ID], [Make], [Date_Formatted], [StoreID] FROM [ServiceRequestView]" /></div>
            </asp:Panel>
            <asp:Panel ID="QuoteSelectedPanel" runat="server">
                <div class="LabelDiv">
                    <asp:DetailsView ID="IssueDetailView" CssClass="TableForm" runat="server" AutoGenerateRows="False" DataKeyNames="QuoteID" DataSourceID="QuoteDataSource">
                        <Fields>
                            <asp:BoundField DataField="QuoteID" HeaderText="QuoteID" InsertVisible="False" ReadOnly="True" SortExpression="QuoteID" Visible="False" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                        </Fields>
                        <FieldHeaderStyle Width="15%" />
                    </asp:DetailsView>
                </div>
                <div class="LabelDiv">
                    <asp:Table runat="server" CssClass="PageAction" CellPadding="20" HorizontalAlign="Center">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Button ID="PrintButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Print Quote" OnClientClick="return PrintPanel();" />
                            </asp:TableCell><asp:TableCell><asp:Button ID="ServiceRequestButton" runat="server" Text="Create Service Request" OnClick="ServiceRequestButton_Click" />
                                </asp:TableCell><asp:TableCell>
                                <asp:Button ID="DeleteButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Delete Quote" Visible="false" OnClick="DeleteButton_Click" OnClientClick="if(!confirm('Do you want to delete this Quote?')){ return false; };" />
                            </asp:TableCell></asp:TableRow></asp:Table></div><asp:SqlDataSource ID="QuoteDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT [QuoteID], [Description] FROM [Quote] Q, [Issue] I WHERE (Q.[IssueID] = I.[IssueID]) AND Q.[QuoteID] = @QuoteID" DeleteCommand="DELETE FROM [Quote] WHERE ([QuoteID] = @QuoteID)" ProviderName="System.Data.SqlClient">
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="QuoteGridView" Name="QuoteID" PropertyName="SelectedValue" Type="Int32" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="QuoteGridView" Name="QuoteID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="QuotePrintDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [QuoteView] WHERE ([QuoteID] = @QuoteID)" ProviderName="System.Data.SqlClient">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="QuoteGridView" Name="QuoteID" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

            </asp:Panel>
            
            <asp:Panel ID="SRSelectedPanel" runat="server" Visible="false">
                <div class="LabelDiv">
                    <asp:Table runat="server" CssClass="PageAction" CellPadding="20" HorizontalAlign="Center">
                        <asp:TableRow>
                            <asp:TableCell><asp:Button ID="ViewSRButton" runat="server" Text="View Service Request" OnClick="ViewSRButton_Click" />
                                </asp:TableCell></asp:TableRow></asp:Table></div></asp:Panel><div id="PrintPanelDivContainer" style="display: none;">
                <div id="PrintPanelDiv" style="clear: left;">
                    <asp:Panel ID="PrintPanel" runat="server" ForeColor="Black">
                        <asp:DetailsView ID="PrintDetailsView" runat="server" AutoGenerateRows="False" DataKeyNames="QuoteID" DataSourceID="QuotePrintDataSource" CellPadding="5" Width="600px" Height="220px" ForeColor="#333333" GridLines="Horizontal" BorderWidth="2px">
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
                    </asp:Panel>
                </div>
            </div>
            <div class="LabelDiv">
                <asp:Table runat="server" CssClass="PageAction" ID="PageActionTable" CellPadding="20" HorizontalAlign="Center">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Button ID="PageSignOutButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Sign Out" OnClick="PageSignOutButton_Click" />
                        </asp:TableCell><asp:TableCell>
                            <asp:Button ID="PageBackButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Back" OnClick="PageBackButton_Click" />
                        </asp:TableCell></asp:TableRow></asp:Table></div></div></form></body></html>