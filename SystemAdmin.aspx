<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SystemAdmin.aspx.cs" Inherits="MESSI.SystemAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; text-align: center;">
            <asp:Label ID="Label1" runat="server" Text="System Admin" Font-Bold="True" Font-Size="X-Large"></asp:Label>
        </div>
        <asp:Label ID="Label2" runat="server" Text="How can I assist you today?"></asp:Label>
        <p>
        <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
            <asp:ListItem>Add a Club</asp:ListItem>
            <asp:ListItem>Delete a Club</asp:ListItem>
            <asp:ListItem>Add a Stadium</asp:ListItem>
            <asp:ListItem>Delete a Stadium</asp:ListItem>
            <asp:ListItem>Block a Fan</asp:ListItem>
        </asp:DropDownList>
        <p>
            <asp:Label ID="Label3" runat="server" Text="Club Name:"></asp:Label>
        </p>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <p>
            <asp:Label ID="Label4" runat="server" Text="Club Location:"></asp:Label>
        </p>
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        <p>
        <asp:Label ID="Label5" runat="server" Text="Please select the club" Visible="False"></asp:Label>
        <p>
        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="name" Visible="False" AutoPostBack="True">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [name] FROM [Club]"></asp:SqlDataSource>
        <asp:Label ID="Label6" runat="server" Text="Stadium Name:" Visible="False"></asp:Label>
        <p>
        <p>
            <asp:TextBox ID="TextBox3" runat="server" Visible="False"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Label7" runat="server" Text="Stadium's Location:" Visible="False"></asp:Label>
        </p>
        <asp:TextBox ID="TextBox4" runat="server" Visible="False"></asp:TextBox>
        <p>
            <asp:Label ID="Label8" runat="server" Text="Stadium's Capacity:" Visible="False"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="TextBox5" runat="server" Visible="False"></asp:TextBox>
        </p>
        <asp:Label ID="Label9" runat="server" Text="Please select the stadium" Visible="False"></asp:Label>
        <p>
        <asp:DropDownList ID="DropDownList5" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="name" DataValueField="name" Visible="False">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [name] FROM [Stadium]"></asp:SqlDataSource>
        <p>
        <asp:Label ID="Label10" runat="server" Text="Please select the fan's National ID" Visible="False"></asp:Label>
        <p>
        <asp:DropDownList ID="DropDownList6" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="national_id" DataValueField="national_id" Visible="False">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [national_id] FROM [Fan]"></asp:SqlDataSource>
        <p>
        <asp:Button ID="Button1" runat="server" Text="Submit!" onClick="Button1_Click" />
    </form>
</body>
</html>
