<%@ Page MasterPageFile="MasterPage.Master" Language="C#" AutoEventWireup="true" CodeBehind="ActivitiesTracker.aspx.cs" Inherits="QuoteLogin.ActivitiesTracker" Title="Opening and Closing Procedures" %>

<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>

<asp:Content ID="MainProcedureChecklist" ContentPlaceHolderID="Main" runat="server">
    <asp:GridView ID="ActivitiesGridView" CellPadding="5"  HorizontalAlign="Center" DataSourceID="ActivitiesDataSource" runat="server" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="StoreID" HeaderText="StoreID" SortExpression="StoreID" />
            <asp:BoundField DataField="Accessories" HeaderText="Accessories" SortExpression="Accessories" />
            <asp:BoundField DataField="Repairs" HeaderText="Repairs" SortExpression="Repairs" />
            <asp:BoundField DataField="Preowned" HeaderText="Preowned" SortExpression="Preowned" />
            <asp:BoundField DataField="TnD" HeaderText="TnD" SortExpression="TnD" />
            <asp:BoundField DataField="Sales" HeaderText="Sales" SortExpression="Sales" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="ActivitiesDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [Store_Quota]" />
</asp:Content>
