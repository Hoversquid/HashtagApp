<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/QuotePage.aspx.cs" Inherits="QuoteLogin.QuotePage" %>

<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quote Renderer</title>
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
    <form id="quoteform" runat="server" method="post">
        <div class="MainForm">
            <cstate:QuoteControlState ID="qcs" runat="server" />

            <div class="LabelDiv">
                <asp:Panel ID="CustInfoPanel" runat="server" Visible="false">
                    <asp:Label runat="server" Text="Current Customer: " Font-Bold="true" />
                    <asp:Label ID="CustomerLabel" runat="server" />
                </asp:Panel>
                <asp:Panel ID="QuickQuotePanel" runat="server" Visible="false">
                    <asp:Label runat="server" Text="Quick Quote" Font-Bold="true" />
                </asp:Panel>
                <asp:Table CssClass="TableForm" runat="server" HorizontalAlign="Center">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:RegularExpressionValidator ID="PriceValidator" runat="server" ControlToValidate="PriceIn" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" CssClass="RequiredError" ErrorMessage="Enter valid price." />
                            <asp:RequiredFieldValidator ID="PriceRequiredValidator" runat="server" ControlToValidate="PriceIn" Display="Dynamic" CssClass="RequiredError" ErrorMessage="Enter price." />
                            <asp:CompareValidator runat="server" ControlToValidate="PriceIn" ValueToCompare="0" CssClass="RequiredError" Type="Double" Operator="GreaterThan" Display="Dynamic" ErrorMessage="Enter price above 0." />
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="PriceLabel" runat="server" Text="Price:" CssClass="TableFormLabel"></asp:Label>
                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox ID="PriceIn" runat="server" CssClass="inputbox"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" CssClass="RequiredError" InitialValue="-1" ControlToValidate="CategoryDropDownList" Text="Select category."></asp:RequiredFieldValidator>
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="CategoryLabel" runat="server" Text="Category:" CssClass="TableFormLabel"></asp:Label>
                        </asp:TableCell><asp:TableCell>
                            <asp:DropDownList ID="CategoryDropDownList" runat="server" CssClass="inputbox" DataSourceID="PricingDataSource" DataTextField="Name" DataValueField="PriceID" AppendDataBoundItems="true">
                                <asp:ListItem Selected="True" Value="-1">--</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" CssClass="RequiredError" InitialValue="-1" ControlToValidate="MarginDropDownList" Text="Select labor."></asp:RequiredFieldValidator>
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="MarginLabel" runat="server" Text="Labor:" CssClass="TableFormLabel"></asp:Label>
                        </asp:TableCell><asp:TableCell>
                            <asp:DropDownList ID="MarginDropDownList" runat="server" CssClass="inputbox" DataSourceID="MarginDataSource" DataTextField="Name" DataValueField="MarginID" AppendDataBoundItems="true">
                                <asp:ListItem Selected="True" Value="-1">--</asp:ListItem>
                            </asp:DropDownList>

                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" Text="Enter make." CssClass="RequiredError" ControlToValidate="MakeText" />
                        </asp:TableCell><asp:TableCell>
                            <asp:Label CssClass="TableFormLabel" Text="Make:" runat="server" />
                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox ID="MakeText" CssClass="inputbox" MaxLength="20" runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" CssClass="RequiredError" Text="Enter model." ControlToValidate="ModelText" />
                        </asp:TableCell><asp:TableCell>
                                                        <asp:Label CssClass="TableFormLabel" Text="Model:" runat="server" />

                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox ID="ModelText" CssClass="inputbox" MaxLength="20" runat="server" />

                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:RequiredFieldValidator runat="server" CssClass="RequiredError" Text="Enter issue." ControlToValidate="IssueTextBox" />
                        </asp:TableCell><asp:TableCell>
                            <asp:Label runat="server" Text="Issue:" CssClass="TableFormLabel" />
                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox CssClass="inputbox" ID="IssueTextBox" MaxLength="250" runat="server" TextMode="MultiLine" Height="80px" Font-Names="Arial" Font-Size="Smaller" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>
            <asp:SqlDataSource ID="PricingDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [Pricing]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="MarginDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [Margin]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="QuoteDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="CreateNewQuote" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="qcs" Name="Cust" PropertyName="CustID" Type="Int32" />
                    <asp:ControlParameter ControlID="qcs" Name="Employee" PropertyName="EmpID" Type="Int32" />
                    <asp:ControlParameter ControlID="CategoryDropDownList" Name="Price" PropertyName="SelectedValue" Type="Int32" />
                    <asp:Parameter Name="Device" Type="Int32" />
                    <asp:Parameter Name="Issue" Type="Int32" />
                    <asp:ControlParameter ControlID="MarginDropDownList" Name="Margin" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="PriceIn" Name="Base" PropertyName="Text" Type="Decimal" />
                    <asp:ControlParameter ControlID="FinalPriceField" Name="Final" PropertyName="Text" Type="Decimal" />
                    <asp:Parameter DbType="Int32" Direction="Output" Name="New_PK" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <div class="LabelDiv">

                <asp:Table CssClass="TableForm" runat="server" HorizontalAlign="Center">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Button ID="CalculatePriceButton" runat="server" Text="Calculate Final Price" OnClick="CalculatePriceButton_Click" CssClass="MainLabel" Width="160px" />

                        </asp:TableCell><asp:TableCell>

                        </asp:TableCell><asp:TableCell>
                            <asp:Button ID="ClearButton" runat="server" Text="Clear" OnClick="ClearButton_Click" CausesValidation="false" CssClass="inputbox" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>
            <div class="LabelDiv">
                <asp:Table CssClass="TableForm" runat="server" HorizontalAlign="Center">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="FinalPriceLabel" runat="server" Text="Final Price:" CssClass="TableFormLabel" Font-Bold="True"></asp:Label>
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="FinalPriceField" runat="server" Text="" CssClass="TableFormInput"></asp:Label>
                        </asp:TableCell><asp:TableCell>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>
            <div class="LabelDiv">
                <asp:Button ID="CreateQuoteButton" runat="server" Text="Create Quote" OnClick="CreateQuoteButton_Click" Width="114px" />
            </div>
            <asp:Table runat="server" CssClass="PageAction" ID="PageActionTable" CellPadding="20" HorizontalAlign="Center">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button ID="PageSignOutButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Sign Out" OnClick="PageSignOutButton_Click" />
                    </asp:TableCell><asp:TableCell></asp:TableCell><asp:TableCell>
                        <asp:Button ID="PageBackButton" CausesValidation="false" CssClass="TableFormButton" runat="server" Text="Back" OnClick="PageBackButton_Click" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
    </form>
</body>
</html>
