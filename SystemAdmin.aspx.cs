using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;
using System.Windows.Controls;

namespace MESSI
{
    public partial class SystemAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (DropDownList1.SelectedIndex)
            {
                case 0:
                    DropDownList3.Visible = false;
                    DropDownList5.Visible = false;
                    DropDownList6.Visible = false;
                    Label5.Visible = false;
                    Label6.Visible = false;
                    Label7.Visible = false;
                    Label8.Visible = false;
                    Label9.Visible = false;
                    Label10.Visible = false;
                    TextBox3.Visible = false;
                    TextBox4.Visible = false;
                    TextBox5.Visible = false;
                    Label3.Visible = true;
                    TextBox1.Visible = true;
                    Label4.Visible = true;
                    TextBox2.Visible = true;
                    Button1.Visible = true;
                    break;
                case 1:
                    DropDownList5.Visible = false;
                    DropDownList6.Visible = false;
                    Label6.Visible = false;
                    Label7.Visible = false;
                    Label8.Visible = false;
                    Label9.Visible = false;
                    Label10.Visible = false;
                    TextBox3.Visible = false;
                    TextBox4.Visible = false;
                    TextBox5.Visible = false;
                    Label3.Visible = false;
                    TextBox1.Visible = false;
                    Label4.Visible = false;
                    TextBox2.Visible = false;
                    Label5.Visible = true;
                    DropDownList3.Visible = true;
                    Button1.Visible = true;
                    break;
                case 2:
                    DropDownList3.Visible = false;
                    DropDownList5.Visible = false;
                    DropDownList6.Visible = false;
                    Label3.Visible = false;
                    Label4.Visible = false;
                    Label5.Visible = false;
                    Label9.Visible = false;
                    Label10.Visible = false;
                    TextBox1.Visible = false;
                    TextBox2.Visible = false;
                    Label6.Visible = true;
                    Label7.Visible = true;
                    Label8.Visible = true;
                    TextBox3.Visible = true;
                    TextBox4.Visible = true;
                    TextBox5.Visible = true;
                    Button1.Visible = true;
                    break;
                case 3:
                    DropDownList3.Visible = false;
                    DropDownList6.Visible = false;
                    Label3.Visible = false;
                    Label4.Visible = false;
                    Label5.Visible = false;
                    Label10.Visible = false;
                    TextBox1.Visible = false;
                    TextBox2.Visible = false;
                    Label6.Visible = false;
                    Label7.Visible = false;
                    Label8.Visible = false;
                    TextBox3.Visible = false;
                    TextBox4.Visible = false;
                    TextBox5.Visible = false;
                    Label9.Visible = true;
                    DropDownList5.Visible = true;
                    Button1.Visible = true;
                    break;
                case 4:
                    DropDownList3.Visible = false;
                    Label3.Visible = false;
                    Label4.Visible = false;
                    Label5.Visible = false;
                    TextBox1.Visible = false;
                    TextBox2.Visible = false;
                    Label6.Visible = false;
                    Label7.Visible = false;
                    Label8.Visible = false;
                    TextBox3.Visible = false;
                    TextBox4.Visible = false;
                    TextBox5.Visible = false;
                    Label9.Visible = false;
                    DropDownList5.Visible = false;
                    Label10.Visible = true;
                    DropDownList6.Visible = true;
                    Button1.Visible = true;
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
                case 0:
                    if (string.IsNullOrWhiteSpace(TextBox1.Text) || string.IsNullOrWhiteSpace(TextBox2.Text))
                        MessageBox.Show("Please fill all fields", "ERROR", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                    {
                        SqlCommand addC = new SqlCommand("addClub", con);
                        addC.CommandType = System.Data.CommandType.StoredProcedure;
                        addC.Parameters.Add(new SqlParameter("@club_name", TextBox1.Text));
                        addC.Parameters.Add(new SqlParameter("@location", TextBox2.Text));
                        addC.ExecuteNonQuery();
                        Response.Redirect("SystemAdmin.aspx");
                    }
                    break;
                case 1:
                    SqlCommand delC = new SqlCommand("deleteClub", con);
                    delC.CommandType = System.Data.CommandType.StoredProcedure;
                    delC.Parameters.Add(new SqlParameter("@club_name", DropDownList3.SelectedValue));
                    delC.ExecuteNonQuery();
                    Response.Redirect("SystemAdmin.aspx");
                    break;
                case 2:
                    if (string.IsNullOrWhiteSpace(TextBox3.Text) || string.IsNullOrWhiteSpace(TextBox4.Text)
                        || string.IsNullOrWhiteSpace(TextBox5.Text))
                        MessageBox.Show("Please fill all fields", "ERROR", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                    {
                        SqlCommand addS = new SqlCommand("addStadium", con);
                        addS.CommandType = System.Data.CommandType.StoredProcedure;
                        addS.Parameters.Add(new SqlParameter("@stadium_name", TextBox3.Text));
                        addS.Parameters.Add(new SqlParameter("@location", TextBox4.Text));
                        addS.Parameters.Add(new SqlParameter("@capacity", TextBox5.Text));
                        addS.ExecuteNonQuery();
                        Response.Redirect("SystemAdmin.aspx");
                    }
                    break;
                case 3:
                    SqlCommand delS = new SqlCommand("deleteStadium", con);
                    delS.CommandType = System.Data.CommandType.StoredProcedure;
                    delS.Parameters.Add(new SqlParameter("@stadium_name", DropDownList5.SelectedValue));
                    delS.ExecuteNonQuery();
                    Response.Redirect("SystemAdmin.aspx");
                    break;
                case 4:
                    SqlCommand blockFan = new SqlCommand("blockFan", con);
                    blockFan.CommandType = System.Data.CommandType.StoredProcedure;
                    blockFan.Parameters.Add(new SqlParameter("@fan_id", DropDownList6.SelectedValue));
                    blockFan.ExecuteNonQuery();
                    Response.Redirect("SystemAdmin.aspx");
                    break;
            }
            con.Close();
        }
    }
}