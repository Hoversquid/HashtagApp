<%@ Page MasterPageFile="MasterPage.Master" Language="C#" AutoEventWireup="True" CodeBehind="ProcedureChecklist.aspx.cs" Inherits="QuoteLogin.ProcedureChecklist" Title="Opening and Closing Procedures" %>

<%@ Register Assembly="QuoteLogin" Namespace="ControlLibrary.Controls" TagPrefix="cstate" %>

<asp:Content ID="MainProcedureChecklist" ContentPlaceHolderID="Main" runat="server">
    <asp:ScriptManager ID="ScriptManager" runat="server">
        <Scripts>
            <asp:ScriptReference Path="~/html2canvas.js" />
        </Scripts>
    </asp:ScriptManager>
    <script type="text/javascript">
        function PrintCanvas() {
            var canvasDiv = document.getElementById("CanvasDiv");
            var printDivs = document.getElementsByName("PrintDiv");
            var i;
            for (i = 0; i < printDivs.length; i++) {
                canvasDiv.appendChild(printDivs[i]);
            }
            html2canvas(canvasDiv).then(function (canvas) {
                //document.body.appendChild(canvas);
                var dataStr = canvas.toDataURL();
                var hiddenField = document.getElementById('<%= ImageString.ClientID %>');
                hiddenField.value = dataStr;
            })
        }
    </script>
    <cstate:QuoteControlState ID="qcs" runat="server" />
    <asp:HiddenField ID="ImageString" runat="server" />

    <asp:Panel ID="EmailPanel" runat="server" Visible="false">
        <asp:Table ID="EmailTable" runat="server" HorizontalAlign="Center" CellPadding="5">
            <asp:TableRow>
                <asp:TableCell>
                    <asp:Button ID="EmailButton" Width="120px" Text="Email" runat="server" OnClick="EmailButton_Click" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Button ID="EmailBack" Width="120px" Text="Back" runat="server" OnClick="EmailBack_Click" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell Font-Size="Large" Text="Primary Address: " />
                <asp:TableCell>
                    <asp:TextBox CssClass="AddedTextBox" ID="EmailPrimaryAddress" runat="server" Text="cbrooks@hashtagifixit.com" />

                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:Table runat="server" HorizontalAlign="Center">
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Center" ColumnSpan="2">
                    <asp:Button ID="EmailAddCCButton" Width="140px" Text="Add Address" runat="server" OnClick="EmailAddCCButton_Click" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
    <asp:Table ID="SelectionTable" HorizontalAlign="Center" runat="server">
        <asp:TableRow>
            <asp:TableCell Font-Size="Larger" HorizontalAlign="Left">Select procedure type: </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                <asp:DropDownList Font-Size="Large" ID="ProcedureTypeDropDown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ProcedureTypeDropDown_SelectedIndexChanged">
                    <asp:ListItem>--</asp:ListItem>
                    <asp:ListItem>Opening</asp:ListItem>
                    <asp:ListItem>Closing</asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell Font-Size="Larger" HorizontalAlign="Left">Select store: </asp:TableCell><asp:TableCell>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="StoreIDDropdown" InitialValue="0" ErrorMessage="*" CssClass="RequiredError" Display="Dynamic" />
                <asp:DropDownList Font-Size="Large" ID="StoreIDDropdown" runat="server" OnSelectedIndexChanged="StoreIDDropdown_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Value="0">--</asp:ListItem>
                    <asp:ListItem Value="1">Lowes Drive</asp:ListItem>
                    <asp:ListItem Value="2">Quin Lane</asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <div id="CanvasDiv" />
    <div class="PrintDiv">
        <asp:Label ID="DateLabel" runat="server" Font-Size="XX-Large" Font-Bold="True" CssClass="LabelHeader" />
        <asp:Label ID="StoreLabel" runat="server" Font-Size="XX-Large" Font-Bold="True" CssClass="LabelHeader" />
        <br />
    </div>
    <asp:Panel ID="OpeningProcedurePanel" runat="server" Visible="false">
        <div class="PrintDiv">
            <asp:CustomValidator ID="OpeningPeopleValid" runat="server" OnServerValidate="OpeningPeopleValid_ServerValidate" ErrorMessage="* Enter opening staff *" CssClass="SRRequiredError" />
            <asp:Table runat="server" CssClass="PanelLabelHeader">
                <asp:TableRow>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Right">Opening Person #1 : </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                        <asp:TextBox ID="OpeningPerson1" CssClass="AmountInputText" runat="server" /></asp:TableCell><asp:TableCell HorizontalAlign="Right">Opening Person #2 : </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                            <asp:TextBox ID="OpeningPerson2" CssClass="AmountInputText" runat="server" /></asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="LeftColumnGridDiv">
                        <div style="clear: both;">
                            <div class="LeftColumnGridDiv">
                                <asp:Table CssClass="CashCountTable" Height="420px" runat="server" CellPadding="0" CellSpacing="0">
                                    <asp:TableRow CssClass="TableHeader">
                                        <asp:TableCell ColumnSpan="2" Font-Bold="true">
                            Cash Count (Qty)
                                        </asp:TableCell><asp:TableCell Font-Bold="true" BackColor="DarkGray">
                            $$ Total
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Pennies:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="PennyAmtValid" runat="server" CssClass="SRRequiredError" ControlToValidate="PennyAmt" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox Width="55px" CssClass="AmountInputText" ID="PennyAmt" runat="server" CausesValidation="true" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox Width="55px" CssClass="AmountInputText" ID="PennyTotal" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Nickels:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="NickelAmtValid" runat="server" CssClass="SRRequiredError" ControlToValidate="NickelAmt" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox Width="55px" CssClass="AmountInputText" ID="NickelAmt" runat="server" CausesValidation="true" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox Width="55px" CssClass="AmountInputText" ID="NickelTotal" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Dimes:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="DimeAmtValid" runat="server" CssClass="SRRequiredError" ControlToValidate="DimeAmt" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox Width="55px" CssClass="AmountInputText" ID="DimeAmt" runat="server" CausesValidation="true" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox Width="55px" CssClass="AmountInputText" ID="DimeTotal" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Quarters:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="QuarterAmtValid" runat="server" CssClass="SRRequiredError" ControlToValidate="QuarterAmt" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="QuarterAmt" runat="server" CausesValidation="true" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="QuarterTotal" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Half Dollars:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="HalfDollarAmtValid" runat="server" CssClass="SRRequiredError" ControlToValidate="HalfDollarAmt" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="HalfDollarAmt" runat="server" CausesValidation="true" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="HalfDollarTotal" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Penny Roll:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="PennyRollAmtValid" runat="server" CssClass="SRRequiredError" ControlToValidate="PennyRollAmt" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="PennyRollAmt" runat="server" CausesValidation="true" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="PennyRollTotal" BackColor="Yellow" Enabled="false" runat="server" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Nickel Roll:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="NickelRollAmtValid" runat="server" CssClass="SRRequiredError" ControlToValidate="NickelRollAmt" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="NickelRollAmt" runat="server" CausesValidation="true" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="NickelRollTotal" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Dime Roll:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="DimeRollAmtValid" runat="server" CssClass="SRRequiredError" ControlToValidate="DimeRollAmt" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="DimeRollAmt" runat="server" CausesValidation="true" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="DimeRollTotal" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Quarter Roll:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="QuarterRollAmtValid" runat="server" CssClass="SRRequiredError" ControlToValidate="QuarterRollAmt" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="QuarterRollAmt" runat="server" CausesValidation="true" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="QuarterRollTotal" BackColor="Yellow" Enabled="false" runat="server" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </div>
                            <div class="RightColumnGridDiv">
                                <asp:Table CssClass="CashCountTable" Height="420px" runat="server" CellPadding="0" CellSpacing="0">
                                    <asp:TableRow CssClass="TableHeader">
                                        <asp:TableCell ColumnSpan="2" Font-Bold="true">
                            Cash Count (Qty)
                                        </asp:TableCell><asp:TableCell Font-Bold="true" BorderStyle="Solid" BackColor="DarkGray">
                            $$ Total
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Dollar Coins:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="DollarCoinsAmtValid" runat="server" CssClass="SRRequiredError" ControlToValidate="DollarCoinsAmt" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" ID="DollarCoinsAmt" Width="55px" runat="server" CausesValidation="true" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="DollarCoinsTotal" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                $1 bill:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="OneDollarAmtValid" runat="server" CssClass="SRRequiredError" ControlToValidate="OneDollarAmt" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="OneDollarAmt" runat="server" CausesValidation="true" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="OneDollarTotal" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                $2 bill:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="TwoDollarAmtValid" runat="server" CssClass="SRRequiredError" ControlToValidate="TwoDollarAmt" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="TwoDollarAmt" runat="server" CausesValidation="true" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="TwoDollarTotal" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                $5 bill:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="FiveDollarAmtValid" runat="server" CssClass="SRRequiredError" ControlToValidate="FiveDollarAmt" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="FiveDollarAmt" runat="server" CausesValidation="true" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="FiveDollarTotal" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                $10 bill:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="TenDollarAmtValid" runat="server" CssClass="SRRequiredError" ControlToValidate="TenDollarAmt" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="TenDollarAmt" runat="server" CausesValidation="true" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="TenDollarTotal" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                $20 bill:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="TwentyDollarAmtValid" runat="server" CssClass="SRRequiredError" ControlToValidate="TwentyDollarAmt" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="TwentyDollarAmt" runat="server" CausesValidation="true" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="TwentyDollarTotal" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                $50 bill:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="FiftyDollarAmtValid" runat="server" CssClass="SRRequiredError" ControlToValidate="FiftyDollarAmt" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="FiftyDollarAmt" runat="server" CausesValidation="true" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="FiftyDollarTotal" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                $100 bill:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="HundredDollarAmtValid" runat="server" CssClass="SRRequiredError" ControlToValidate="HundredDollarAmt" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="HundredDollarAmt" runat="server" CausesValidation="true" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="HundredDollarTotal" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell ColumnSpan="3" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell Font-Bold="true">Cash Total:</asp:TableCell><asp:TableCell ColumnSpan="2" Font-Bold="true" BackColor="DarkGray">
                                            <asp:TextBox CssClass="AmountInputText" ID="CashCountTotal" Enabled="false" runat="server" Font-Bold="true" Width="80%" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                                <asp:Button ID="CalcOpeningButton" CausesValidation="true" runat="server" Text="Calculate" CssClass="CalcButton" OnClick="CalcOpeningButton_Click" />
                            </div>
                        </div>
                        <asp:Table runat="server" CssClass="IncidentsTable">
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:RequiredFieldValidator ID="OpeningCommentsValid" runat="server" InitialValue="" ControlToValidate="OpeningCommentsText" ErrorMessage="*Include incidents/comments*" CssClass="SRRequiredError" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell Font-Bold="true">
                            Pre-Opening incidents and/or comments
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:TextBox runat="server" ID="OpeningCommentsText" TextMode="MultiLine" Width="80%" Height="140px" />
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="RightColumnGridDiv">
                <asp:CustomValidator runat="server" ID="OpeningChecklistValid" OnServerValidate="OpeningChecklistValid_ServerValidate" ErrorMessage="* Check all procedures *" CssClass="SRRequiredError" />
                <asp:CheckBoxList CssClass="CheckboxTable" ID="OpeningChecklist" CellPadding="6" RepeatColumns="1" RepeatDirection="Vertical" RepeatLayout="Table" BorderStyle="Ridge" TextAlign="Left" runat="server">
                    <asp:ListItem>Make sure cash drawer is counted before opening store:</asp:ListItem>
                    <asp:ListItem>Make sure due today, due tommorrow, past due email are sent before store open</asp:ListItem>
                    <asp:ListItem>Review previous night EOD paperwork to ensure it is filed correctly.</asp:ListItem>
                    <asp:ListItem>Notify manager if cash drawers is less than 100 and if not counted before store opens</asp:ListItem>
                    <asp:ListItem>Make sure store is clean and ready for business</asp:ListItem>
                    <asp:ListItem>Turn on open sign at 10am/ unlock door/Turn on music</asp:ListItem>
                    <asp:ListItem>Verify Price strips/fact tags are in place/correct for all displayed</asp:ListItem>
                    <asp:ListItem>Turn off outside sign at breaker:</asp:ListItem>
                    <asp:ListItem>Ensure all areas front and back are clear of any proprietary info</asp:ListItem>
                    <asp:ListItem>Review previous day EOD paperwork and file away</asp:ListItem>
                </asp:CheckBoxList>
            </div>
            <div style="clear: both;" />
        </div>
    </asp:Panel>
    <asp:Panel ID="ClosingProcedurePanel" runat="server" Visible="false">
        <div class="PrintDiv">
            <asp:CustomValidator ID="ClosingStaffValid" runat="server" OnServerValidate="ClosingStaffValid_ServerValidate" ErrorMessage="* Enter closing staff *" CssClass="SRRequiredError" />
            <asp:Table runat="server" CssClass="PanelLabelHeader">
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Right">Closing Person #1 : </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                        <asp:TextBox ID="ClosingPerson1" CssClass="AmountInputText" runat="server" /></asp:TableCell><asp:TableCell HorizontalAlign="Right">Closing Person #2 : </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                            <asp:TextBox ID="ClosingPerson2" CssClass="AmountInputText" runat="server" /></asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="LeftColumnGridDiv">
                        <div style="clear: both;">
                            <div class="LeftColumnGridDiv">
                                <asp:Table CssClass="CashCountTable" Height="420px" runat="server" CellPadding="0" CellSpacing="0">
                                    <asp:TableRow CssClass="TableHeader">
                                        <asp:TableCell ColumnSpan="2" Font-Bold="true">
                            Cash Count (Qty)
                                        </asp:TableCell><asp:TableCell Font-Bold="true" BackColor="DarkGray">
                            $$ Total
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Pennies:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="PennyAmt2Valid" runat="server" CssClass="SRRequiredError" ControlToValidate="PennyAmt2" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="PennyAmt2" runat="server" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="PennyTotal2" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Nickels:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="NickelAmt2Valid" runat="server" CssClass="SRRequiredError" ControlToValidate="NickelAmt2" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="NickelAmt2" runat="server" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="NickelTotal2" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Dimes:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="DimeAmt2Valid" runat="server" CssClass="SRRequiredError" ControlToValidate="DimeAmt2" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="DimeAmt2" runat="server" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="DimeTotal2" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Quarters:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="QuarterAmt2Valid" runat="server" CssClass="SRRequiredError" ControlToValidate="QuarterAmt2" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="QuarterAmt2" runat="server" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="QuarterTotal2" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Half Dollars:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="HalfDollarAmt2Valid" runat="server" CssClass="SRRequiredError" ControlToValidate="HalfDollarAmt2" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="HalfDollarAmt2" runat="server" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="HalfDollarTotal2" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Penny Roll:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="PennyRollAmt2Valid" runat="server" CssClass="SRRequiredError" ControlToValidate="PennyRollAmt2" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="PennyRollAmt2" runat="server" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="PennyRollTotal2" Enabled="false" BackColor="Yellow" runat="server" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Nickel Roll:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="NickelRollAmt2Valid" runat="server" CssClass="SRRequiredError" ControlToValidate="NickelRollAmt2" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="NickelRollAmt2" runat="server" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="NickelRollTotal2" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Dime Roll:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="DimeRollAmt2Valid" runat="server" CssClass="SRRequiredError" ControlToValidate="DimeRollAmt2" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="DimeRollAmt2" runat="server" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="DimeRollTotal2" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Quarter Roll:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="QuarterRollAmt2Total" runat="server" CssClass="SRRequiredError" ControlToValidate="QuarterRollAmt2" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="QuarterRollAmt2" runat="server" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="QuarterRollTotal2" BackColor="Yellow" Enabled="false" runat="server" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </div>
                            <div class="RightColumnGridDiv">
                                <asp:Table CssClass="CashCountTable" Height="420px" runat="server" CellPadding="0" CellSpacing="0">
                                    <asp:TableRow CssClass="TableHeader">
                                        <asp:TableCell ColumnSpan="2" Font-Bold="true">
                            Cash Count (Qty)
                                        </asp:TableCell><asp:TableCell Font-Bold="true" BorderStyle="Solid" BackColor="DarkGray">
                            $$ Total
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                Dollar Coins:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="DollarCoinsAmt2Valid" runat="server" CssClass="SRRequiredError" ControlToValidate="DollarCoinsAmt2" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" ID="DollarCoinsAmt2" Width="55px" runat="server" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="DollarCoinsTotal2" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                $1 bill:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="OneDollarAmt2Total" runat="server" CssClass="SRRequiredError" ControlToValidate="OneDollarAmt2" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="OneDollarAmt2" runat="server" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="OneDollarTotal2" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                $2 bill:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="TwoDollarAmt2Valid" runat="server" CssClass="SRRequiredError" ControlToValidate="TwoDollarAmt2" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="TwoDollarAmt2" runat="server" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="TwoDollarTotal2" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                $5 bill:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="FiveDollarAmt2Valid" runat="server" CssClass="SRRequiredError" ControlToValidate="FiveDollarAmt2" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="FiveDollarAmt2" runat="server" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="FiveDollarTotal2" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                $10 bill:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="TenDollarAmt2Valid" runat="server" CssClass="SRRequiredError" ControlToValidate="TenDollarAmt2" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="TenDollarAmt2" runat="server" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="TenDollarTotal2" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                $20 bill:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="TwentyDollarAmt2Valid" runat="server" CssClass="SRRequiredError" ControlToValidate="TwentyDollarAmt2" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="TwentyDollarAmt2" runat="server" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="TwentyDollarTotal2" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                $50 bill:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="FiftyDollarAmt2Valid" runat="server" CssClass="SRRequiredError" ControlToValidate="FiftyDollarAmt2" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="FiftyDollarAmt2" runat="server" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="FiftyDollarTotal2" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                $100 bill:
                                        </asp:TableCell><asp:TableCell>
                                            <asp:RegularExpressionValidator ID="HundredDollarAmt2Valid" runat="server" CssClass="SRRequiredError" ControlToValidate="HundredDollarAmt2" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid price." />
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="HundredDollarAmt2" runat="server" />
                                        </asp:TableCell><asp:TableCell>
                                            <asp:TextBox CssClass="AmountInputText" Width="55px" ID="HundredDollarTotal2" BackColor="Yellow" runat="server" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell ColumnSpan="3" />
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell Font-Bold="true">Cash Total:</asp:TableCell><asp:TableCell ColumnSpan="2" Font-Bold="true" BackColor="DarkGray">
                                            <asp:TextBox CssClass="AmountInputText" ID="CashCountTotal2" runat="server" Font-Bold="true" Width="80%" Enabled="false" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                                <asp:Button ID="CalcClosingButton" CausesValidation="true" runat="server" Text="Calculate" CssClass="CalcButton" OnClick="CalcClosingButton_Click" />

                            </div>
                        </div>
                        <div style="clear: both;">
                            <asp:Table runat="server" CssClass="IncidentsTable">
                                <asp:TableRow>
                                    <asp:TableCell>
                                        <asp:RequiredFieldValidator ID="ClosingCommentsValid" InitialValue="" ControlToValidate="ClosingCommentsText" runat="server" CssClass="SRRequiredError" ErrorMessage="*Include incidents/comments*" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell Font-Bold="true">
                            Pre-Closing incidents and/or comments
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell>

                                        <asp:TextBox ID="ClosingCommentsText" runat="server" TextMode="MultiLine" Width="80%" Height="140px" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="RightColumnGridDiv">
                <asp:CustomValidator runat="server" ID="ClosingChecklistValid" OnServerValidate="ClosingChecklistValid_ServerValidate" ErrorMessage="* Check all procedures *" CssClass="SRRequiredError" />
                <asp:CheckBoxList ID="ClosingChecklist" runat="server" CssClass="CheckboxTable" CellPadding="6" RepeatColumns="1" RepeatDirection="Vertical" RepeatLayout="Table" BorderStyle="Ridge" TextAlign="Left">
                    <asp:ListItem>File invoices/service request/Part order on order form</asp:ListItem>
                    <asp:ListItem>Verify Price strips/fact tags are in place/correct for all displayed</asp:ListItem>
                    <asp:ListItem>Turn on outside sign at breaker</asp:ListItem>
                    <asp:ListItem>Ensure all area's front and back are clear of any proprietary info</asp:ListItem>
                    <asp:ListItem>How many repairs was completed/pre-own & accessory sold</asp:ListItem>
                    <asp:ListItem>Make sure all notes have been put on accounts</asp:ListItem>
                    <asp:ListItem>Clear all customer info from itunes and any other drives </asp:ListItem>
                    <asp:ListItem>Sweep, mop, take out trash, clean glass and all other areas nessasary</asp:ListItem>
                    <asp:ListItem>Charge store phone and any other devices on display</asp:ListItem>
                    <asp:ListItem>File or shred paperwork ensure notes are on accounts</asp:ListItem>
                    <asp:ListItem>Ensure panels are locked / Run batch out</asp:ListItem>
                    <asp:ListItem>Ensure deposit is correct and verified by both closers/signed/dropped</asp:ListItem>
                    <asp:ListItem>Email Mr. Charlie EOB info and order form / set alarm</asp:ListItem>
                    <asp:ListItem>Bank deposit slips have 2 full signatures</asp:ListItem>
                    <asp:ListItem>Deposit bag sealed before placing in drop safe</asp:ListItem>
                </asp:CheckBoxList>
            </div>
            <div style="clear: both;" />
        </div>
        <asp:SqlDataSource ID="BankDepositDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:QuoteDBConnection %>" SelectCommand="SELECT * FROM [Bank_Deposit] WHERE [DepositID] = @DepositID">
            <SelectParameters>
                <asp:ControlParameter ControlID="qcs" Name="DepositID" PropertyName="DepositID" Type="Int32" ConvertEmptyStringToNull="False" />
            </SelectParameters>
        </asp:SqlDataSource>
        <div class="PrintDiv">
            <asp:UpdatePanel ID="DepositPanel" Visible="false" runat="server">
                <ContentTemplate>

                    <div class="LeftColumnGridDiv">
                        <asp:Table runat="server" CssClass="BankDepositTable" CellPadding="0" CellSpacing="0">
                            <asp:TableRow CssClass="TableHeader" Height="30px">
                                <asp:TableCell Font-Bold="true" BackColor="Black" ForeColor="White" Font-Size="Large" Width="150px" HorizontalAlign="Center">
                    EOD Activity
                                </asp:TableCell><asp:TableCell Font-Size="Small">
                    How Many Repairs Complete
                                </asp:TableCell><asp:TableCell Font-Size="Small">
                    Total Accessories Sold $$
                                </asp:TableCell><asp:TableCell Font-Size="Small">
                    Pre-own Sold
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell ColumnSpan="4" Height="5px" />
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Right">
                        Monday:
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="RepairsMonValid" runat="server" CssClass="SRRequiredError" ControlToValidate="RepairsMon" Text="*" Display="Dynamic" ValidationExpression="^\d+$" ErrorMessage="Enter valid number." />
                                    <asp:TextBox CssClass="AmountInputText" ID="RepairsMon" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="AccessMonValid" runat="server" CssClass="SRRequiredError" ControlToValidate="AccessMon" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="AccessMon" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="PreownMonValid" runat="server" CssClass="SRRequiredError" ControlToValidate="PreownMon" Text="*" Display="Dynamic" ValidationExpression="^\d+$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="PreownMon" runat="server" CausesValidation="true" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Right">
                        Tuesday:
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="RepairsTueValid" runat="server" CssClass="SRRequiredError" ControlToValidate="RepairsTues" Text="*" Display="Dynamic" ValidationExpression="^\d+$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="RepairsTues" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="AccessTueValid" runat="server" CssClass="SRRequiredError" ControlToValidate="AccessTues" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="AccessTues" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="PreownTueValid" runat="server" CssClass="SRRequiredError" ControlToValidate="PreownTues" Text="*" Display="Dynamic" ValidationExpression="^\d+$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="PreownTues" runat="server" CausesValidation="true" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Right">
                        Wednesday:
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="RepairsWedValid" runat="server" CssClass="SRRequiredError" ControlToValidate="RepairsWed" Text="*" Display="Dynamic" ValidationExpression="^\d+$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="RepairsWed" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="AccessWedValid" runat="server" CssClass="SRRequiredError" ControlToValidate="AccessWed" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="AccessWed" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="PreownWedValid" runat="server" CssClass="SRRequiredError" ControlToValidate="PreownWed" Text="*" Display="Dynamic" ValidationExpression="^\d+$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="PreownWed" runat="server" CausesValidation="true" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Right">
                        Thursday:
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="RepairsThurValid" runat="server" CssClass="SRRequiredError" ControlToValidate="RepairsThur" Text="*" Display="Dynamic" ValidationExpression="^\d+$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="RepairsThur" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="AccessThurValid" runat="server" CssClass="SRRequiredError" ControlToValidate="AccessThur" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="AccessThur" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="PreownThurValid" runat="server" CssClass="SRRequiredError" ControlToValidate="PreownThur" Text="*" Display="Dynamic" ValidationExpression="^\d+$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="PreownThur" runat="server" CausesValidation="true" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Right">
                        Friday:
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="RepairsFriValid" runat="server" CssClass="SRRequiredError" ControlToValidate="RepairsFri" Text="*" Display="Dynamic" ValidationExpression="^\d+$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="RepairsFri" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="AccessFriValid" runat="server" CssClass="SRRequiredError" ControlToValidate="AccessFri" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="AccessFri" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="PreownFriValid" runat="server" CssClass="SRRequiredError" ControlToValidate="PreownFri" Text="*" Display="Dynamic" ValidationExpression="^\d+$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="PreownFri" runat="server" CausesValidation="true" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Right">
                        Saturday:
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="RepairsSatValid" runat="server" CssClass="SRRequiredError" ControlToValidate="RepairsSat" Text="*" Display="Dynamic" ValidationExpression="^\d+$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="RepairsSat" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="AccessSatValid" runat="server" CssClass="SRRequiredError" ControlToValidate="AccessSat" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="AccessSat" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="PreownSatValid" runat="server" CssClass="SRRequiredError" ControlToValidate="PreownSat" Text="*" Display="Dynamic" ValidationExpression="^\d+$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="PreownSat" runat="server" CausesValidation="true" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Right" Font-Bold="true">
                        Total AIMSI Deposit:
                                </asp:TableCell><asp:TableCell>
                                    <asp:TextBox CssClass="AmountInputText" ID="RepairsTotal" runat="server" BackColor="Yellow" Enabled="false" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:TextBox CssClass="AmountInputText" ID="AccessTotal" runat="server" BackColor="Yellow" Enabled="false" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:TextBox CssClass="AmountInputText" ID="PreownTotal" runat="server" BackColor="Yellow" Enabled="false" />
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <asp:Table runat="server" CssClass="IncidentsTable">
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:RequiredFieldValidator ID="DepositCommentsValid" runat="server" ControlToValidate="DepositComments" CssClass="SRRequiredError" ErrorMessage="* Enter comments *" InitialValue="" /></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell Font-Bold="true">
                            Comments
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:TextBox ID="DepositComments" runat="server" TextMode="MultiLine" Width="80%" Height="140px" />
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </div>
                    <div class="RightColumnGridDiv">
                        <asp:Table runat="server" CssClass="BankDepositTable" CellPadding="0" CellSpacing="0">
                            <asp:TableRow CssClass="TableHeader" Height="30px">
                                <asp:TableCell Font-Bold="true" BackColor="Black" ForeColor="White" Font-Size="Large" HorizontalAlign="Center">
                    Weekly Deposits
                                </asp:TableCell><asp:TableCell Font-Size="Small" Width="70px">
                    Credit Card Amount
                                </asp:TableCell><asp:TableCell Font-Size="Small">
                    Cash Amount
                                </asp:TableCell><asp:TableCell Font-Size="Small">
                    Daily Avg Ticket
                                </asp:TableCell><asp:TableCell Font-Size="Small">Returns</asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell ColumnSpan="5" Height="5px" />
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Right">
                        Monday:
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="CreditMonValid" runat="server" CssClass="SRRequiredError" ControlToValidate="CreditMon" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="CreditMon" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="CashMonValid" runat="server" CssClass="SRRequiredError" ControlToValidate="CashMon" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="CashMon" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="AvgMonValid" runat="server" CssClass="SRRequiredError" ControlToValidate="AvgMon" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="AvgMon" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="ReturnMonValid" runat="server" CssClass="SRRequiredError" ControlToValidate="ReturnMon" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="ReturnMon" runat="server" CausesValidation="true" />

                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Right">
                        Tuesday:
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="CreditTuesValid" runat="server" CssClass="SRRequiredError" ControlToValidate="CreditTues" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="CreditTues" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="CashTuesValid" runat="server" CssClass="SRRequiredError" ControlToValidate="CashTues" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="CashTues" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="AvgTuesValid" runat="server" CssClass="SRRequiredError" ControlToValidate="AvgTues" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="AvgTues" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="ReturnTuesValid" runat="server" CssClass="SRRequiredError" ControlToValidate="ReturnTues" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="ReturnTues" runat="server" CausesValidation="true" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Right">
                        Wednesday:
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="CreditWedValid" runat="server" CssClass="SRRequiredError" ControlToValidate="CreditWed" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="CreditWed" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="CashWedValid" runat="server" CssClass="SRRequiredError" ControlToValidate="CashWed" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="CashWed" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="AvgWedValid" runat="server" CssClass="SRRequiredError" ControlToValidate="AvgWed" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="AvgWed" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" CssClass="SRRequiredError" ControlToValidate="ReturnWed" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />

                                    <asp:TextBox CssClass="AmountInputText" ID="ReturnWed" runat="server" CausesValidation="true" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Right">
                        Thursday:
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="CreditThurValid" runat="server" CssClass="SRRequiredError" ControlToValidate="CreditThur" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="CreditThur" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="CashThurValid" runat="server" CssClass="SRRequiredError" ControlToValidate="CashThur" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="CashThur" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="AvgThurValid" runat="server" CssClass="SRRequiredError" ControlToValidate="AvgThur" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="AvgThur" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="ReturnThurValid" runat="server" CssClass="SRRequiredError" ControlToValidate="ReturnThur" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="ReturnThur" runat="server" CausesValidation="true" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Right">
                        Friday:
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="CreditFriValid" runat="server" CssClass="SRRequiredError" ControlToValidate="CreditFri" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="CreditFri" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="CashFriValid" runat="server" CssClass="SRRequiredError" ControlToValidate="CashFri" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="CashFri" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="AvgFriValid" runat="server" CssClass="SRRequiredError" ControlToValidate="AvgFri" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="AvgFri" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="ReturnFriValid" runat="server" CssClass="SRRequiredError" ControlToValidate="ReturnFri" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="ReturnFri" runat="server" CausesValidation="true" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Right">
                        Saturday:
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="CreditSatValid" runat="server" CssClass="SRRequiredError" ControlToValidate="CreditSat" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="CreditSat" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="CashSatValid" runat="server" CssClass="SRRequiredError" ControlToValidate="CashSat" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="CashSat" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="AvgSatValid" runat="server" CssClass="SRRequiredError" ControlToValidate="AvgSat" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="AvgSat" runat="server" CausesValidation="true" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:RegularExpressionValidator ID="ReturnSatValid" runat="server" CssClass="SRRequiredError" ControlToValidate="ReturnSat" Text="*" Display="Dynamic" ValidationExpression="^\d+(\.\d\d)?$" ErrorMessage="Enter valid amount." />
                                    <asp:TextBox CssClass="AmountInputText" ID="ReturnSat" runat="server" CausesValidation="true" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Right" Font-Bold="true">
                        Total Daily Amount:
                                </asp:TableCell><asp:TableCell>
                                    <asp:TextBox CssClass="AmountInputText" ID="CreditTotal" runat="server" BackColor="Yellow" Enabled="false" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:TextBox CssClass="AmountInputText" ID="CashTotal" runat="server" BackColor="Yellow" Enabled="false" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:TextBox CssClass="AmountInputText" ID="AvgTotal" runat="server" BackColor="Yellow" Enabled="false" />
                                </asp:TableCell><asp:TableCell>
                                    <asp:TextBox CssClass="AmountInputText" ID="ReturnTotal" runat="server" BackColor="Yellow" />

                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <asp:Button ID="CalcDepositButton" CssClass="CalcButton" CausesValidation="true" OnClick="CalcDepositButton_Click" Text="Calculate" runat="server" />
                    </div>
                    <div style="clear: both;"></div>

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </asp:Panel>
    <asp:Panel ID="SubmissionPanel" runat="server" Visible="false">
        <asp:UpdatePanel ID="PlaceHolderUpdatePanel" runat="server">
            <ContentTemplate>
                <asp:PlaceHolder ID="ImagePlaceHolder" runat="server" />
                <asp:Table CellPadding="5" CellSpacing="5" HorizontalAlign="Center" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Button ID="SubmitButton" BackColor="Green" ForeColor="White" Font-Bold="true" CausesValidation="true" runat="server" Text="Submit" Width="120px" OnClick="SubmitButton_Click" />
                        </asp:TableCell><asp:TableCell>
                            <asp:Button ID="BackButton" Width="120px" Text="Back" runat="server" CausesValidation="false" OnClick="SubmitBackButton_Click" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>
</asp:Content>
