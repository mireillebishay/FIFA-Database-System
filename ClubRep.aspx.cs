using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MESSI
{
    public partial class ClubRep : System.Web.UI.Page
    {
  
        protected void Page_Load(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedIndex == 0)
            {
                string connStr = WebConfigurationManager.ConnectionStrings["FIFA"].ToString();
                SqlConnection con = new SqlConnection(connStr);
                SqlCommand cmd = new SqlCommand("SELECT C.* FROM ClubRepresentative CR INNER JOIN Club C ON CR.club_id = C.id WHERE CR.username = @username", con);
                cmd.Parameters.AddWithValue("@username", Convert.ToString(Session["username"]));
                con.Open();
                GridView1.DataSource = cmd.ExecuteReader();
                GridView1.DataBind();
                con.Close();
                GridView1.Visible = true;
            }
            
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["FIFA"].ToString();
            SqlConnection con = new SqlConnection(connStr);
            con.Open();
            switch (DropDownList1.SelectedIndex)
            {
                case 0:
                    SqlCommand cmd = new SqlCommand("SELECT C.* FROM ClubRepresentative CR INNER JOIN Club C ON CR.club_id = C.id WHERE CR.username = @username", con);
                    cmd.Parameters.AddWithValue("@username", Convert.ToString(Session["username"]));
                    GridView1.DataSource = cmd.ExecuteReader();
                    GridView1.DataBind();
                    con.Close();
                    Label3.Visible = false;
                    DropDownList2.Visible = false;
                    Label4.Visible = false;
                    TextBox1.Visible = false;
                    GridView1.Visible = true;
                    Button1.Visible = false;
                    DropDownList3.Visible = false;
                    break;
                case 1:
                    SqlCommand cmd1 = new SqlCommand("SELECT * from dbo.upcomingMatchesOfClub('" + Session["clubname"] + "')", con);
                    GridView1.DataSource = cmd1.ExecuteReader();
                    GridView1.DataBind();
                    con.Close();
                    Label3.Visible = false;
                    DropDownList2.Visible = false;
                    Label4.Visible = false;
                    TextBox1.Visible = false;
                    GridView1.Visible = true;
                    Button1.Visible = false;
                    DropDownList3.Visible = false;
                    break;
                case 2:
                    Label3.Visible = false;
                    DropDownList2.Visible = false;
                    Label4.Visible = true;
                    TextBox1.Visible = true;
                    GridView1.Visible = false;
                    Button1.Visible = true;
                    DropDownList3.Visible = false;
                    break;
                case 3:
                    Label3.Visible = true;
                    DropDownList2.Visible = true;
                    Label4.Visible = true;
                    TextBox1.Visible = false;
                    GridView1.Visible = false;
                    Button1.Visible = true;
                    DropDownList3.Visible = true;
                    break;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["FIFA"].ToString();
            SqlConnection con = new SqlConnection(connStr);
            con.Open();
            switch (DropDownList1.SelectedIndex)
            {
                case 2:
                    SqlCommand cmd2 = new SqlCommand("SELECT * from dbo.viewAvailableStadiumsOn('" + DateTime.Parse(TextBox1.Text) + "')", con);
                    GridView1.DataSource = cmd2.ExecuteReader();
                    GridView1.DataBind();
                    con.Close();
                    Label3.Visible = false;
                    DropDownList2.Visible = false;
                    Label4.Visible = false;
                    TextBox1.Visible = false;
                    GridView1.Visible = true;
                    Button1.Visible = false;
                    break;
                case 3:
                    SqlCommand cmd3 = new SqlCommand("addHostRequest", con);
                    cmd3.CommandType = CommandType.StoredProcedure;
                    cmd3.Parameters.AddWithValue("@club_name", Session["clubname"]);
                    cmd3.Parameters.AddWithValue("@stadium_name", DropDownList2.SelectedValue);
                    cmd3.Parameters.AddWithValue("@start_time", DropDownList3.SelectedValue);
                    cmd3.ExecuteNonQuery();
                    con.Close();
                    Label3.Visible = false;
                    DropDownList2.Visible = false;
                    Label4.Visible = false;
                    TextBox1.Visible = false;
                    GridView1.Visible = false;
                    Button1.Visible = false;
                    Response.Redirect("ClubRep.aspx");
                    break;
            }
            
            
        }
    }
}