<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SportsAssociationManager.aspx.cs" Inherits="MESSI.SportsAssociationManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; text-align: center;">
            <asp:Label ID="Label1" runat="server" Text="Sports Association Manager" Font-Bold="True" Font-Size="X-Large"></asp:Label>
        </div>
        <p>
            <asp:Label ID="Label2" runat="server" Text="How can I assist you today?"></asp:Label>
        </p>
        <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
            <asp:ListItem>Add a Match</asp:ListItem>
            <asp:ListItem>Delete a Match</asp:ListItem>
            <asp:ListItem>View All upcoming matches</asp:ListItem>
            <asp:ListItem>View already played matches</asp:ListItem>
            <asp:ListItem>Clubs never matched</asp:ListItem>
        </asp:DropDownList>
        <p>
            <asp:Label ID="Label3" runat="server" Text="Host club name:"></asp:Label>
        </p>
        <p>
            <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="name">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT DISTINCT [name] FROM [Club]"></asp:SqlDataSource>
        </p>
        <p>
            <asp:Label ID="Label4" runat="server" Text="Guest club name:"></asp:Label>
        </p>
        <p>
            <asp:DropDownList ID="DropDownList6" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource5" DataTextField="name" DataValueField="name">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT DISTINCT [name] FROM [Club] WHERE ([name] &lt;&gt; @name)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList2" Name="name" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>

        <p>
            <asp:Label ID="Label5" runat="server" Text="Start time:"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="TextBox1" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Label6" runat="server" Text="End Time:"></asp:Label>
        <p>
            <asp:TextBox ID="TextBox2" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
        <p>
            <asp:Label ID="Label7" runat="server" Text="Host club name:" Visible="False"></asp:Label>
        <p>
            <asp:DropDownList ID="DropDownList4" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="name" DataValueField="name" Visible="False">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT DISTINCT Club.name FROM Match INNER JOIN Club ON Match.host_club_id = Club.id"></asp:SqlDataSource>
        <p>
            <asp:Label ID="Label8" runat="server" Text="Guest club name:" Visible="False"></asp:Label>
        <p>
            <asp:DropDownList ID="DropDownList5" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="name" DataValueField="name" Visible="False">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT DISTINCT C2.name 
FROM Match M
           INNER JOIN Club C1 ON M.host_club_id = C1.id
           INNER JOIN Club C2 ON M.guest_club_id = C2.id
WHERE M.host_club_id = (
    SELECT id
    FROM Club 
    WHERE name = @host_name
)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList4" Name="host_name" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <p>
                <asp:Label ID="Label9" runat="server" Text="Start time:" Visible="False"></asp:Label>
            <p>
            <asp:DropDownList ID="stime" runat="server" AutoPostBack="True" Visible="False" DataSourceID="SqlDataSource4" DataTextField="start_time" DataValueField="start_time">
            </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT M.start_time
FROM Match M
           INNER JOIN Club C1 ON M.host_club_id = C1.id
           INNER JOIN Club C2 ON M.guest_club_id = C2.id
WHERE C1.name = @host_name AND C2.name = @guest_name
ORDER BY M.start_time">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList4" Name="host_name" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="DropDownList5" Name="guest_name" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
        <p>
            <asp:Label ID="Label10" runat="server" Text="End time:" Visible="False"></asp:Label>
        <p>
            <asp:DropDownList ID="etime" runat="server" AutoPostBack="True" Visible="False" DataSourceID="SqlDataSource6" DataTextField="end_time" DataValueField="end_time">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT M.end_time
FROM Match M
           INNER JOIN Club C1 ON M.host_club_id = C1.id
           INNER JOIN Club C2 ON M.guest_club_id = C2.id
WHERE C1.name = @host_name AND C2.name = @guest_name AND M.start_time = @start_time
ORDER BY M.end_time">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList4" Name="host_name" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownList5" Name="guest_name" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="stime" Name="start_time" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        <p>
            <asp:GridView ID="GridView1" runat="server" Visible="False">
            </asp:GridView>
        <p>
            <asp:Button ID="Button1" runat="server" Text="Submit!" onClick="Button1_Click"/>
    </form>
</body>
</html>
