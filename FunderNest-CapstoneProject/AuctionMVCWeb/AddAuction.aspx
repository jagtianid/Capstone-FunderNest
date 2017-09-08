<%@ Page Language="c#" CodeBehind="AddAuction.aspx.cs" AutoEventWireup="True" Inherits="AuctionMVCWeb.CharityAuction.AddAuction" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<h1>Add Donation </h1>

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
            margin: auto;
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

    <form id="Form1" method="post" runat="server">

        <asp:Literal runat="server" ID="litHeader">
        </asp:Literal>

        <table id="Table1" cellspacing="5" cellpadding="5" border="0">
            <tr>
                <td></td>
                <td>
                    <h3>Item Name</h3>
                    <asp:TextBox ID="txtName" runat="server" Width="240px" Height="30px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                        ControlToValidate="txtName" ErrorMessage="Missing name"></asp:RequiredFieldValidator>
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

                <td>
                    <h3>Item Location</h3>

                    <asp:TextBox ID="txtLocation" runat="server" Width="240px" Height="30px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                        ControlToValidate="txtLocation" ErrorMessage="Missing location"></asp:RequiredFieldValidator>
                </td>

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
                    <h3>Seller Name</h3>

                    <asp:TextBox ID="txtSeller" runat="server" Width="240px" Height="30px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                        ControlToValidate="txtSeller" ErrorMessage="Missing seller name"></asp:RequiredFieldValidator>
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

                    <asp:FileUpload ID="FileUpload1" runat="server" Width="405px" Height="30px" /><asp:RegularExpressionValidator ID="rexp" runat="server" ControlToValidate="FileUpload1"
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
