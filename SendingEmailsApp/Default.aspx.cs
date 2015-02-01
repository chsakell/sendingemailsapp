using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SendingEmailsApp
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // Without Database approach
        /*protected void btnSend_Click(object sender, EventArgs e)
        {
            string messageForm = HttpContext.Current.Server.MapPath("~/App_Data/MessageForm.txt");
            string messageToSend = File.ReadAllText(messageForm);
            messageToSend = messageToSend.Replace("@@name@@", txtName.Text);
            messageToSend = messageToSend.Replace("@@lastName@@", txtLastName.Text);
            messageToSend = messageToSend.Replace("@@message@@", txtMessage.Text);
            messageToSend = messageToSend.Replace("@@loginLink@@", "http://socialnetwork?login=" + txtLastName.Text);

            MailMessage myMessage = new MailMessage();
            myMessage.Subject = "SocialNetwork account activation";
            myMessage.Body = messageToSend;
            myMessage.From = new MailAddress("PUT_YOUR_USERNAME_HERE@gmail.com", "SocialNetwork");
            myMessage.To.Add(new MailAddress(txtEmail.Text, txtName.Text +  " " + txtLastName.Text));
            SmtpClient mySmtpClient = new SmtpClient();
            mySmtpClient.Send(myMessage);
        }*/

        // Using database. Threads are responsible for sending Emails..
        // Place threads in different project for better management.
        protected void btnSend_Click(object sender, EventArgs e)
        {
            string messageForm = HttpContext.Current.Server.MapPath("~/App_Data/MessageForm.txt");
            string messageToSend = File.ReadAllText(messageForm);

            SqlConnection conn = new SqlConnection("Data Source=localhost;Initial Catalog=EmailsDB;Integrated Security=SSPI;");
            SqlCommand cmd = new SqlCommand("SendEmail",conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@EmailAddress", txtEmail.Text);
            cmd.Parameters.AddWithValue("@EmailName", txtName.Text);
            cmd.Parameters.AddWithValue("@EmailLastName", txtLastName.Text);
            cmd.Parameters.AddWithValue("@EmailBody", txtMessage.Text);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }
    }
}