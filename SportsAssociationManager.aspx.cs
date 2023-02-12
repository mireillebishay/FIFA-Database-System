using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;
using System.Windows.Controls;
using static System.Net.Mime.MediaTypeNames;

namespace MESSI
{

    public partial class SportsAssociationManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String s = Environment.UserName;
            Console.Write(s);
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["FIFA"].ToString();
            SqlConnection con = new SqlConnection(connStr);
            switch (DropDownList1.SelectedIndex)
            {
                case 0:
                    Label7.Visible = false;
                    Label8.Visible = false;
                    Label9.Visible = false;
                    Label10.Visible = false;
                    DropDownList4.Visible = false;
                    DropDownList5.Visible = false;
                    stime.Visible = false;
                    etime.Visible = false;
                    GridView1.Visible = false;
                    Label3.Visible = true;
                    DropDownList2.Visible = true;
                    Label4.Visible = true;
                    DropDownList6.Visible = true;
                    Label5.Visible = true;
                    Label6.Visible = true;
                    TextBox1.Visible = true;
                    TextBox2.Visible = true;
                    Button1.Visible = true;
                    break;
                case 1:
                    DropDownList2.Visible = false;
                    DropDownList6.Visible = false;
                    TextBox1.Visible = false;
                    TextBox2.Visible = false;
                    Label3.Visible = false;
                    Label4.Visible = false;
                    Label5.Visible = false;
                    Label6.Visible = false;
                    GridView1.Visible = false;
                    DropDownList4.Visible = true;
                    DropDownList5.Visible = true;
                    stime.Visible = true;
                    etime.Visible = true;
                    Label7.Visible = true;
                    Label8.Visible = true;
                    Label9.Visible = true;
                    Label10.Visible = true;
                    Button1.Visible = true;

                    break;
                case 2:
                    DropDownList2.Visible = false;
                    DropDownList6.Visible = false;
                    TextBox1.Visible = false;
                    TextBox2.Visible = false;
                    Label3.Visible = false;
                    Label4.Visible = false;
                    Label5.Visible = false;
                    Label6.Visible = false;
                    DropDownList4.Visible = false;
                    DropDownList5.Visible = false;
                    stime.Visible = false;
                    etime.Visible = false;
                    Label7.Visible = false;
                    Label8.Visible = false;
                    Label9.Visible = false;
                    Label10.Visible = false;
                    Button1.Visible = false;
                    SqlCommand cmd = new SqlCommand("SELECT * FROM allUpcomingMatches", con);
                    con.Open();
                    GridView1.DataSource = cmd.ExecuteReader();
                    GridView1.DataBind();
                    con.Close();
                    GridView1.Visible = true;
                    break;
                case 3:
                    DropDownList2.Visible = false;
                    DropDownList6.Visible = false;
                    TextBox1.Visible = false;
                    TextBox2.Visible = false;
                    Label3.Visible = false;
                    Label4.Visible = false;
                    Label5.Visible = false;
                    Label6.Visible = false;
                    DropDownList4.Visible = false;
                    DropDownList5.Visible = false;
                    stime.Visible = false;
                    etime.Visible = false;
                    Label7.Visible = false;
                    Label8.Visible = false;
                    Label9.Visible = false;
                    Label10.Visible = false;
                    Button1.Visible = false;
                    SqlCommand cmd1 = new SqlCommand("SELECT * FROM allAlreadyPlayedMatches", con);
                    con.Open();
                    GridView1.DataSource = cmd1.ExecuteReader();
                    GridView1.DataBind();
                    con.Close();
                    GridView1.Visible = true;
                    break;
                case 4:
                    DropDownList2.Visible = false;
                    DropDownList6.Visible = false;
                    TextBox1.Visible = false;
                    TextBox2.Visible = false;
                    Label3.Visible = false;
                    Label4.Visible = false;
                    Label5.Visible = false;
                    Label6.Visible = false;
                    DropDownList4.Visible = false;
                    DropDownList5.Visible = false;
                    stime.Visible = false;
                    etime.Visible = false;
                    Label7.Visible = false;
                    Label8.Visible = false;
                    Label9.Visible = false;
                    Label10.Visible = false;
                    Button1.Visible = false;
                    SqlCommand cmd2 = new SqlCommand("SELECT * FROM clubsNeverMatched", con);
                    con.Open();
                    GridView1.DataSource = cmd2.ExecuteReader();
                    GridView1.DataBind();
                    con.Close();
                    GridView1.Visible = true;
                    break;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["FIFA"].ToString();
            SqlConnection con = new SqlConnection(connStr);
            switch (DropDownList1.SelectedIndex)
            {
                case 0:
                    if (DateTime.Parse(TextBox2.Text) <= DateTime.Parse(TextBox1.Text))
                        MessageBox.Show("Please enter a valid end time", "ERROR", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                    {
                        SqlCommand cmd = new SqlCommand("addNewMatch", con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@host_club", DropDownList2.SelectedValue));
                        cmd.Parameters.Add(new SqlParameter("@guest_club", DropDownList6.SelectedValue));
                        cmd.Parameters.Add(new SqlParameter("@start_time", DateTime.Parse(TextBox1.Text)));
                        cmd.Parameters.Add(new SqlParameter("@end_time", DateTime.Parse(TextBox2.Text)));
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        Response.Redirect("SportsAssociationManager.aspx");
                    }
                    break;
                case 1:
                    SqlCommand cmd1 = new SqlCommand("deleteMatch", con);
                    cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd1.Parameters.Add(new SqlParameter("@host_club", DropDownList4.SelectedValue));
                    cmd1.Parameters.Add(new SqlParameter("@guest_club", DropDownList5.SelectedValue));
                    cmd1.Parameters.Add(new SqlParameter("@start_time", stime.SelectedValue));
                    cmd1.Parameters.Add(new SqlParameter("@end_time", etime.SelectedValue));
                    con.Open();
                    cmd1.ExecuteNonQuery();
                    con.Close();
                    Response.Redirect("SportsAssociationManager.aspx");
                    break;
            }
            {

            }
        }
    }
}