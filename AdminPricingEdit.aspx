<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPricingEdit.aspx.cs" Inherits="QuoteLogin.AdminPricingEdit" EnableEventValidation="false" %>

<%@ PreviousPageType VirtualPath="~/DefaultScreen.aspx" %>
<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Pricing Categories</title>
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
    <span style="font-size: 9pt;"></span>
    <form id="PricingEditForm" runat="server">
        <div class="MainForm">
            <cstate:QuoteControlState ID="qcs" runat="server" />
            <div class="LabelDiv" style="min-width: 450px; overflow: auto;">
                <div style="float: left; margin: auto;">
                    <asp:GridView ID="PricingGridView" CssClass="DetailsViewClass" runat="server" AutoGenerateColumns="False" CellPadding="10" DataKeyNames="PriceID" DataSourceID="PricingDataSource" ForeColor="#333333" GridLines="None" OnRowDataBound="PricingGridView_RowDataBound" AllowSorting="True" AllowPaging="True" PageSize="5" Width="225px">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
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
                    <asp:DetailsView ID="PricingDetailsView" CssClass="DetailsViewClass" OnItemCreated="PricingDetailsView_ItemCreated" OnItemInserted="PricingDetailsView_ItemInserted" OnItemUpdated="PricingDetailsView_ItemUpdated" OnItemDeleted="PricingDetailsView_ItemDeleted" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="PriceID" DataSourceID="PricingDetails" ForeColor="#333333" GridLines="None" ViewStateMode="Enabled" BorderColor="Silver" Width="225px">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                        <EditRowStyle BackColor="#999999" />
                        <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                        <EmptyDataTemplate>
                            <asp:Button ID="InsertButton" BorderStyle="None" BorderWidth="0px" CssClass="GridViewClass" Text="New Pricing" runat="server" CommandName="New" />
                        </EmptyDataTemplate>
                        <Fields>
                            <asp:BoundField DataField="PriceID" HeaderText="PriceID" InsertVisible="False" ReadOnly="True" SortExpression="PriceID" Visible="False" />
                            <asp:TemplateField HeaderText="Name" SortExpression="Name">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Labor" SortExpression="Labor">
                                <EditItemTemplate>
                                    <asp:TextBox ID="EditLabor" runat="server" Text='<%# Bind("Labor") %>'></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="PriceValidator" runat="server" ControlToValidate="EditLabor" ValidationExpression="^\d+(\.\d\d)?$" CssClass="PricingError" Text="" ErrorMessage="Enter valid labor price." />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="InsertLabor" runat="server" Text='<%# Bind("Labor") %>'></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="PriceValidator" runat="server" ControlToValidate="InsertLabor" ValidationExpression="^\d+(\.\d\d)?$" CssClass="PricingError" Text="" ErrorMessage="Enter valid labor price." />

                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Labor") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ButtonType="Button" ShowEditButton="True" ShowInsertButton="True" ShowDeleteButton="True">
                                <ControlStyle CssClass="CommandFieldClass" />
                            </asp:CommandField>
                        </Fields>
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    </asp:DetailsView>
                </div>
                <div style="float: right; margin: auto;">
                    <asp:GridView ID="MarginGridView" CssClass="DetailsViewClass" runat="server" AutoGenerateColumns="False" CellPadding="10" DataKeyNames="MarginID" DataSourceID="MarginDataSource" ForeColor="#333333" GridLines="None" AllowSorting="True" OnRowDataBound="MarginGridView_RowDataBound" AllowPaging="True" PageSize="5" Width="225px">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
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
                    <asp:DetailsView ID="MarginDetailsView" CssClass="DetailsViewClass" OnItemCreated="MarginDetailsView_ItemCreated" OnItemInserted="MarginDetailsView_ItemInserted" OnItemDeleted="MarginDetailsView_ItemDeleted" OnItemUpdated="MarginDetailsView_ItemUpdated" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="MarginID" DataSourceID="MarginDetails" ForeColor="#333333" GridLines="None" ViewStateMode="Enabled" BorderColor="#CCCCCC" Width="225px">
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
                            <asp:TemplateField HeaderText="Percent" SortExpression="Percent">
                                <EditItemTemplate>
                                    <asp:TextBox ID="EditPercent" runat="server" Text='<%# Bind("Percent") %>'></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="PriceValidator" runat="server" ControlToValidate="EditPercent" ValidationExpression="^\d+(\.\d\d)?$" CssClass="PricingError" Text="" ErrorMessage="Enter valid percent." />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="InsertPercent" runat="server" Text='<%# Bind("Percent") %>'></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="PriceValidator" runat="server" ControlToValidate="InsertPercent" ValidationExpression="^\d+(\.\d\d)?$" CssClass="PricingError" Text="" ErrorMessage="Enter valid labor price." />

                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Percent") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ButtonType="Button" ShowEditButton="True" ShowInsertButton="True" ShowDeleteButton="True">
                                <ControlStyle CssClass="CommandFieldClass" />
                            </asp:CommandField>
                        </Fields>
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    </asp:DetailsView>
                </div>
                <div class="LabelDiv">
                    <asp:Label ID="ChangeConfirmation" CssClass="ConfirmationLabel" runat="server" />
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
            <div class="LabelDiv">
                <asp:Table runat="server" CssClass="PageAction" ID="PageActionTable" CellPadding="20" HorizontalAlign="Center">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Button ID="PageSignOutButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Sign Out" OnClick="PageSignOutButton_Click" />
                        </asp:TableCell><asp:TableCell>
                            <asp:Button ID="PageBackButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Back" OnClick="PageBackButton_Click" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>
        </div>
    </form>
</body>
</html>
