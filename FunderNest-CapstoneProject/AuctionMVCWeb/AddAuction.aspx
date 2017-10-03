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
                        <a href="/User/Register">Create Account</a>
                    </li>

                </ul>

            </div>
        </div>
    </div>

    <form id="Form1" method="post" runat="server">

        <asp:Literal runat="server" ID="litHeader">
        </asp:Literal>

                    <uc2:Header ID="Header1" runat="server" EnableViewState="false" />
        <h1>Add Donation 
            </h1>

        <table id="Table1" border="0" cellpadding="5" cellspacing="5">
     <TR>	
					<TD>
					</TD>
					<TD style="HEIGHT: 27px">  
                        <h3>Item Name</h3>

						<asp:TextBox id="txtName" runat="server" Width="408px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ControlToValidate="txtName" ErrorMessage="Missing name"></asp:RequiredFieldValidator>
                    </TD>
				</TR>
				<TR>
					<TD>
					</TD>
					<TD>
                                                <h3>Item Description</h3>

						<asp:TextBox id="txtDescription" runat="server" Width="408px" Height="136px" MaxLength="1000"
							TextMode="MultiLine"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                            ControlToValidate="txtDescription" ErrorMessage="Missing description"></asp:RequiredFieldValidator>
                    </TD>
				</TR>
				<TR>
					<TD>
					</TD>

					
				</TR>
				<TR>
					<TD>

					</TD>
					<TD>
                                                                        <h3>Category</h3>

                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource" DataTextField="cat_name" DataValueField="cat_name">
                        </asp:DropDownList>
                                                                        <asp:SqlDataSource ID="SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:auctionConnectionString %>" SelectCommand="SELECT [cat_name] FROM [tbCategories]"></asp:SqlDataSource>
                    </TD>
				</TR>
                <TR>
                    <td>

                    </td> 
                    <td>
                                                                        <h3>Seller Name</h3>

						<asp:TextBox id="txtSeller" runat="server" Width="240px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                            ControlToValidate="txtSeller" ErrorMessage="Missing seller name"></asp:RequiredFieldValidator>
                    </td>
                </TR>
				<TR>
                    <td>
					
					</TD>
					<TD>
                      <h3> Auction close date&nbsp;and time</h3>
						<asp:Calendar id="Calendar1" runat="server" Width="240px" ShowGridLines="True"></asp:Calendar>
						<P>Time (24h)
							<asp:TextBox id="txtTime" runat="server" Width="128px">14:00</asp:TextBox></P>
					</TD>
				</TR>
                <TR>
					<TD>
                        </TD>
					<TD>
                        <h3>Image</h3>

						<asp:FileUpload ID="FileUpload1" runat="server" Width="405px" /><asp:RegularExpressionValidator ID="rexp" runat="server" ControlToValidate="FileUpload1"
     ErrorMessage="Only .gif, .jpg, .png, .tiff and .jpeg" ValidationExpression="(.*\.([Gg][Ii][Ff])|.*\.([Jj][Pp][Gg])|.*\.([Bb][Mm][Pp])|.*\.([pP][nN][gG])|.*\.([tT][iI][iI][fF])$)"></asp:RegularExpressionValidator>
                        <br />
                        Leave blank if no image </TD>
				</TR>
				<TR>
					<TD vAlign="top"></TD>
					<TD align="right">
						&nbsp;</TD>
				</TR>
				<TR>
					<TD vAlign="top">&nbsp;</TD>
					<TD align="right">
						<asp:Button id="Button1" runat="server" Text="Save Auction" onclick="Button1_Click"></asp:Button></TD>
				</TR>
			</TABLE>

    </form>
</body>
</html>
