<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StadiumManager.aspx.cs" Inherits="MESSI.StadiumManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
         <div style="margin-left: auto; margin-right: auto; text-align: center;">
            <asp:Label ID="Label1" runat="server" Text="Stadium Manager" Font-Bold="True" Font-Size="X-Large"></asp:Label>
        </div>
         <p>
             <asp:Label ID="Label2" runat="server" Text="How can I assist you today?"></asp:Label>
         </p>
         <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
             <asp:ListItem>View my stadium&#39;s info</asp:ListItem>
             <asp:ListItem>View all received requests</asp:ListItem>
             <asp:ListItem>Accept/Reject a request</asp:ListItem>
         </asp:DropDownList>
        <p>
            <asp:GridView ID="GridView1" runat="server"></asp:GridView>
        </p>
         <p>
             <asp:Label ID="Label3" runat="server" Text="Please select a host club name:" Visible="False"></asp:Label>
        </p>
         <p>
             <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="name" Visible="False">
             </asp:DropDownList>
             <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="allPendingRequestsHost2" SelectCommandType="StoredProcedure">
                 <SelectParameters>
                     <asp:SessionParameter Name="sm_name" SessionField="username" Type="String" />
                 </SelectParameters>
             </asp:SqlDataSource>
        </p>
         <p>
             <asp:Label ID="Label4" runat="server" Text="Please select a guest club name:" Visible="False"></asp:Label>
        </p>
         <p>
             <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="name" DataValueField="name" Visible="False">
             </asp:DropDownList>
             <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="allPendingRequestsGuest2" SelectCommandType="StoredProcedure">
                 <SelectParameters>
                     <asp:SessionParameter Name="sm_name" SessionField="username" Type="String" />
                     <asp:ControlParameter ControlID="DropDownList2" Name="host_name" PropertyName="SelectedValue" Type="String" />
                 </SelectParameters>
             </asp:SqlDataSource>
        </p>
         <p>
             <asp:Label ID="Label5" runat="server" Text="Please select a start time:" Visible="False"></asp:Label>
        </p>
         <p>
             <asp:DropDownList ID="DropDownList4" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="start_time" DataValueField="start_time" Visible="False">
             </asp:DropDownList>
             <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=FIFA;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="allPendingRequestsTime2" SelectCommandType="StoredProcedure">
                 <SelectParameters>
                     <asp:SessionParameter Name="sm_name" SessionField="username" Type="String" />
                     <asp:ControlParameter ControlID="DropDownList2" Name="host_name" PropertyName="SelectedValue" Type="String" />
                     <asp:ControlParameter ControlID="DropDownList3" Name="guest_name" PropertyName="SelectedValue" Type="String" />
                 </SelectParameters>
             </asp:SqlDataSource>
        </p>
         <p>
             <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Accept!" Visible="False" />
             <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Reject!" Visible="False" />
        </p>
    </form>
</body>
</html>
