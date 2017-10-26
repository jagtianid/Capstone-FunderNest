<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EndedBids.aspx.cs" Inherits="AuctionMVCWeb.EndedBids" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

    <title>FunderNest</title>
    <link href="styles/style.css" rel="stylesheet" type="text/css" />
    <link href="Content/css" rel="stylesheet" type="text/css" />
    <link href="bundles/modernizr" rel="stylesheet" type="text/css" />
    <link href="bundles/jquery" rel="stylesheet" type="text/css" />
    <link href="bundles/bootstrap" rel="stylesheet" type="text/css" />

    <style type="text/css">
        h2 {
            font-family: 'AR JULIAN';
            font-size: 26pt;
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

                    <li>
                        <a href="/User/Login">Log In</a>
                    </li>

                    <li>
                        <a href="/User/Register">Create Account</a>
                    </li>

                </ul>

            </div>
        </div>
    </div>

    <div class="PageLayout">
        <table class="AuctionList">
            <tr class="ThemeColor" style="height: 35px;">
                <td>
                    <h2>Ended Bids </h2>
                </td>
            </tr>
            </table>
            <form id="Form1" method="post" runat="server">

                <div class="SubHeading">
                    <asp:Literal ID="litHeading" runat="server" EnableViewState="false" />
                </div>

                <asp:DataList ID="dlEndedListings" runat="server" BorderStyle="None"
                    BorderWidth="0px" EnableViewState="False" RepeatLayout="Table">
                    <HeaderTemplate>
                        <table class="AuctionList">
                            <tr class="ThemeColor" style="height: 35px;">
                                <td nowrap="nowrap"><a href="EndedBids.aspx?s=Name"><b>Item</b></a></td>
                                <td nowrap="nowrap"><a href="EndedBids.aspx?s=Buyer"><b>Winning&nbsp;Bidder</b></a></td>
                                <td nowrap="nowrap" width="80" style="text-align: center;"><a href="EndedBids.aspx?s=BidNumber"><b>Bids</b></a></td>
                                <td nowrap="nowrap" width="80"><a href="EndedBids.aspx?s=BidAmount"><b>Price</b></a></td>
                                <td nowrap="nowrap" width="100"><a href="EndedBids.aspx?s=DateClose"><b>Time Left</b></a></td>
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
                            <td nowrap="nowrap"><%# DataBinder.Eval(Container.DataItem, "Buyer")%></td>
                            <td nowrap="nowrap" style="text-align: center;"><%# DataBinder.Eval(Container.DataItem, "BidNumber") %></td>
                            <td nowrap="nowrap"><%# FormatAmount(DataBinder.Eval(Container.DataItem, "BidAmount").ToString())%></td>
                            <td nowrap="nowrap" style="text-align: right;"><%# FormatCountdown(DataBinder.Eval(Container.DataItem, "DateClose").ToString())%></td>
                        </tr>
                    </AlternatingItemTemplate>
                </asp:DataList>

            </form>
    </div>
</body>
</html>
