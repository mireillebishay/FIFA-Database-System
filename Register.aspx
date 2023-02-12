<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MESSI.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server" visible="True">
        <asp:Label ID="Label1" runat="server" Text="Who are you?"></asp:Label>
        <br />
        <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
            <asp:ListItem>Sports Association Manager</asp:ListItem>
            <asp:ListItem>Club Representative</asp:ListItem>
            <asp:ListItem>Stadium Manager</asp:ListItem>
            <asp:ListItem>Fan</asp:ListItem>
        </asp:DropDownList>
        <p>
            <asp:Label ID="Label2" runat="server" Text="Full Name:"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="TextBox1" runat="server" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
        </p>
        <asp:Label ID="Label3" runat="server" Text="Username: "></asp:Label>
        <p>
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        </p>
        <asp:Label ID="Label4" runat="server" Text="Password:"></asp:Label>
        <p>
            <asp:TextBox ID="TextBox3" TextMode="Password" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Label5" runat="server" Text="Which club do you represent?" Visible="False"></asp:Label>
        </p>
        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="name" Visible="False" AutoPostBack="True">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT C.name
FROM Club C
WHERE C.id NOT IN (
    SELECT CR.club_id
    FROM ClubRepresentative CR)"></asp:SqlDataSource>
        </p>
        <asp:Label ID="Label6" runat="server" Text="Which stadium do you manage?" Visible="False"></asp:Label>
        <p>
            <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource2" DataTextField="name" DataValueField="name" Visible="False" AutoPostBack="True">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT S.name
FROM Stadium S
WHERE S.id NOT IN (
    SELECT SM.stadium_id
    FROM StadiumManager SM)"></asp:SqlDataSource>
        </p>
            <asp:Label ID="Label7" runat="server" Text="National ID:" Visible="False"></asp:Label>
        <p>
            <asp:TextBox ID="TextBox4" runat="server" Visible="False"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Label8" runat="server" Text="Phone Number:" Visible="False"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="TextBox5" runat="server" Visible="False" TextMode="Phone"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Label9" runat="server" Text="Address:" Visible="False"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="TextBox6" runat="server" Visible="False"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Label10" runat="server" Text="Date of Birth:" Visible="False"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="TextBox7" runat="server" TextMode="Date" Visible="False"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" Text="Sign Up!" onClick="Button1_Click"/>
        </p>
    </form>
</body>
</html>
