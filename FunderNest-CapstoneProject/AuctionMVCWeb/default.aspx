<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="AuctionMVCWeb._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" name="form1" runat="server">
        <asp:PlaceHolder ID="phForm" runat="server">
            <div id="formLayout">
                <fieldset>
                    <legend>Register to Donate:</legend>
                    <div class="row">
                        <label for="FirstName">First Name:</label>
                        <asp:TextBox ID="fnameTB" runat="server" />
                    </div>
                    <div class="row">
                        <label for="LastName">Last Name:</label>
                        <asp:TextBox ID="lnameTB" runat="server" />
                    </div>
                    <div class="row">
                        <label for="Email">E-mail:</label>
                        <asp:TextBox ID="emailTB" runat="server" />
                    </div>
                    <div class="row">
                        <label for="Password">Password:</label>
                        <asp:TextBox ID="passwordTB" runat="server" TextMode="Password" />
                    </div>
                </fieldset>
                <div class="row">
                    <div class="buttoncontainer">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="buttons" />
                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="buttons" OnClientClick="clear_Fields();" />
                    </div>
                </div>
            </div>
        </asp:PlaceHolder>
        <asp:PlaceHolder ID="phSuccess" runat="server" Visible="false">
            <div id="success">
                <p>Thank you for your registration!</p>
                <p><a href="Default.aspx">Need to register again?</a></p>
            </div>
        </asp:PlaceHolder>
        <asp:PlaceHolder ID="phFailure" runat="server" Visible="false">
            <p>Sorry, you have done wrong, please try again.</p>
        </asp:PlaceHolder>
    </form>
</body>
</html>
