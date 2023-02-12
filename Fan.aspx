<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fan.aspx.cs" Inherits="MESSI.Fan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; text-align: center;">
            <asp:Label ID="Label1" runat="server" Text="Fan" Font-Bold="True" Font-Size="X-Large"></asp:Label>
        </div>
        <p>
            <asp:Label ID="Label2" runat="server" Text="How can I assist you today?"></asp:Label>
        </p>
        <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
            <asp:ListItem>View all matches that have available tickets</asp:ListItem>
            <asp:ListItem>Purchase a ticket</asp:ListItem>
        </asp:DropDownList>
        <p>
            <asp:Label ID="Label6" runat="server" Text="Please enter a date:"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="TextBox1" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button2" runat="server" Text="View!" OnClick="Button2_Click" />
        </p>
        <p>
            <asp:GridView ID="GridView1" runat="server" Visible="False">
            </asp:GridView>
        </p>
        <p>
            <asp:Label ID="Label3" runat="server" Text="Please select a host club name:" Visible="False"></asp:Label>
        </p>
        <p>
            <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" Visible="False" DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="name">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="availableMatchesToAttendHost" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </p>
        <p>
            <asp:Label ID="Label4" runat="server" Text="Please select a guest club name:" Visible="False"></asp:Label>
        </p>
        <p>
            <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True" Visible="False" DataSourceID="SqlDataSource2" DataTextField="name" DataValueField="name">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="availableMatchesToAttendGuest" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList2" Name="host_name" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
        <p>
            <asp:Label ID="Label5" runat="server" Text="Please select a start time:" Visible="False"></asp:Label>
        </p>
        <p>
            <asp:DropDownList ID="DropDownList4" runat="server" AutoPostBack="True" Visible="False" DataSourceID="SqlDataSource3" DataTextField="start_time" DataValueField="start_time">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="availableMatchesToAttendTime" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList2" Name="host_name" PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="DropDownList3" Name="guest_name" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" Text="Purchase!" onClick="Button1_Click" Visible="False" />
        </p>
    </form>
</body>
</html>
