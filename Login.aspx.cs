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
using System.Windows.Controls;

namespace MESSI
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["FIFA"].ToString();
            SqlConnection con = new SqlConnection(connStr);
            bool e1 = false;
            bool e2 = false;
            bool e3 = false;
            con.Open();
            switch (DropDownList1.SelectedIndex)
            {
                case 0:
                    using (SqlCommand cmd = new SqlCommand("select count(*) from [SystemAdmin] where Username = @username", con))
                    {
                        cmd.Parameters.AddWithValue("Username", username.Text);
                        e1 = (int)cmd.ExecuteScalar() > 0;
                    }
                    using (SqlCommand cmd = new SqlCommand("select count(*) from [SystemUser] where Username = @username and Password = @password", con))
                    {
                        cmd.Parameters.AddWithValue("Username", username.Text);
                        cmd.Parameters.AddWithValue("Password", password.Text);
                        e2 = (int)cmd.ExecuteScalar() > 0;
                    }
                    if (e1 && e2)
                    {
                        Session["username"] = username.Text;
                        Response.Redirect("SystemAdmin.aspx");
                    }
                    else
                        MessageBox.Show("Who are you trying to hack?", "IMPOSTER");
                    break;
                case 1:
                    using (SqlCommand cmd = new SqlCommand("select count(*) from [SportsAssociationManager] where Username = @username", con))
                    {
                        cmd.Parameters.AddWithValue("Username", username.Text);
                        e1 = (int)cmd.ExecuteScalar() > 0;
                    }
                    using (SqlCommand cmd = new SqlCommand("select count(*) from [SystemUser] where Username = @username and Password = @password", con))
                    {
                        cmd.Parameters.AddWithValue("Username", username.Text);
                        cmd.Parameters.AddWithValue("Password", password.Text);
                        e2 = (int)cmd.ExecuteScalar() > 0;
                    }
                    if (e1 && e2)
                    {
                        Session["username"] = username.Text;
                        Response.Redirect("SportsAssociationManager.aspx");

                    }

                    else
                        MessageBox.Show("Who are you trying to hack?", "IMPOSTER");
                    break;
                case 2:
                    using (SqlCommand cmd = new SqlCommand("select count(*) from [ClubRepresentative] where Username = @username", con))
                    {
                        cmd.Parameters.AddWithValue("Username", username.Text);
                        e1 = (int)cmd.ExecuteScalar() > 0;
                    }
                    using (SqlCommand cmd = new SqlCommand("select count(*) from [SystemUser] where Username = @username and Password = @password", con))
                    {
                        cmd.Parameters.AddWithValue("Username", username.Text);
                        cmd.Parameters.AddWithValue("Password", password.Text);
                        e2 = (int)cmd.ExecuteScalar() > 0;
                    }
                    if (e1 && e2)
                    {
                        Session["username"] = username.Text;
                        SqlCommand cmd = new SqlCommand("SELECT C.name FROM ClubRepresentative CR INNER JOIN Club C ON CR.club_id = C.id WHERE CR.username = '" + username.Text+"'", con);
                        SqlDataReader dr = cmd.ExecuteReader();
                        dr.Read();
                        Session["clubname"] = dr[0].ToString();
                        Response.Redirect("ClubRep.aspx");
                       
                    }

                    else
                        MessageBox.Show("Who are you trying to hack?", "IMPOSTER");
                    break;
                case 3:
                    using (SqlCommand cmd = new SqlCommand("select count(*) from [StadiumManager] where Username = @username", con))
                    {
                        cmd.Parameters.AddWithValue("Username", username.Text);
                        e1 = (int)cmd.ExecuteScalar() > 0;
                    }
                    using (SqlCommand cmd = new SqlCommand("select count(*) from [SystemUser] where Username = @username and Password = @password", con))
                    {
                        cmd.Parameters.AddWithValue("Username", username.Text);
                        cmd.Parameters.AddWithValue("Password", password.Text);
                        e2 = (int)cmd.ExecuteScalar() > 0;
                    }
                    if (e1 && e2)
                    {
                        Session["username"] = username.Text;
                        Response.Redirect("StadiumManager.aspx");
                    }

                    else
                        MessageBox.Show("Who are you trying to hack?", "IMPOSTER");
                    break;
                case 4:
                    using (SqlCommand cmd = new SqlCommand("select count(*) from [Fan] where Username = @username", con))
                    {
                        cmd.Parameters.AddWithValue("Username", username.Text);
                        e1 = (int)cmd.ExecuteScalar() > 0;
                    }
                    using (SqlCommand cmd = new SqlCommand("select count(*) from [SystemUser] where Username = @username and Password = @password", con))
                    {
                        cmd.Parameters.AddWithValue("Username", username.Text);
                        cmd.Parameters.AddWithValue("Password", password.Text);
                        e2 = (int)cmd.ExecuteScalar() > 0;
                    }
                    using (SqlCommand cmd = new SqlCommand("select count(*) from [Fan] where Username = @username AND status = '1'", con))
                    {
                        cmd.Parameters.AddWithValue("Username", username.Text);
                        e3 = (int)cmd.ExecuteScalar() > 0;
                    }
                    if (e1 && e2 && e3)
                    {
                        Session["username"] = username.Text;
                        SqlCommand cmd = new SqlCommand("SELECT national_id FROM Fan WHERE username = '" + username.Text + "'", con);
                        SqlDataReader dr = cmd.ExecuteReader();
                        dr.Read();
                        Session["nationalid"] = dr[0].ToString();
                        Response.Redirect("Fan.aspx");
                    }

                    else
                        MessageBox.Show("Wrong username or password or BLOCKED", "IMPOSTER");
                    break;
            }

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}