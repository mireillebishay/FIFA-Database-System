using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace MESSI
{
    public partial class Fan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (DropDownList1.SelectedIndex)
            {
                case 0:
                    Label3.Visible = false;
                    Label4.Visible = false;
                    Label5.Visible = false;
                    DropDownList2.Visible = false;
                    DropDownList3.Visible = false;
                    DropDownList4.Visible = false;
                    Button1.Visible = false;
                    GridView1.Visible = false;
                    Label6.Visible = true;
                    Button2.Visible = true;
                    TextBox1.Visible = true;
                    break;
                case 1:
                    GridView1.Visible = false;
                    Label6.Visible = false;
                    Button2.Visible = false;
                    TextBox1.Visible = false;
                    Label3.Visible = true;
                    Label4.Visible = true;
                    Label5.Visible = true;
                    DropDownList2.Visible = true;
                    DropDownList3.Visible = true;
                    DropDownList4.Visible = true;
                    Button1.Visible = true;
                    break;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrWhiteSpace(DropDownList2.SelectedValue))
                MessageBox.Show("There are no tickets to buy", "ERROR", MessageBoxButton.OK, MessageBoxImage.Error);
            else
            {
                string connStr = WebConfigurationManager.ConnectionStrings["FIFA"].ToString();
                SqlConnection con = new SqlConnection(connStr);
                con.Open();
                SqlCommand cmd = new SqlCommand("purchaseTicket", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@national_id", Session["nationalid"]);
                cmd.Parameters.AddWithValue("@host_name", DropDownList2.SelectedValue);
                cmd.Parameters.AddWithValue("@guest_name", DropDownList3.SelectedValue);
                cmd.Parameters.AddWithValue("@start_time", DropDownList4.SelectedValue);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            Response.Redirect("Fan.aspx");

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["FIFA"].ToString();
            SqlConnection con = new SqlConnection(connStr);
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT * from dbo.availableMatchesToAttend1('" + DateTime.Parse(TextBox1.Text) + "')", con);
            GridView1.DataSource = cmd.ExecuteReader();
            GridView1.DataBind();
            Label3.Visible = false;
            Label4.Visible = false;
            Label5.Visible = false;
            DropDownList2.Visible = false;
            DropDownList3.Visible = false;
            DropDownList4.Visible = false;
            Button1.Visible = false;
            Label6.Visible = false;
            Button2.Visible = false;
            TextBox1.Visible = false;
            GridView1.Visible = true;
        }
    }
}