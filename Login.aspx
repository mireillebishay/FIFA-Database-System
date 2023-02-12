<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MESSI.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            So you&#39;re interested in sports?<br />
            Username<br />
            <asp:TextBox ID="username" runat="server"></asp:TextBox>
            <br />
            Password<br />
            <asp:TextBox ID="password" TextMode="Password" runat="server"></asp:TextBox>
        </div>
        <p>
            <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                <asp:ListItem>System Admin</asp:ListItem>
                <asp:ListItem>Sports Association Manager</asp:ListItem>
                <asp:ListItem>Club Representative</asp:ListItem>
                <asp:ListItem>Stadium Manager</asp:ListItem>
                <asp:ListItem>Fan</asp:ListItem>
            </asp:DropDownList>
        </p>
        <p>
        <asp:Button ID="login1" runat="server" OnClick="login" Text="Login" />
        </p>
        <p>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Register.aspx">I don't have an account</asp:HyperLink>
        </p>
    </form>
</body>
</html>
