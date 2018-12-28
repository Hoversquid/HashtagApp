<%@ Page MasterPageFile="MasterPage.Master" Language="C#" AutoEventWireup="True" CodeBehind="BuybackForm.aspx.cs" Inherits="QuoteLogin.BuybackForm" Title="Buyback Form" %>

<%@ Register Assembly="QuoteLogin" Namespace="BuybackFormState.Controls" TagPrefix="cstate" %>
<asp:Content ID="BuybackForm" ContentPlaceHolderID="Main" runat="server">
    <cstate:BuybackFormState ID="bcs" runat='server' />
    <asp:Label ID="BuybackLabel" runat="server" Font-Size="XX-Large" Font-Bold="True" CssClass="LabelHeader">Buyback Form</asp:Label>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:Table runat="server" HorizontalAlign="Center">
                <asp:TableRow>
                    <asp:TableCell Width="160px">Select device template:</asp:TableCell>
                    <asp:TableCell>
                        <asp:DropDownList Width="180px" runat="server" DataSourceID="PresetDeviceDataSource" AppendDataBoundItems="true" AutoPostBack="true">
                            <asp:ListItem Selected="True">--</asp:ListItem>
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:SqlDataSource ID="PresetDeviceDataSource" runat="server" />
            <asp:Table runat="server" CssClass="BBFormTable">
                <asp:TableHeaderRow>
                    <asp:TableHeaderCell Font-Bold="true" Scope="Column" Text="Device Information:" ColumnSpan="2">Device Information:</asp:TableHeaderCell>
                </asp:TableHeaderRow>
                <asp:TableRow>
                    <asp:TableCell>
                        Make:<br />
                        <asp:TextBox ID="MakeText" runat="server" CssClass="BBFormText" />
                    </asp:TableCell><asp:TableCell>
                        Model:<br />
                        <asp:TextBox ID="ModelText" runat="server" CssClass="BBFormText" />
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell>
                        Carrier:<br />
                        <asp:TextBox ID="CarrierText" runat="server" CssClass="BBFormText" />
                    </asp:TableCell><asp:TableCell>
                        Serial # / IMEI:<br />
                        <asp:TextBox ID="SerialText" runat="server" CssClass="BBFormText" />
                    </asp:TableCell></asp:TableRow></asp:Table><asp:Table runat="server" CssClass="BBChecklist" GridLines="Both"><asp:TableRow>
                    <asp:TableCell>Does the device power on?</asp:TableCell><asp:TableCell HorizontalAlign="Left">
                            <asp:CheckBoxList RepeatDirection="Horizontal" runat="server">
                                <asp:ListItem Value="1" Text="">Yes</asp:ListItem>
                                <asp:ListItem Value="0" Text="">Yes</asp:ListItem>
                            </asp:CheckBoxList>
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell>Does the device have nics or scuffs?</asp:TableCell><asp:TableCell>
                        <asp:CheckBoxList RepeatDirection="Horizontal" runat="server">
                                <asp:ListItem Value="1" Text="">Yes</asp:ListItem>
                                <asp:ListItem Value="0" Text="">No</asp:ListItem>
                            </asp:CheckBoxList>
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell>Does the device have liquid damage?</asp:TableCell><asp:TableCell>
                        <asp:CheckBoxList RepeatDirection="Horizontal" runat="server">
                                <asp:ListItem Value="1" Text="">Yes</asp:ListItem>
                                <asp:ListItem Value="0" Text="">No</asp:ListItem>
                            </asp:CheckBoxList>
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell>Has "Find my iPhone" been turned off?</asp:TableCell><asp:TableCell>
                        <asp:CheckBoxList RepeatDirection="Horizontal" runat="server">
                                <asp:ListItem Value="1" Text="">Yes</asp:ListItem>
                                <asp:ListItem Value="0" Text="">No</asp:ListItem>
                            </asp:CheckBoxList>
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell>Has Gmail been deleted?</asp:TableCell><asp:TableCell>
                        <asp:CheckBoxList RepeatDirection="Horizontal" runat="server">
                                <asp:ListItem Value="1" Text="">Yes</asp:ListItem>
                                <asp:ListItem Value="0" Text="">No</asp:ListItem>
                            </asp:CheckBoxList>
                    </asp:TableCell></asp:TableRow></asp:Table></ContentTemplate></asp:UpdatePanel></asp:Content>