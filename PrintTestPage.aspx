<%@ Page MasterPageFile="~/MasterPage.Master" Title="Print Page" Language="C#" AutoEventWireup="true" CodeBehind="PrintTestPage.aspx.cs" Inherits="QuoteLogin.PrintTestPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="server">
        <div class="PrintDiv">
            Hello, worl.
        </div>
        <div class="PrintDiv">
            I am here.... now
        </div>
    <asp:Button Text="Print" runat="server" OnClientClick="return PrintPanel();" />
</asp:Content>
