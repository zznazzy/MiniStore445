using System;
using AdrianHashLib;

namespace MiniStoreWeb.Helpers
{
    public static class PasswordSecurity
    {
        public static string HashPassword(string plainTextPassword)
        {
            // Password hashing is funneled through one wrapper so auth pages call a single method.
            return HashUtil.Sha256(plainTextPassword ?? string.Empty);
        }

        public static bool VerifyPassword(string plainTextPassword, string storedHash)
        {
            return string.Equals(
                HashPassword(plainTextPassword),
                storedHash ?? string.Empty,
                StringComparison.OrdinalIgnoreCase
            );
        }
    }
}
