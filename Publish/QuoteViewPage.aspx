<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuoteViewPage.aspx.cs" Inherits="QuoteLogin.QuoteViewPage" EnableEventValidation="false" %>
<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Quote History View</title>
    <link rel="stylesheet" href="QuoteStyle.css" />
    <script type = "text/javascript">
        function PrintPanel() {
            var panel = document.getElementById("<%=QuoteGridView.ClientID %>");
            var printWindow = window.open('', '', 'height=250,width=400');
            printWindow.document.write('<html><head><title>DIV Contents</title>');
            printWindow.document.write('</head><body >');
            printWindow.document.write(panel.innerHTML);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.print();
        }
    </script>
</head>
<body>
    <form id="QuoteViewForm" runat="server">
        <div class="MainForm">
            <cstate:QuoteControlState ID="qcs" runat="server" />
            <div class="LabelDiv">
                <asp:GridView ID="QuoteGridView" OnRowDataBound="QuoteGridView_RowDataBound" CssClass="TableForm" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="QuoteViewDataSource" OnSelectedIndexChanged="QuoteGridView_SelectedIndexChanged" ForeColor="#333333" GridLines="None" DataKeyNames="QuoteID" AllowSorting="True">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="QuoteID" HeaderText="QuoteID" SortExpression="QuoteID" ReadOnly="True" Visible="False" />
                        <asp:BoundField DataField="F_Name" HeaderText="F_Name" SortExpression="F_Name" />
                        <asp:BoundField DataField="L_Name" HeaderText="L_Name" SortExpression="L_Name" />
                        <asp:BoundField DataField="EmpName" HeaderText="EmpName" SortExpression="EmpName" />
                        <asp:BoundField DataField="Make" HeaderText="Make" SortExpression="Make" />
                        <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" />
                        <asp:BoundField DataField="Pricing" HeaderText="Pricing" SortExpression="Pricing" />
                        <asp:BoundField DataField="Margin" HeaderText="Margin" SortExpression="Margin" />
                        <asp:BoundField DataField="Issue" HeaderText="Issue" SortExpression="Issue" Visible="False" />
                        <asp:BoundField DataField="Base_Price" HeaderText="Base_Price" SortExpression="Base_Price" />
                        <asp:BoundField DataField="Final_Price" HeaderText="Final_Price" SortExpression="Final_Price" />
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
                <asp:SqlDataSource ID="QuoteViewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [QuoteView]"></asp:SqlDataSource>

            </div>
            <asp:Panel ID="QuoteSelectedPanel" runat="server">
                <div class="LabelDiv">
                    <div class="LabelDiv">
                        <asp:DetailsView ID="IssueDetailView" CssClass="TableForm" runat="server" AutoGenerateRows="False" DataKeyNames="QuoteID" DataSourceID="QuoteDataSource">
                            <Fields>
                                <asp:BoundField DataField="QuoteID" HeaderText="QuoteID" InsertVisible="False" ReadOnly="True" SortExpression="QuoteID" Visible="False" />
                                <asp:BoundField DataField="Description" HeaderText="Issue" SortExpression="Description" />
                            </Fields>
                        </asp:DetailsView>
                    </div>
                </div>
                    <asp:SqlDataSource ID="QuoteDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT [QuoteID], [Description] FROM [Quote] Q, [Issue] I WHERE (Q.[IssueID] = I.[IssueID]) AND Q.[QuoteID] = @QuoteID" DeleteCommand="DELETE FROM [Quote] WHERE ([QuoteID] = @QuoteID)">
                        <DeleteParameters>
                            <asp:ControlParameter ControlID="QuoteGridView" Name="QuoteID" PropertyName="SelectedValue" Type="Int32" />
                        </DeleteParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="QuoteGridView" Name="QuoteID" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>

            </asp:Panel>
            <div class="LabelDiv">
                <asp:Table runat="server" CssClass="PageAction" ID="PageActionTable" CellPadding="20">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Button ID="PageSignOutButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Sign Out" OnClick="PageSignOutButton_Click" />
                        </asp:TableCell><asp:TableCell></asp:TableCell><asp:TableCell>
                            <asp:Button ID="PageBackButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Back" OnClick="PageBackButton_Click"/>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>
        </div>
    </form>
</body>
</html>
