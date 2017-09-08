<%@ Page Language="c#" CodeBehind="Item.aspx.cs" AutoEventWireup="true" Inherits="AuctionMVCWeb.CharityAuction.Item" %>

<%@ Register Src="Header.ascx" TagName="Header" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Charity Auction</title>
    <link href="styles/style.css" rel="stylesheet" type="text/css" />

    <link href="Content/css" rel="stylesheet" type="text/css" />
<link href="bundles/modernizr" rel="stylesheet" type="text/css" />
<link href="bundles/jquery" rel="stylesheet" type="text/css" />
<link href="bundles/bootstrap" rel="stylesheet" type="text/css" />


    <script type="text/javascript">
        function noenter() {
          return !(window.event && window.event.keyCode == 13); }
    </script>
</head>
<body>



     <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li>
                        <a href="/Home/Index">Home</a>

                    </li>
                    <li class="dropdown">


                        <li>
                            <a href="/User/Login">Log In</a>
                        </li>

                        <li>
                            <a href="/User/Register">Register</a>
                        </li>

                        <li>
                            <a href="/DementiaHackathon/auction">Auction</a>
                        </li>

                        <li>
                            <a href="/DementiaHackathon/addAuction">Add Item for Auction</a>
                        </li>
                </ul>

            </div>
        </div>
    </div>

    <div class="PageLayout">

        <form id="Form1" method="post" runat="server">

            <!--Header-->
            <uc1:Header ID="Header1" runat="server" />

            <table class="AuctionItem">
                <tr class="ThemeColor" style="height: 35px;">
                    <td>
                        <asp:Label ID="lblItemName" runat="server" Font-Size="Medium" Font-Bold="true"></asp:Label>
                    </td>
                    <td style="text-align: right;">Lot number
                        <asp:Label ID="lbItemId" runat="server"></asp:Label>
                    </td>
                </tr>

                <tr>
                    <td />
                </tr>

                <tr class="ThemeColorAlt2">
                    <td style="vertical-align: top; width: 50%;">

                        <table width="100%" border="0">
                            <tr>
                                <td>Current bid:</td>
                                <td>
                                    <asp:Label ID="lblCurrentBid" runat="server"></asp:Label>&nbsp;
									<asp:LinkButton ID="LinkButton1" runat="server" Font-Size="X-Small" CausesValidation="False" OnClick="LinkButton1_Click">Refresh</asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td>End Time:</td>
                                <td>
                                    <asp:Label ID="lblEndTime" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>History:</td>
                                <td>
                                    <asp:HyperLink ID="lnkBids" runat="server" Target="_blank"></asp:HyperLink>
                                </td>
                            </tr>
                            <tr>
                                <td>Winning bidder:</td>
                                <td>
                                    <asp:Label ID="lblHighBidder" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>Location:</td>
                                <td>
                                    <asp:Label ID="lblLocation" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>

                    </td>
                    <td style="vertical-align: top; width: 50%;">

                        <table width="100%" align="right" border="0">
                            <tr>
                                <td style="vertical-align: top; text-align: right;" colspan="2">
                                    <asp:Literal ID="litUpdate" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;" colspan="2">Place a bid&nbsp;

									<asp:TextBox ID="txtBid" onkeypress="return noenter()" runat="server" Width="80px" onclick="javascript:select();" MaxLength="11"></asp:TextBox>

                                    <asp:Button ID="btnBid" runat="server" Width="80px" Text="Bid Now" CssClass="ThemeColor" OnClick="btnBid_Click"></asp:Button>
                                    <br />
                                    <br />

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="<br>No bid amount" ControlToValidate="txtBid"
                                        Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtBid"
                                        ErrorMessage="Bid format incorrect" ValidationExpression="^\d+(?:\.\d{0,2})?$"></asp:RegularExpressionValidator></td>
                            </tr>
                        </table>

                    </td>
                </tr>

                <tr>
                    <td />
                </tr>

                <tr class="ThemeColor">
                    <td>Description</td>
                    <td />
                </tr>

                <tr>
                    <td />
                </tr>

                <tr>
                    <td class="ThemeColorAlt2" colspan="2">
                        <div style="padding: 5px;">
                            <asp:Label ID="lblDescription" runat="server"></asp:Label>
                        </div>
                        <div style="text-align: right">
                            Seller:
							<asp:Label ID="lblSeller" runat="server"></asp:Label>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td />
                </tr>

                <tr class="ThemeColor" style="height: 5px;">
                    <td colspan="5"></td>
                </tr>
            </table>

          

        </form>

    </div>

</body>
</html>
