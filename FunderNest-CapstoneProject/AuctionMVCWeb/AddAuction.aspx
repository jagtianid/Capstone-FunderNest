<%@ Page Language="c#" CodeBehind="AddAuction.aspx.cs" AutoEventWireup="True" Inherits="AuctionMVCWeb.CharityAuction.AddAuction" %>

<%@ Register Src="Header.ascx" TagName="Header" TagPrefix="uc2" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>

<script language="javascript" type="text/javascript">

</script>

<head>
    <link href="styles/style.css" rel="stylesheet" type="text/css" />
    <link href="Content/css" rel="stylesheet" type="text/css" />
    <link href="bundles/modernizr" rel="stylesheet" type="text/css" />
    <link href="bundles/jquery" rel="stylesheet" type="text/css" />
    <link href="bundles/bootstrap" rel="stylesheet" type="text/css" />

    <style type="text/css">
        td {
            width: 180px;
            margin: inherit;
            padding-right: 360px;
        }

     

        .auto-style1 {
            width: 288px;
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
                        <a href="/Home/IndexLoggedIn">HackerNest</a>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right ">

                    <li>
                        <a href="/User/Logout">Logout</a>
                    </li>
                </ul>


            </div>
        </div>
    </div>

    <form id="Form1" method="post" runat="server">

        <uc2:Header ID="Header1" runat="server" EnableViewState="false" />
        <h1>Add Donation 
        </h1>
        <p>
        </p>
        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</p>

        <table id="Table1" border="0" cellpadding="5" cellspacing="5">

            <tr>
                <td>
                    <br />
                    <br />
                </td>
                <td style="height: 27px">
                    <asp:Literal runat="server" ID="litHeader">
                    </asp:Literal>

                    <asp:Literal runat="server" ID="litHeader2">
                    </asp:Literal>

                    <h3>Item Name</h3>

                    <asp:TextBox ID="txtName1" runat="server" Width="408px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                        ControlToValidate="txtName1" ErrorMessage="Missing name"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <h3>Item Description</h3>

                    <asp:TextBox ID="txtDescription" runat="server" Width="408px" Height="136px" MaxLength="1000"
                        TextMode="MultiLine"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                        ControlToValidate="txtDescription" ErrorMessage="Missing description"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <h3>Category</h3>

                    <asp:DropDownList ID="DropDownList1" runat="server">
                    </asp:DropDownList></td>

            </tr>
            <tr>
                <td></td>
                <td>
                    <h3 class="auto-style1">Seller Name </h3>

                    &nbsp;<asp:Label ID="lbFName" runat="server" Text="First Name"></asp:Label>

                    <asp:Label ID="lbLName" runat="server" Text="Last Name"></asp:Label>

                    <h3 class="auto-style1">Seller Email</h3>
                    <p class="auto-style1">

                        <asp:Label ID="lbEmail" runat="server" Text="Email Address"></asp:Label>

                    </p>

                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <h3>Auction close date&nbsp;and time</h3>
                    <asp:Calendar ID="Calendar1" runat="server" Width="240px" ShowGridLines="True"></asp:Calendar>
                    <p>
                        Time (24h)
							<asp:TextBox ID="txtTime" runat="server" Width="128px">14:00</asp:TextBox>
                    </p>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <h3>Image</h3>

                    <asp:FileUpload ID="FileUpload1" runat="server" Width="405px" /><asp:RegularExpressionValidator ID="rexp" runat="server" ControlToValidate="FileUpload1"
                        ErrorMessage="Only .gif, .jpg, .png, .tiff and .jpeg" ValidationExpression="(.*\.([Gg][Ii][Ff])|.*\.([Jj][Pp][Gg])|.*\.([Bb][Mm][Pp])|.*\.([pP][nN][gG])|.*\.([tT][iI][iI][fF])$)"></asp:RegularExpressionValidator>
                    <br />
                    Leave blank if no image </td>
            </tr>
            <tr>
                <td valign="top"></td>
                <td align="right">&nbsp;</td>
            </tr>
            <tr>
                <td valign="top">&nbsp;</td>
                <td align="right">
                    <asp:Button ID="Button1" runat="server" Text="Save Auction" OnClick="Button1_Click"></asp:Button></td>
            </tr>
        </table>

    </form>
</body>
</html>
