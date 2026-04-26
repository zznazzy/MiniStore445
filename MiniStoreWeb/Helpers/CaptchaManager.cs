using System;
using System.Security.Cryptography;
using System.Web;

namespace MiniStoreWeb.Helpers
{
    public static class CaptchaManager
    {
        private const string SessionKey = "MiniStoreCaptchaCode";
        private static readonly char[] CharacterPool = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789".ToCharArray();

        public static string CreateNewChallenge()
        {
            char[] buffer = new char[5];

            using (RandomNumberGenerator generator = RandomNumberGenerator.Create())
            {
                byte[] randomBytes = new byte[buffer.Length];
                generator.GetBytes(randomBytes);

                for (int index = 0; index < buffer.Length; index++)
                {
                    buffer[index] = CharacterPool[randomBytes[index] % CharacterPool.Length];
                }
            }

            string challenge = new string(buffer);
            HttpContext.Current.Session[SessionKey] = challenge;
            return challenge;
        }

        public static string EnsureChallenge()
        {
            string currentCode = GetCurrentChallenge();
            return string.IsNullOrWhiteSpace(currentCode) ? CreateNewChallenge() : currentCode;
        }

        public static string GetCurrentChallenge()
        {
            HttpContext context = HttpContext.Current;
            if (context == null || context.Session == null)
            {
                return string.Empty;
            }

            return context.Session[SessionKey] as string ?? string.Empty;
        }

        public static bool Validate(string userInput)
        {
            string currentCode = GetCurrentChallenge();
            bool isValid = !string.IsNullOrWhiteSpace(currentCode) &&
                string.Equals(currentCode, (userInput ?? string.Empty).Trim(), StringComparison.OrdinalIgnoreCase);

            if (HttpContext.Current != null && HttpContext.Current.Session != null)
            {
                HttpContext.Current.Session.Remove(SessionKey);
            }

            return isValid;
        }
    }
}
