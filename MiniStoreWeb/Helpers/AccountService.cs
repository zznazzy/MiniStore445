using System;
using MiniStoreWeb.Models;

namespace MiniStoreWeb.Helpers
{
    public static class AccountService
    {
        public static bool TryRegisterMember(string displayName, string username, string password, out StoreUser createdUser, out string errorMessage)
        {
            createdUser = null;
            errorMessage = string.Empty;

            displayName = (displayName ?? string.Empty).Trim();
            username = (username ?? string.Empty).Trim();

            if (displayName.Length < 2)
            {
                errorMessage = "Enter a display name with at least 2 characters.";
                return false;
            }

            if (username.Length < 3)
            {
                errorMessage = "Choose a username with at least 3 characters.";
                return false;
            }

            if (string.IsNullOrWhiteSpace(password) || password.Length < 6)
            {
                errorMessage = "Choose a password with at least 6 characters.";
                return false;
            }

            if (AccountRepository.MemberExists(username))
            {
                errorMessage = "That member username is already in use.";
                return false;
            }

            createdUser = new StoreUser
            {
                Username = username,
                DisplayName = displayName,
                // Password hashing flows through PasswordSecurity so the Adrian DLL call stays isolated.
                PasswordHash = PasswordSecurity.HashPassword(password),
                Role = AuthenticationHelper.MemberRole,
                CreatedUtc = DateTime.UtcNow
            };

            AccountRepository.SaveMember(createdUser);
            return true;
        }

        public static bool TryAuthenticate(string username, string password, string role, out StoreUser authenticatedUser, out string errorMessage)
        {
            authenticatedUser = null;
            errorMessage = string.Empty;

            username = (username ?? string.Empty).Trim();
            role = (role ?? string.Empty).Trim();

            if (username.Length == 0 || string.IsNullOrWhiteSpace(password))
            {
                errorMessage = "Enter both a username and password.";
                return false;
            }

            StoreUser storedUser = string.Equals(role, AuthenticationHelper.StaffRole, StringComparison.OrdinalIgnoreCase)
                ? AccountRepository.FindStaff(username)
                : AccountRepository.FindMember(username);

            if (storedUser == null)
            {
                errorMessage = "No matching account was found for that username and account type.";
                return false;
            }

            // Password verification is centralized so the Adrian hashing wrapper stays behind one call.
            if (!PasswordSecurity.VerifyPassword(password, storedUser.PasswordHash))
            {
                errorMessage = "The username or password is incorrect.";
                return false;
            }

            authenticatedUser = storedUser;
            return true;
        }
    }
}
