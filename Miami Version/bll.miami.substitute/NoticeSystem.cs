using System;
using System.Collections.Generic;
using System.Collections;
using System.Text;
using System.Data;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Web;
using System.IO;

namespace Miami.Substitute.Bll
{
    public class NoticeSystem
    {
        private NoticeType type;
        private MailAddressCollection to = new MailAddressCollection();
        private MailAddressCollection cc = new MailAddressCollection();
        private MailAddress from;
        private int JobId;
        private int SubstituteUserId;
        private int ClerkUserId;
        private int SubstituteId;
        private int LocationId;

        private DataRowView jobView;
        private DataRowView substituteView;
        private DataRowView clerkView;      


        private string Fill(string text)
        {
            if (jobView != null)
            {
                text = text.Replace("#JobId#", JobId.ToString());
                text = text.Replace("#EmployeeName#", jobView["Teacher"] != null ? jobView["Teacher"].ToString().Trim() : string.Empty);
                text = text.Replace("#Region#", jobView["Region"].ToString());
                text = text.Replace("#Location#", jobView["Location"].ToString());
                text = text.Replace("#JobDateStart#", jobView["DatetimeStart"].ToString());
                text = text.Replace("#JobDateEnd#", jobView["DatetimeEnd"].ToString());
                text = text.Replace("#Room#", jobView["Room"].ToString());
                text = text.Replace("#Subject#", jobView["Subject"].ToString());
                text = text.Replace("#Note#", jobView["Note"].ToString());
                
                text = text.Replace("#SubstituteFirstName#", substituteView["FirstName"].ToString().Trim());
                text = text.Replace("#SubstituteFullName#", substituteView["FirstName"].ToString().Trim() + " " + substituteView["LastName"].ToString().Trim());

                text = text.Replace("#ClerkName#", clerkView["FirstName"].ToString().Trim() + " " + clerkView["LastName"].ToString().Trim());
                text = text.Replace("#ClerkEmail#", clerkView["Email"].ToString());

                if (clerkView["OFFICE_PHONE_NUMBER"] != null)
                    text = text.Replace("#ClerkPhone#", clerkView["OFFICE_PHONE_NUMBER"].ToString());

                text = text.Replace("#JobStartDay#", Convert.ToDateTime(jobView["DatetimeStart"]).DayOfWeek.ToString());
                text = text.Replace("#JobEndDay#", Convert.ToDateTime(jobView["DatetimeEnd"]).DayOfWeek.ToString());

                if (type == NoticeType.JobAcceptedByClerk)
                {
                    string crypted = Encrypt(JobId.ToString()+"&"+SubstituteId.ToString()+"&2", "Dshd*&^*@dsdss", "237w&@2d", "SHA1", 2, "&s2hfyDjuf372*73", 256);
                    text = text.Replace("#keyAccept#", crypted);

                    crypted = Encrypt(JobId.ToString() + "&" + SubstituteId.ToString() + "&1", "Dshd*&^*@dsdss", "237w&@2d", "SHA1", 2, "&s2hfyDjuf372*73", 256);
                    text = text.Replace("#keyDecline#", crypted);
                }                
            }
            return text;
        }

        public enum NoticeType
        {
            JobAppliedForBySubstitute,
            JobAcceptedByClerk,
            AcceptedJobCancelledBySubstitute,
            AcceptedJobDeletedByClerk,
            JobConfirmedBySubstitute,
            JobDeclinedBySubstitute
        }

        public NoticeSystem(int jobId, NoticeType noticeType, int substituteUserId, int clerkUserId)
        {
            try
            {
                JobId = jobId;
                type = noticeType;
                SubstituteUserId = substituteUserId;

                Substitute substitute = new Substitute();
                substitute.LoadByUserId(SubstituteUserId);
                SubstituteId = substitute.SubstituteId;

                Job job = new Job(jobId);
                jobView = job.LoadByPrimaryKey(jobId);
                substituteView = (new Miami.Substitute.Dal.User()).LoadForMain(SubstituteUserId)[0];

                int.TryParse(jobView["LocationId"].ToString(), out LocationId);
                DataView dv = (new Dal.Job()).GetEmployee(LocationId);
                if (clerkUserId > 0)
                    ClerkUserId = clerkUserId;
                else if (dv.Count > 0)
                    ClerkUserId = Convert.ToInt32(dv[0]["Employee_Number"]);

                clerkView = (new Miami.Substitute.Dal.User()).LoadForMain(ClerkUserId)[0];
                                
                switch (type)
                {
                    case NoticeType.AcceptedJobCancelledBySubstitute: // Send to Clerks
                    case NoticeType.JobAppliedForBySubstitute:
                        from = new MailAddress(substituteView["Email"].ToString());

                        if (substituteView["Email"].ToString().Trim().Length > 0)
                            to.Add(new MailAddress(clerkView["Email"].ToString()));
                        
                        if (dv != null)
                            foreach (DataRow dr in dv.Table.Rows)
                                cc.Add(new MailAddress(dr["Employee_email_address"].ToString()));
                        break;

                    case NoticeType.AcceptedJobDeletedByClerk: // Send to Substitute
                    case NoticeType.JobAcceptedByClerk:
                    case NoticeType.JobConfirmedBySubstitute:
                    case NoticeType.JobDeclinedBySubstitute:
                        from = new MailAddress(clerkView["Email"].ToString());
                        if (substituteView["Email"].ToString().Trim().Length > 0)
                            to.Add(new MailAddress(substituteView["Email"].ToString()));

                        if (dv != null)
                            foreach (DataRow dr in dv.Table.Rows)
                            {
                                if (type != NoticeType.JobAcceptedByClerk)
                                    cc.Add(new MailAddress(dr["Employee_email_address"].ToString()));

                                if (from.Address.Length == 0)
                                    from = new MailAddress(dr["Employee_email_address"].ToString());
                            }
                        break;
                }
            }
            catch { }
        }

        protected string Encrypt(string plainText, string passPhrase, string saltValue, string hashAlgorithm, int passwordIterations, string initVector, int keySize)
        {
            byte[] initVectorBytes = Encoding.ASCII.GetBytes(initVector);
            byte[] saltValueBytes = Encoding.ASCII.GetBytes(saltValue);
            byte[] plainTextBytes = Encoding.UTF8.GetBytes(plainText);
            PasswordDeriveBytes password = new PasswordDeriveBytes(passPhrase, saltValueBytes, hashAlgorithm, passwordIterations);
            byte[] keyBytes = password.GetBytes(keySize / 8);
            RijndaelManaged symmetricKey = new RijndaelManaged();
            symmetricKey.Mode = CipherMode.CBC;
            ICryptoTransform encryptor = symmetricKey.CreateEncryptor(keyBytes, initVectorBytes);
            MemoryStream memoryStream = new MemoryStream();
            CryptoStream cryptoStream = new CryptoStream(memoryStream, encryptor, CryptoStreamMode.Write);
            cryptoStream.Write(plainTextBytes, 0, plainTextBytes.Length);
            cryptoStream.FlushFinalBlock();
            byte[] cipherTextBytes = memoryStream.ToArray();
            memoryStream.Close();
            cryptoStream.Close();
            string cipherText = Convert.ToBase64String(cipherTextBytes);

            StringWriter writer = new StringWriter();
            HttpContext.Current.Server.UrlEncode(cipherText, writer);

            return writer.ToString();
        }

        public void Send()
        {
            try
            {
                Miami.Substitute.Dal.Template template = new Miami.Substitute.Dal.Template();
                DataRowView drv = template.LoadTemplateByName(type.ToString());
                if (drv != null && drv["Text"].ToString().Length > 0)
                {
                    MailAddressCollection ññTemp = cc;
                    bool testMode = Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["UseTestEmailAddress"]);
                    if (testMode)
                    {                        
                        cc = new MailAddressCollection();
                        to = new MailAddressCollection();
                        to.Add(System.Configuration.ConfigurationManager.AppSettings["TestEmailAddress"]);
                    }
                    MailMessage myMail = new MailMessage();
                    myMail.From = from;
                    foreach (MailAddress item in to)
                        myMail.To.Add(item);
                    foreach (MailAddress item in cc)
                        myMail.CC.Add(item);
                    myMail.Subject = Fill(drv["Header"].ToString());
                    myMail.Body = Fill(drv["Text"].ToString());
                    myMail.Priority = MailPriority.Normal;
                    myMail.IsBodyHtml = true;

                    Dal.MailLog mailLog = new Miami.Substitute.Dal.MailLog();
                    mailLog.AddNew();
                    mailLog.LocationId = LocationId;
                    mailLog.MailFrom = myMail.From.Address;
                    mailLog.MailTo = myMail.To.ToString();
                    if (ññTemp.Count > 0)
                        mailLog.MailTo += " , cc: " + ññTemp.ToString();
                    mailLog.MailType = type.ToString();
                    mailLog.Subject = myMail.Subject;
                    mailLog.SendDate = DateTime.Now;
                    mailLog.Message = myMail.Body;
                    mailLog.Save();
                    int countLogs = mailLog.GetAllMailLogByLocationId(LocationId).Count;
                    if (countLogs > 1000)
                        mailLog.DeleteMailLog(LocationId, countLogs - 1000);

                    SmtpClient smtpClient = new SmtpClient(System.Configuration.ConfigurationManager.AppSettings["SmtpServer"]);
                    smtpClient.Send(myMail);
                }
            }
            catch { }
        }
    }
}
