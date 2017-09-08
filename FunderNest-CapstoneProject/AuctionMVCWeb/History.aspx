<%@ Page Language="c#" CodeBehind="History.aspx.cs" AutoEventWireup="True" Inherits="AuctionMVCWeb.CharityAuction.History" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Bid History</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="C#">
    <meta name="vs_defaultClientScript" content="JavaScript">
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body bgcolor="#EFEFEF">
    <form id="Form1" method="post" runat="server">
        <h4>Bid History</h4>
        <asp:DataList ID="dlListings" runat="server">
            <HeaderTemplate>
                <table border="0" cellpadding="4" cellspacing="0">
            </HeaderTemplate>
            <FooterTemplate>
                </TABLE>
            </FooterTemplate>
            <ItemTemplate>
                <tr>
                    <td width="150"><%# DataBinder.Eval(Container.DataItem, "item_date_bid") %></td>
                    <td width="80"><b>$
								<%# trimer(DataBinder.Eval(Container.DataItem, "item_amount").ToString()) %>
                    </b>
                    </td>
                    <td><%# DataBinder.Eval(Container.DataItem, "item_bidder") %></td>
                </tr>
            </ItemTemplate>
        </asp:DataList>
        <p>
            <a href="javascript:window.close()">Close</a>
        </p>
    </form>
</body>
</html>
