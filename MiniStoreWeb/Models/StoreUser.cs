using System;

namespace MiniStoreWeb.Models
{
    public sealed class StoreUser
    {
        public string Username { get; set; }

        public string DisplayName { get; set; }

        public string PasswordHash { get; set; }

        public string Role { get; set; }

        public DateTime CreatedUtc { get; set; }
    }
}
