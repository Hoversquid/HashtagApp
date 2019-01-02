<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/QuotePageAdmin.aspx.cs" Inherits="QuoteLogin.QuotePageAdmin" %>

<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quote Renderer</title>
    <link rel="stylesheet" href="QuoteStyle.css" />
</head>
<body>
    <form id="quoteform" runat="server" method="post">
        <div class="MainForm">
            <cstate:QuoteControlState ID="qcs" runat="server" />
            <div class="LabelDiv">
                <asp:Table CssClass="TableForm" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:RegularExpressionValidator ID="PriceValidator" runat="server" ControlToValidate="PriceIn" ValidationExpression="^\d+(\.\d\d)?$" CssClass="RequiredError" ErrorMessage="Enter valid price." />
                            <asp:RequiredFieldValidator ID="PriceRequiredValidator" runat="server" ControlToValidate="PriceIn" CssClass="RequiredError" ErrorMessage="Enter price." />
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="PriceLabel" runat="server" Text="Price:" CssClass="TableFormLabel"></asp:Label>
                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox ID="PriceIn" runat="server" CssClass="TableFormInput"></asp:TextBox>
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" CssClass="RequiredError" InitialValue="-1" ControlToValidate="CategoryDropDownList" Text="Select category."></asp:RequiredFieldValidator>
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="CategoryLabel" runat="server" Text="Category:" CssClass="TableFormLabel"></asp:Label>
                        </asp:TableCell><asp:TableCell>
                            <asp:DropDownList ID="CategoryDropDownList" runat="server" CssClass="TableFormInput" DataSourceID="PricingDataSource" DataTextField="Name" DataValueField="PriceID" AppendDataBoundItems="true">
                                <asp:ListItem Selected="True" Value="-1">--</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" CssClass="RequiredError" InitialValue="-1" ControlToValidate="MarginDropDownList" Text="Select margin."></asp:RequiredFieldValidator>
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="MarginLabel" runat="server" Text="Labor:" CssClass="TableFormLabel"></asp:Label>
                        </asp:TableCell><asp:TableCell>
                            <asp:DropDownList ID="MarginDropDownList" runat="server" CssClass="TableFormInput" DataSourceID="MarginDataSource" DataTextField="Name" DataValueField="MarginID" AppendDataBoundItems="true">
                                <asp:ListItem Selected="True" Value="-1">--</asp:ListItem>
                            </asp:DropDownList>

                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell>

                        </asp:TableCell><asp:TableCell>
                            <asp:Label CssClass="TableFormLabel" Text="Make:" runat="server" />
                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox ID="MakeText" CssClass="TableFormInput" MaxLength="20" runat="server" />
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell>

                        </asp:TableCell><asp:TableCell>
                                                        <asp:Label CssClass="TableFormLabel" Text="Model:" runat="server" />

                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox ID="ModelText" CssClass="TableFormInput" MaxLength="20" runat="server" />

                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell>
                            
                        </asp:TableCell><asp:TableCell>
                            <asp:Label runat="server" Text="Issue:" CssClass="TableFormLabel" />
                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox CssClass="TableFormInput" ID="IssueTextBox" MaxLength="50" runat="server" />
                        </asp:TableCell></asp:TableRow></asp:Table></div><asp:SqlDataSource ID="PricingDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [Pricing]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="MarginDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [Margin]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="QuoteDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="CreateNewQuote" SelectCommandType="StoredProcedure"><SelectParameters><asp:ControlParameter ControlID="qcs" Name="Cust" PropertyName="CustID" Type="Int32" /><asp:ControlParameter ControlID="qcs" Name="Employee" PropertyName="EmpID" Type="Int32" /><asp:ControlParameter ControlID="CategoryDropDownList" Name="Price" PropertyName="SelectedValue" Type="Int32" /><asp:Parameter Name="Device" Type="Int32" /><asp:Parameter Name="Issue" Type="Int32" /><asp:ControlParameter ControlID="MarginDropDownList" Name="Margin" PropertyName="SelectedValue" Type="Int32" /><asp:ControlParameter ControlID="PriceIn" Name="Base" PropertyName="Text" Type="Decimal" /><asp:ControlParameter ControlID="FinalPriceField" Name="Final" PropertyName="Text" Type="Decimal" /><asp:Parameter DbType="Int32" Direction="Output" Name="New_PK" Type="Int32" /></SelectParameters></asp:SqlDataSource><div class="LabelDiv">
                <asp:Table CssClass="TableForm" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Button ID="CalculatePriceButton" runat="server" Text="Calculate Final Price" OnClick="CalculatePriceButton_Click" CssClass="MainLabel" Width="160px" />

                        </asp:TableCell><asp:TableCell>

                        </asp:TableCell><asp:TableCell>
                            <asp:Button ID="ClearButton" runat="server" Text="Clear" OnClick="ClearButton_Click" CssClass="inputbox" />
                        </asp:TableCell></asp:TableRow></asp:Table></div><div class="LabelDiv">
                <asp:Table CssClass="TableForm" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="FinalPriceLabel" runat="server" Text="Final Price:" CssClass="TableFormLabel"></asp:Label>
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="FinalPriceField" runat="server" Text="" CssClass="TableFormInput"></asp:Label>
                        </asp:TableCell><asp:TableCell>
                        </asp:TableCell></asp:TableRow></asp:Table></div><div class="LabelDiv">
                <asp:Button ID="CreateQuoteButton" runat="server" Text="Create Quote" OnClick="CreateQuoteButton_Click" Width="114px" />
            </div>
            <div class="LabelDiv">
                <asp:Table runat="server" CssClass="TableForm">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Button ID="BackButton" CausesValidation="false" CssClass="PageAction" Text="Back" runat="server" OnClick="BackButton_Click" />
                        </asp:TableCell><asp:TableCell></asp:TableCell><asp:TableCell>
                            <asp:Button ID="SignoutButton" CausesValidation="false" CssClass="PageAction" Text="Sign Out" OnClick="SignoutButton_Click" runat="server"></asp:Button>
                        </asp:TableCell></asp:TableRow></asp:Table></div></div></form></body></html>