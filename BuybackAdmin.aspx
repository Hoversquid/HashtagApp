<%@ Page MasterPageFile="MasterPage.Master" Language="C#" AutoEventWireup="true" CodeBehind="BuybackAdmin.aspx.cs" Inherits="QuoteLogin.BuybackAdmin" %>


<asp:Content ID="BuybackAdmin" ContentPlaceHolderID="Main" runat="server">
    <asp:ScriptManager ID="ScriptManager" runat="server" />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:Panel ID="PresetDevicePanel" runat="server">
            <asp:Table runat="server" CssClass="BBFormTable">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label runat="server">Preset Device:</asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:DropDownList runat="server" DataSourceID="PremadeDeviceDataSource" AppendDataBoundItems="true">
                            <asp:ListItem Value="0">--</asp:ListItem>
                            <asp:ListItem Value="1">New Device</asp:ListItem>
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:Table runat="server" CssClass="BBFormTable">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label runat="server">Name:</asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Label runat="server">Base Price:</asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Label runat="server">Device Type:</asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:TextBox ID="AdminNameText" runat="server" />
                    </asp:TableCell><asp:TableCell>
                        <asp:TextBox ID="AdminBasePriceText" runat="server" />
                    </asp:TableCell><asp:TableCell>
                        <asp:DropDownList ID="AdminDeviceTypeDropdown" runat="server" AppendDataBoundItems="true">
                            <asp:ListItem Value="0">--</asp:ListItem>
                        </asp:DropDownList>
                    </asp:TableCell></asp:TableRow></asp:Table><asp:Table CssClass="BBFormTable" runat="server" CellPadding="10">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button ID="Submit" BackColor="Green" ForeColor="White" Font-Bold="true" runat="server" Text="Submit" /> 
                    </asp:TableCell></asp:TableRow></asp:Table></asp:Panel><asp:SqlDataSource ID="PremadeDeviceDataSource" runat="server" />
            <asp:Panel ID="ChecklistEditPanel" runat="server">
                <asp:Table runat="server" CssClass="BBFormText" HorizontalAlign="Center">

                </asp:Table>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
