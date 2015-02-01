using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Threading;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace SendingEmailsApp
{
    public class Global : System.Web.HttpApplication
    {
        private const string connectionString = "Data Source=localhost;Initial Catalog=EmailsDB;Integrated Security=SSPI;";
        public static BackgroundWorker worker = new BackgroundWorker();
        public static bool stopWorker = false;

        protected void Application_Start(object sender, EventArgs e)
        {
            worker.DoWork += new DoWorkEventHandler(DoWork);
            worker.WorkerReportsProgress = true;
            worker.WorkerSupportsCancellation = true;
            worker.RunWorkerCompleted += new RunWorkerCompletedEventHandler(WorkerCompleted);
            // Calling the DoWork Method Asynchronously
            worker.RunWorkerAsync();
        }

        protected void Application_End(object sender, EventArgs e)
        {
            if (worker != null)
                worker.CancelAsync();
        }

        private static void DoWork(object sender, DoWorkEventArgs e)
        {
            // Here we read and send unread emails
            SqlConnection conn = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("GetEmailsToBeSend", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            if(ds.Tables.Count > 0)
            {
                foreach(DataRow row in ds.Tables[0].Rows)
                {
                    SendEmail(Int32.Parse(row[0].ToString()), row[1].ToString(), row[2].ToString(),
                        row[3].ToString(),row[4].ToString());
                }
            }
        }

        private static void WorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            BackgroundWorker worker = sender as BackgroundWorker;
            if (worker != null)
            {
                System.Threading.Thread.Sleep(3000);
                if (!stopWorker)
                {
                    worker.RunWorkerAsync();
                }
                else
                {
                    while (stopWorker)
                    {
                        Thread.Sleep(6000);
                    }
                    worker.RunWorkerAsync();
                }
            }
        }

        private static void SendEmail(int EmailID,string emailAddress, string name,string lastName, string mailBody)
        {
            string messageForm = HttpRuntime.AppDomainAppPath +"App_Data\\MessageForm.txt";
            string messageToSend = File.ReadAllText(messageForm);
            messageToSend = messageToSend.Replace("@@name@@", name);
            messageToSend = messageToSend.Replace("@@lastName@@", lastName);
            messageToSend = messageToSend.Replace("@@message@@", mailBody);
            messageToSend = messageToSend.Replace("@@loginLink@@", "http://socialnetwork?login=" + lastName);

            MailMessage myMessage = new MailMessage();
            myMessage.Subject = "SocialNetwork account activation";
            myMessage.Body = messageToSend;
            myMessage.From = new MailAddress(emailAddress, "SocialNetwork");
            myMessage.To.Add(new MailAddress(emailAddress, name + " " + lastName));
            SmtpClient mySmtpClient = new SmtpClient();
            mySmtpClient.Send(myMessage);
            UpdateEmailStatus(EmailID);
        }

        private static void UpdateEmailStatus(int EmailID)
        {
            SqlConnection conn = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("UpdateEmailStatus", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@EmailID", EmailID);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }
    }
}