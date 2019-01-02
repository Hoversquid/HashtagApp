<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPricingEdit.aspx.cs" Inherits="QuoteLogin.AdminPricingEdit" %>
<%@ PreviousPageType VirtualPath="~/DefaultScreen.aspx" %>
<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Pricing Categories</title>
    <link rel="stylesheet" href="QuoteStyle.css" />
</head>
<body class="">
    <form id="PricingEditForm" runat="server">
        <div class="MainForm">
            <cstate:QuoteControlState ID="qcs" runat="server" />
            <div class="LabelDiv" style="min-width: 450px; overflow:auto;">
                <div style="float:left; margin:auto;">
                    <asp:GridView ID="PricingGridView" CssClass="GridViewClass" runat="server" AutoGenerateColumns="False" CellPadding="10" DataKeyNames="PriceID" DataSourceID="PricingDataSource" ForeColor="#333333" GridLines="None" AllowSorting="True" >
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="Name" HeaderText="Device" SortExpression="Name" />
                            <asp:BoundField DataField="Labor" HeaderText="Labor" SortExpression="Labor" />
                            <asp:BoundField DataField="PriceID" HeaderText="PriceID" InsertVisible="False" ReadOnly="True" SortExpression="PriceID" Visible="False" />
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
                    <asp:DetailsView ID="PricingDetailsView" CssClass="GridViewClass" OnItemCreated="PricingDetailsView_ItemCreated" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="PriceID" DataSourceID="PricingDetails" ForeColor="#333333" GridLines="None" ViewStateMode="Enabled">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                        <EditRowStyle BackColor="#999999" />
                        <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                        <EmptyDataTemplate>
                            <asp:Button ID="InsertButton" CssClass="GridViewClass" Text="New Pricing" runat="server" CommandName="New" />
                        </EmptyDataTemplate>
                        <Fields>
                            <asp:BoundField DataField="PriceID" HeaderText="PriceID" InsertVisible="False" ReadOnly="True" SortExpression="PriceID" Visible="False" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Labor" HeaderText="Labor" SortExpression="Labor" />
                            <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True">
                                <ControlStyle CssClass="CommandFieldClass" />
                            </asp:CommandField>
                        </Fields>
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    </asp:DetailsView>
                </div>
                <div style="float:right; margin:auto;">
                    <asp:GridView ID="MarginGridView" CssClass="GridViewClass" runat="server" AutoGenerateColumns="False" CellPadding="10" DataKeyNames="MarginID" DataSourceID="MarginDataSource" ForeColor="#333333" GridLines="None" AllowSorting="True">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="MarginID" HeaderText="MarginID" SortExpression="MarginID" InsertVisible="False" ReadOnly="True" Visible="False" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Percent" HeaderText="Percent" SortExpression="Percent" />
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
                    <asp:DetailsView ID="MarginDetailsView" CssClass="GridViewClass" OnItemCreated="MarginDetailsView_ItemCreated" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="MarginID" DataSourceID="MarginDetails" ForeColor="#333333" GridLines="None" ViewStateMode="Enabled">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                        <EditRowStyle BackColor="#999999" />
                        <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                        <EmptyDataTemplate>
                            <asp:Button ID="InsertButton" Text="New Margin" CssClass="GridViewClass" runat="server" CommandName="New" />
                        </EmptyDataTemplate>
                        <Fields>
                            <asp:BoundField DataField="MarginID" HeaderText="MarginID" InsertVisible="False" ReadOnly="True" SortExpression="MarginID" Visible="False" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Percent" HeaderText="Percent" SortExpression="Percent" />
                            <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" >
                            <ControlStyle CssClass="CommandFieldClass" />
                                </asp:CommandField>
                        </Fields>
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    </asp:DetailsView>
                </div>
            </div>

            <asp:SqlDataSource ID="PricingDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT [Name], [Labor], [PriceID] FROM [Pricing]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="PricingDetails" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT [PriceID], [Name], [Labor] FROM [Pricing] WHERE ([PriceID] = @PriceID)" DeleteCommand="DELETE FROM [Pricing] WHERE [PriceID] = @PriceID" InsertCommand="INSERT INTO [Pricing] ([Name], [Labor]) VALUES (@Name, @Labor)" UpdateCommand="UPDATE [Pricing] SET [Name] = @Name, [Labor] = @Labor WHERE [PriceID] = @PriceID">
                <DeleteParameters>
                    <asp:Parameter Name="PriceID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Labor" Type="Double" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="PricingGridView" Name="PriceID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Labor" Type="Double" />
                    <asp:Parameter Name="PriceID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="MarginDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [Margin]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="MarginDetails" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" DeleteCommand="DELETE FROM [Margin] WHERE [MarginID] = @MarginID" InsertCommand="INSERT INTO [Margin] ([Percent], [Name]) VALUES (@Percent, @Name)" SelectCommand="SELECT * FROM [Margin] WHERE ([MarginID] = @MarginID)" UpdateCommand="UPDATE [Margin] SET [Percent] = @Percent, [Name] = @Name WHERE [MarginID] = @MarginID">
                <DeleteParameters>
                    <asp:Parameter Name="MarginID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Percent" Type="Decimal" />
                    <asp:Parameter Name="Name" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="MarginGridView" Name="MarginID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Percent" Type="Decimal" />
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="MarginID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <div class="LabelDiv" style="margin-top:20px; overflow:auto; clear:both;">
                <asp:Button ID="PricingEditBackButton" CssClass="MainLabel" Text="Back" runat="server" OnClick="PricingEditBackButton_Click" />
                <asp:Button ID="PricingEditSignoutButton" CssClass="inputbox" Text="Sign out" runat="server" OnClick="PricingEditSignoutButton_Click" />
            </div>
        </div>
    </form>
</body>
</html>
