<%@ Page Language="c#" CodeBehind="Auctions.aspx.cs" AutoEventWireup="True" Inherits="SoftwareSolutions.CharityAuction.Auctions" %>
<%@ OutputCache Duration="1" VaryByParam="c" %>
<%@ Register Src="Header.ascx" TagName="Header" TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

    <title>Charity Auction</title>
    <link href="styles/style.css" rel="stylesheet" type="text/css" />

    <link href="Content/css" rel="stylesheet" type="text/css" />
    <link href="bundles/modernizr" rel="stylesheet" type="text/css" />
    <link href="bundles/jquery" rel="stylesheet" type="text/css" />
    <link href="bundles/bootstrap" rel="stylesheet" type="text/css" />

    <style type="text/css">
        .textbox {
            font-family: Footlight MT Light;
            font-size: 24pt;
            text-align: center;
        }
    </style>

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

        <table class="AuctionList">

            <tr class="ThemeColor" style="height: 35px;">

                <td class="textbox">Welcome to the Auction Page  
                          <body>

                              <form action="https://www.paypal.com/cgi-bin/webscr" method="post">
                                  <input type="hidden" name="cmd" value="_xclick">
                                  <input type="hidden" name="business" value="divjag-facilitator@hotmail.com">
                                  <input type="hidden" name="lc" value="CA">
                                  <input type="hidden" name="item_name" value="Merchandise">
                                  <input type="hidden" name="amount" value="12.00">
                                  <input type="hidden" name="currency_code" value="CAD">
                                  <input type="hidden" name="button_subtype" value="products">
                                  <input type="hidden" name="bn" value="PP-BuyNowBF:btn_buynowCC_LG.gif:NonHosted">
                                  <input type="image" src="https://www.paypal.com/en_US/i/btn/btn_buynowCC_LG.gif"
                                      border="0" name="submit" align="right" alt="PayPal - The safer, easier way to pay online!">
                                  <img alt="" border="0" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
                              </form>
                          </body>
                </td>

            </tr>
        </table>
        <form id="Form1" method="post" runat="server">

            <uc2:Header ID="Header1" runat="server" EnableViewState="false" />

            <div class="SubHeading">
                <asp:Literal ID="litHeading" runat="server" EnableViewState="false" />
            </div>

            <asp:DataList ID="dlListings" runat="server" BorderStyle="None"
                BorderWidth="0px" EnableViewState="False" RepeatLayout="Table">
                <HeaderTemplate>
                    <table class="AuctionList">
                        <tr class="ThemeColor" style="height: 35px;">
                            <td nowrap="nowrap"><a href="Auctions.aspx?s=Name"><b>Item</b></a></td>
                            <td nowrap="nowrap"><a href="Auctions.aspx?s=Location"><b>Location</b></a></td>
                            <td nowrap="nowrap"><a href="Auctions.aspx?s=Buyer"><b>Winning&nbsp;Bidder</b></a></td>
                            <td nowrap="nowrap" width="80" style="text-align: center;"><a href="Auctions.aspx?s=BidNumber"><b>Bids</b></a></td>
                            <td nowrap="nowrap" width="80"><a href="Auctions.aspx?s=BidAmount"><b>Price</b></a></td>
                            <td nowrap="nowrap" width="80"><a href="Auctions.aspx?s=DateClose"><b>Time Left</b></a></td>
                        </tr>
                </HeaderTemplate>
                <FooterTemplate>
                    <tr class="ThemeColor" style="height: 5px;">
                        <td colspan="6"></td>
                    </tr>
                    </table>
                </FooterTemplate>
                <ItemTemplate>
                    <tr class="ThemeColorAlt">
                        <td width="100%"><a href='Item.aspx?i=<%# DataBinder.Eval(Container.DataItem, "Id") %>'><%# DataBinder.Eval(Container.DataItem, "Name") %></a><br>
                            <%# FormatDescription(DataBinder.Eval(Container.DataItem, "Description").ToString()) %>
                        </td>
                        <td nowrap="nowrap"><%# DataBinder.Eval(Container.DataItem, "Location") %></td>
                        <td nowrap="nowrap"><%# DataBinder.Eval(Container.DataItem, "Buyer") %></td>
                        <td nowrap="nowrap" style="text-align: center;"><%# DataBinder.Eval(Container.DataItem, "BidNumber") %></td>
                        <td nowrap="nowrap"><%# FormatAmount(DataBinder.Eval(Container.DataItem, "BidAmount").ToString()) %></td>
                        <td nowrap="nowrap" style="text-align: right;"><%# FormatCountdown(DataBinder.Eval(Container.DataItem, "DateClose").ToString()) %></td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr class="ThemeColorAlt2">
                        <td width="100%"><a href='Item.aspx?i=<%# DataBinder.Eval(Container.DataItem, "Id") %>'><%# DataBinder.Eval(Container.DataItem, "Name") %></a><br>
                            <%# FormatDescription(DataBinder.Eval(Container.DataItem, "Description").ToString()) %>
                        </td>
                        <td nowrap="nowrap"><%# DataBinder.Eval(Container.DataItem, "Location") %></td>
                        <td nowrap="nowrap"><%# DataBinder.Eval(Container.DataItem, "Buyer")%></td>
                        <td nowrap="nowrap" style="text-align: center;"><%# DataBinder.Eval(Container.DataItem, "BidNumber") %></td>
                        <td nowrap="nowrap"><%# FormatAmount(DataBinder.Eval(Container.DataItem, "BidAmount").ToString())%></td>
                        <td nowrap="nowrap" style="text-align: right;"><%# FormatCountdown(DataBinder.Eval(Container.DataItem, "DateClose").ToString())%></td>
                    </tr>
                </AlternatingItemTemplate>
            </asp:DataList>

            <div class="MoneyRaised">
                So far a total of $&nbsp;<asp:Literal ID="litTotal" runat="server" EnableViewState="false">0</asp:Literal>&nbsp;has been raised.&nbsp; <b>Well done!</b>
            </div>

        </form>
    </div>
</body>
</html>
