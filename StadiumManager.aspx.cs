using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace MESSI
{
    public partial class StadiumManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedIndex == 0)
            {
                string connStr = WebConfigurationManager.ConnectionStrings["FIFA"].ToString();
                SqlConnection con = new SqlConnection(connStr);
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT * from dbo.viewMyStadium('" + Session["username"] + "')", con);
                GridView1.DataSource = cmd.ExecuteReader();
                GridView1.DataBind();
                GridView1.Visible = true;
                Label3.Visible = false;
                Label4.Visible = false;
                Label5.Visible = false;
                DropDownList2.Visible = false;
                DropDownList3.Visible = false;
                DropDownList4.Visible = false;
                Button1.Visible = false;
                Button2.Visible = false;
                con.Close();
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
                    SqlCommand cmd = new SqlCommand("SELECT * from dbo.viewMyStadium('" + Session["username"] + "')", con);
                    GridView1.DataSource = cmd.ExecuteReader();
                    GridView1.DataBind();
                    GridView1.Visible = true;
                    Label3.Visible = false;
                    Label4.Visible = false;
                    Label5.Visible = false;
                    DropDownList2.Visible = false;
                    DropDownList3.Visible = false;
                    DropDownList4.Visible = false;
                    Button1.Visible = false;
                    Button2.Visible = false;
                    con.Close();
                    break;
                case 1:
                    SqlCommand cmd1 = new SqlCommand("SELECT * from dbo.allPendingRequests1('" + Session["username"] + "')", con);
                    GridView1.DataSource = cmd1.ExecuteReader();
                    GridView1.DataBind();
                    GridView1.Visible = true;
                    Label3.Visible = false;
                    Label4.Visible = false;
                    Label5.Visible = false;
                    DropDownList2.Visible = false;
                    DropDownList3.Visible = false;
                    DropDownList4.Visible = false;
                    Button1.Visible = false;
                    Button2.Visible = false;
                    con.Close();
                    break;
                case 2:
                    GridView1.Visible = false;
                    Label3.Visible = true;
                    Label4.Visible = true;
                    Label5.Visible = true;
                    DropDownList2.Visible = true;
                    DropDownList3.Visible = true;
                    DropDownList4.Visible = true;
                    Button1.Visible = true;
                    Button2.Visible = true;
                    break;
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrWhiteSpace(DropDownList2.SelectedValue))
                MessageBox.Show("There are no requests to handle", "ERROR", MessageBoxButton.OK, MessageBoxImage.Error);
            else
            {
                string connStr = WebConfigurationManager.ConnectionStrings["FIFA"].ToString();
                SqlConnection con = new SqlConnection(connStr);
                con.Open();
                SqlCommand cmd = new SqlCommand("acceptRequest", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@sm_name", Session["username"]);
                cmd.Parameters.AddWithValue("@host_name", DropDownList2.SelectedValue);
                cmd.Parameters.AddWithValue("@guest_name", DropDownList3.SelectedValue);
                cmd.Parameters.AddWithValue("@start_time", DropDownList4.SelectedValue);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            Response.Redirect("StadiumManager.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrWhiteSpace(DropDownList2.SelectedValue))
                MessageBox.Show("There are no requests to handle", "ERROR", MessageBoxButton.OK, MessageBoxImage.Error);
            else
            {
                string connStr = WebConfigurationManager.ConnectionStrings["FIFA"].ToString();
                SqlConnection con = new SqlConnection(connStr);
                con.Open();
                SqlCommand cmd = new SqlCommand("rejectRequest", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@sm_name", Session["username"]);
                cmd.Parameters.AddWithValue("@host_name", DropDownList2.SelectedValue);
                cmd.Parameters.AddWithValue("@guest_name", DropDownList3.SelectedValue);
                cmd.Parameters.AddWithValue("@start_time", DropDownList4.SelectedValue);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            Response.Redirect("StadiumManager.aspx");
        }

    }
}