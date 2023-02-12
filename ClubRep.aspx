<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClubRep.aspx.cs" Inherits="MESSI.ClubRep" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; text-align: center;">
            <asp:Label ID="Label1" runat="server" Text="Club Representative" Font-Bold="True" Font-Size="X-Large"></asp:Label>
        </div>
        <p>
            <asp:Label ID="Label2" runat="server" Text="How can I assist you today?"></asp:Label>
        </p>
            <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
                <asp:ListItem>View my club&#39;s info</asp:ListItem>
                <asp:ListItem>View all upcoming matches</asp:ListItem> 
                <asp:ListItem>View all available stadiums</asp:ListItem>
                <asp:ListItem>Send a request to a stadium manager</asp:ListItem>
            </asp:DropDownList>
        <p>
            <asp:Label ID="Label3" runat="server" Text="Please select a stadium:" Visible="False"></asp:Label>
        </p>
            <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="name" Visible="False">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [name] FROM [Stadium]"></asp:SqlDataSource>
        <p>
            <asp:Label ID="Label4" runat="server" Text="Please select a date:" Visible="False"></asp:Label>
            <p>
                <asp:TextBox ID="TextBox1" runat="server" TextMode="DateTimeLocal" Visible="False"></asp:TextBox>
        </p>
        <p>
            <asp:GridView ID="GridView1" runat="server">
            </asp:GridView>
        </p>
        <p>
            <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="start_time" DataValueField="start_time" Visible="False">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Match.start_time FROM Club INNER JOIN Match ON Club.id = Match.host_club_id AND Club.name = @clubname">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="" Name="clubname" SessionField="clubname" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit!" Visible="False" />
        </p>
            </form>
</body>
</html>
