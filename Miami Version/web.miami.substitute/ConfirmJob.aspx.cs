using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Security.Cryptography;
using System.IO;
using System.Text;
using Miami.Substitute.Bll;

public partial class ConfirmJob : System.Web.UI.Page
{
    protected string Decrypt(string cipherText, string passPhrase, string saltValue, string hashAlgorithm, int passwordIterations, string initVector, int keySize)
    {
        byte[] initVectorBytes = Encoding.ASCII.GetBytes(initVector);
        byte[] saltValueBytes = Encoding.ASCII.GetBytes(saltValue);
        byte[] cipherTextBytes = Convert.FromBase64String(cipherText);
        PasswordDeriveBytes password = new PasswordDeriveBytes(passPhrase, saltValueBytes, hashAlgorithm, passwordIterations);
        byte[] keyBytes = password.GetBytes(keySize / 8);
        RijndaelManaged symmetricKey = new RijndaelManaged();
        symmetricKey.Mode = CipherMode.CBC;
        ICryptoTransform decryptor = symmetricKey.CreateDecryptor(keyBytes, initVectorBytes);
        MemoryStream memoryStream = new MemoryStream(cipherTextBytes);
        CryptoStream cryptoStream = new CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read);
        byte[] plainTextBytes = new byte[cipherTextBytes.Length];
        int decryptedByteCount = cryptoStream.Read(plainTextBytes, 0, plainTextBytes.Length);
        memoryStream.Close();
        cryptoStream.Close();
        string plainText = Encoding.UTF8.GetString(plainTextBytes, 0, decryptedByteCount);

        StringWriter writer = new StringWriter();
        HttpContext.Current.Server.UrlDecode(plainText, writer);

        return writer.ToString();
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["jobtoken"]))
        {
            string decrypted = Decrypt(Request.QueryString["jobtoken"], "Dshd*&^*@dsdss", "237w&@2d", "SHA1", 2, "&s2hfyDjuf372*73", 256);
            string[] splitted = decrypted.Split('&');
            if (splitted.Length > 1)
            {
                int jobId; int.TryParse(splitted[0], out jobId);
                int substId; int.TryParse(splitted[1], out substId);
                int type; int.TryParse(splitted[2], out type);
                Job job = new Job(jobId);
                Substitute substitute = new Substitute(substId);
                Miami.Substitute.Dal.User user = new Miami.Substitute.Dal.User();
                DataView userView = user.LoadForMain(substitute.UserId);

                string confirmNote = String.Format("Confirmed by Substitute {0} on {1} {2} by clicking email link", userView[0]["FirstName"].ToString().Trim() + " " + userView[0]["LastName"].ToString().Trim(), DateTime.Now.ToShortDateString(), DateTime.Now.ToShortTimeString());

                if (job.m_statusId == 3)
                {
                    (new Miami.Substitute.Bll.Job()).ConfirmJob(jobId, substId, type, confirmNote);

                    if (type == 2)
                        Message.Text = "You have successfully confirmed your job assignment.";
                    else
                        Message.Text = "You have declined your job assignment.";
                }
                else
                {
                    if (job.m_statusId == 2)
                        Message.Text = "Job was already confirmed.";
                    else
                        Message.Text = "Job was already declined.";
                }
            }
        }
    }
}
