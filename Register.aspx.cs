using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;
using System.Windows.Controls;

namespace MESSI
{
    public partial class Register : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (DropDownList1.SelectedIndex)
            {
                case 0:
                    Label5.Visible = false;
                    DropDownList2.Visible = false;
                    Label6.Visible = false;
                    DropDownList3.Visible = false;
                    Label7.Visible = false;
                    TextBox4.Visible = false;
                    Label8.Visible = false;
                    TextBox5.Visible = false;
                    Label9.Visible = false;
                    TextBox6.Visible = false;
                    Label10.Visible = false;
                    TextBox7.Visible = false;
                    break;
                case 1:
                    Label6.Visible = false;
                    DropDownList3.Visible = false;
                    Label7.Visible = false;
                    TextBox4.Visible = false;
                    Label8.Visible = false;
                    TextBox5.Visible = false;
                    Label9.Visible = false;
                    TextBox6.Visible = false;
                    Label10.Visible = false;
                    TextBox7.Visible = false;
                    Label5.Visible = true;
                    DropDownList2.Visible = true;
                    break;
                case 2:
                    Label5.Visible = false;
                    DropDownList2.Visible = false;
                    Label7.Visible = false;
                    TextBox4.Visible = false ;
                    Label8.Visible = false;
                    TextBox5.Visible = false;
                    Label9.Visible = false;
                    TextBox6.Visible = false;
                    Label10.Visible = false;
                    TextBox7.Visible = false;
                    Label6.Visible = true;
                    DropDownList3.Visible = true;
                    break;
                case 3:
                    Label5.Visible = false;
                    DropDownList2.Visible = false;
                    Label6.Visible = false;
                    DropDownList3.Visible = false;
                    Label7.Visible = true;
                    TextBox4.Visible = true;
                    Label8.Visible = true;
                    TextBox5.Visible = true;
                    Label9.Visible = true;
                    TextBox6.Visible = true;
                    Label10.Visible = true;
                    TextBox7.Visible = true;
                    break;
            }
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            switch (DropDownList1.SelectedIndex)
            {
                case 0:
                    if (string.IsNullOrWhiteSpace(TextBox1.Text) || string.IsNullOrWhiteSpace(TextBox2.Text)
                    || string.IsNullOrWhiteSpace(TextBox3.Text))
                        MessageBox.Show("Please fill all fields", "ERROR", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                    {
                        string connStr = WebConfigurationManager.ConnectionStrings["FIFA"].ToString();
                        SqlConnection con = new SqlConnection(connStr);
                        bool exists = false;
                        con.Open();
                        using (SqlCommand cmd = new SqlCommand("select count(*) from [SystemUser] where Username = @username", con))
                        {
                            cmd.Parameters.AddWithValue("Username", TextBox2.Text);
                            exists = (int)cmd.ExecuteScalar() > 0;
                        }
                        if (exists)
                        {
                            MessageBox.Show("Please choose a different username", "COPYCAT", MessageBoxButton.OK, MessageBoxImage.Error);
                        }
                        else
                        {
                            SqlCommand add_am = new SqlCommand("addAssociationManager", con);
                            add_am.CommandType = System.Data.CommandType.StoredProcedure;
                            add_am.Parameters.Add(new SqlParameter("@name", TextBox1.Text));
                            add_am.Parameters.Add(new SqlParameter("@username", TextBox2.Text));
                            add_am.Parameters.Add(new SqlParameter("@password", TextBox3.Text));
                            add_am.ExecuteNonQuery();
                            con.Close();
                            Response.Redirect("Login.aspx");
                        }
                    }
                    break;
                case 1:
                    if (string.IsNullOrWhiteSpace(TextBox1.Text) || string.IsNullOrWhiteSpace(TextBox2.Text)
                    || string.IsNullOrWhiteSpace(TextBox3.Text))
                        MessageBox.Show("Please fill all fields", "ERROR", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                    {
                        string connStr = WebConfigurationManager.ConnectionStrings["FIFA"].ToString();
                        SqlConnection con = new SqlConnection(connStr);
                        bool exists = false;
                        con.Open();
                        using (SqlCommand cmd = new SqlCommand("select count(*) from [SystemUser] where Username = @username", con))
                        {
                            cmd.Parameters.AddWithValue("Username", TextBox2.Text);
                            exists = (int)cmd.ExecuteScalar() > 0;
                        }
                        if (exists)
                        {
                            MessageBox.Show("Please choose a different username", "COPYCAT", MessageBoxButton.OK, MessageBoxImage.Error);
                        }
                        else
                        {
                            SqlCommand add_representative = new SqlCommand("addRepresentative", con);
                            add_representative.CommandType = System.Data.CommandType.StoredProcedure;
                            add_representative.Parameters.Add(new SqlParameter("@name", TextBox1.Text));
                            add_representative.Parameters.Add(new SqlParameter("@club_name", DropDownList2.SelectedItem.Text));
                            add_representative.Parameters.Add(new SqlParameter("@username", TextBox2.Text));
                            add_representative.Parameters.Add(new SqlParameter("@password", TextBox3.Text));
                            add_representative.ExecuteNonQuery();
                            con.Close();
                            Response.Redirect("Login.aspx");
                        }
                    }
                    break;
                case 2:
                    if (string.IsNullOrWhiteSpace(TextBox1.Text) || string.IsNullOrWhiteSpace(TextBox2.Text)
                    || string.IsNullOrWhiteSpace(TextBox3.Text))
                        MessageBox.Show("Please fill all fields", "ERROR", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                    {
                        string connStr = WebConfigurationManager.ConnectionStrings["FIFA"].ToString();
                        SqlConnection con = new SqlConnection(connStr);
                        bool exists = false;
                        con.Open();
                        using (SqlCommand cmd = new SqlCommand("select count(*) from [SystemUser] where Username = @username", con))
                        {
                            cmd.Parameters.AddWithValue("Username", TextBox2.Text);
                            exists = (int)cmd.ExecuteScalar() > 0;
                        }
                        if (exists)
                        {
                            MessageBox.Show("Please choose a different username", "COPYCAT", MessageBoxButton.OK, MessageBoxImage.Error);
                        }
                        else
                        {
                            SqlCommand add_sm = new SqlCommand("addStadiumManager", con);
                            add_sm.CommandType = System.Data.CommandType.StoredProcedure;
                            add_sm.Parameters.Add(new SqlParameter("@stadium_manager_name", TextBox1.Text));
                            add_sm.Parameters.Add(new SqlParameter("@stadium_name", DropDownList3.SelectedItem.Text));
                            add_sm.Parameters.Add(new SqlParameter("@username", TextBox2.Text));
                            add_sm.Parameters.Add(new SqlParameter("@password", TextBox3.Text));
                            add_sm.ExecuteNonQuery();
                            con.Close();
                            Response.Redirect("Login.aspx");
                        }
                    }
                    break;
                case 3:
                    if (string.IsNullOrWhiteSpace(TextBox1.Text) 
                        || string.IsNullOrWhiteSpace(TextBox2.Text) 
                        || string.IsNullOrWhiteSpace(TextBox3.Text) 
                        || string.IsNullOrWhiteSpace(TextBox4.Text) 
                        || string.IsNullOrWhiteSpace(TextBox5.Text)
                        || string.IsNullOrWhiteSpace(TextBox6.Text))
                        MessageBox.Show("Please fill all fields", "ERROR", MessageBoxButton.OK, MessageBoxImage.Error);
                    else
                    {
                        string connStr = WebConfigurationManager.ConnectionStrings["FIFA"].ToString();
                        SqlConnection con = new SqlConnection(connStr);
                        bool e1 = false;
                        bool e2 = false;
                        int parsedValue;
                        con.Open();
                        using (SqlCommand cmd = new SqlCommand("select count(*) from [SystemUser] where Username = @username", con))
                        {
                            cmd.Parameters.AddWithValue("Username", TextBox2.Text);
                            e1 = (int)cmd.ExecuteScalar() > 0;
                        }
                        using (SqlCommand cmd = new SqlCommand("select count(*) from [Fan] where national_id = @national_id", con))
                        {
                            cmd.Parameters.AddWithValue("national_id", TextBox4.Text);
                            e2 = (int)cmd.ExecuteScalar() > 0;
                        }
                        if (e1)
                            MessageBox.Show("Please choose a different username", "COPYCAT", MessageBoxButton.OK, MessageBoxImage.Error);
                        else if(e2)
                            MessageBox.Show("Please enter your real national id", "LIAR", MessageBoxButton.OK, MessageBoxImage.Error);
                        else if(!int.TryParse(TextBox5.Text, out parsedValue))
                        
                            MessageBox.Show("This is a number only field", "Phone Number", MessageBoxButton.OK, MessageBoxImage.Error);
                        else
                        {
                            SqlCommand add_fan = new SqlCommand("addFan", con);
                            add_fan.CommandType = System.Data.CommandType.StoredProcedure;
                            add_fan.Parameters.Add(new SqlParameter("@name", TextBox1.Text));
                            add_fan.Parameters.Add(new SqlParameter("@username", TextBox2.Text));
                            add_fan.Parameters.Add(new SqlParameter("@password", TextBox3.Text));
                            add_fan.Parameters.Add(new SqlParameter("@national_id", TextBox4.Text));
                            add_fan.Parameters.Add(new SqlParameter("@birth_date", DateTime.Parse(TextBox7.Text)));
                            add_fan.Parameters.Add(new SqlParameter("@address", TextBox6.Text));
                            add_fan.Parameters.Add(new SqlParameter("@phone_num", TextBox5.Text));
                            add_fan.ExecuteNonQuery();
                            con.Close();
                            Response.Redirect("Login.aspx");
                        }
                    }
                    break;
            }
        }

    }
}