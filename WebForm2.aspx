<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="QuoteLogin.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <div class="LabelDiv">
        <asp:Button CssClass="MainLabel" ID="QuoteButton" Text="Quote Page" OnClick="QuoteButton_Click" runat="server" />
        <asp:Button CssClass="inputbox" ID="EditLoginButton" Text="Edit Login Page" OnClick="EditLoginButton_Click" runat="server" />
    </div>
    <div class="LabelDiv">
        <asp:Button CssClass="MainLabel" ID="EditPricingButton" Text="Edit Pricing Page" OnClick="EditPricingButton_Click" runat="server" />
        <asp:Button ID="SignOutButton" CssClass="inputbox" Text="Sign Out" runat="server" OnClick="SignOutButton_Click" />
    </div>
</asp:Content>
