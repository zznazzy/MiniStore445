using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Web;
using System.Web.SessionState;
using MiniStoreWeb.Helpers;

namespace MiniStoreWeb
{
    public class CaptchaImage : IHttpHandler, IRequiresSessionState
    {
        public void ProcessRequest(HttpContext context)
        {
            string challengeText = CaptchaManager.EnsureChallenge();

            using (Bitmap bitmap = new Bitmap(180, 60))
            using (Graphics graphics = Graphics.FromImage(bitmap))
            using (Font font = new Font("Arial", 24, FontStyle.Bold))
            using (LinearGradientBrush brush = new LinearGradientBrush(
                new Rectangle(0, 0, bitmap.Width, bitmap.Height),
                Color.FromArgb(232, 244, 255),
                Color.FromArgb(252, 252, 252),
                0F))
            {
                graphics.SmoothingMode = SmoothingMode.AntiAlias;
                graphics.Clear(Color.WhiteSmoke);
                graphics.FillRectangle(brush, 0, 0, bitmap.Width, bitmap.Height);

                for (int index = 0; index < 8; index++)
                {
                    using (Pen noisePen = new Pen(index % 2 == 0 ? Color.LightSteelBlue : Color.Gainsboro, 1.2F))
                    {
                        graphics.DrawLine(
                            noisePen,
                            index * 22,
                            index % 2 == 0 ? 0 : 60,
                            180 - (index * 18),
                            index % 2 == 0 ? 60 : 0
                        );
                    }
                }

                for (int index = 0; index < challengeText.Length; index++)
                {
                    float x = 18 + (index * 28);
                    float y = 12 + (index % 2 == 0 ? 0 : 4);
                    graphics.DrawString(challengeText[index].ToString(), font, Brushes.DarkSlateBlue, x, y);
                }

                context.Response.Clear();
                context.Response.ContentType = "image/png";
                context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                context.Response.Cache.SetNoStore();
                bitmap.Save(context.Response.OutputStream, ImageFormat.Png);
            }
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}
