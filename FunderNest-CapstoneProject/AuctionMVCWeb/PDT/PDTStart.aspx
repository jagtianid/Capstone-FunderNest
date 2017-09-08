<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PDTStart.aspx.cs" Inherits="AuctionMVCWeb.PDT.PDTStart" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
 <form action="https://www.paypal.com/cgi-bin/webscr" method="post">
 <input type="hidden" name="cmd" value="_xclick">
 <input type="hidden" name="business" value="jhita@rocketmail.com">
 <input type="hidden" name="lc" value="US">
 <input type="hidden" name="item_name" value="Drugs">
 <input type="hidden" name="amount" value= "12.00">
 <input type="hidden" name="currency_code" value="CAD">
 <input type="hidden" name="button_subtype" value="products">
 <input type="hidden" name="bn" value="PP-BuyNowBF:btn_buynowCC_LG.gif:NonHosted">
 <input type="image" src="https://www.paypal.com/en_US/i/btn/btn_buynowCC_LG.gif"
 border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
 <img alt="" border="0" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
 </form> 
</body>
</html>

