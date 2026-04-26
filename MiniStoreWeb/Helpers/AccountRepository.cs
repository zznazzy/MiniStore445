using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Xml.Linq;
using MiniStoreWeb.Models;

namespace MiniStoreWeb.Helpers
{
    public static class AccountRepository
    {
        private static readonly object SyncRoot = new object();
        private const string SeedStaffUserName = "TA";
        private const string SeedStaffDisplayName = "Teaching Assistant";
        private const string SeedStaffPasswordHash = "d85b22f0890f5e82d76967037156f2a0bf779bcd44123bd5a2fa7ab299a289d6";

        public static List<StoreUser> GetMembers()
        {
            return LoadUsers(
                ResolvePath("~/App_Data/Member.xml"),
                "Members",
                "Member",
                AuthenticationHelper.MemberRole
            );
        }

        public static List<StoreUser> GetStaff()
        {
            EnsureStaffSeedAccount();

            return LoadUsers(
                ResolvePath("~/App_Data/Staff.xml"),
                "StaffMembers",
                "StaffMember",
                AuthenticationHelper.StaffRole
            );
        }

        public static StoreUser FindMember(string username)
        {
            return GetMembers().FirstOrDefault(user =>
                string.Equals(user.Username, username, StringComparison.OrdinalIgnoreCase)
            );
        }

        public static StoreUser FindStaff(string username)
        {
            return GetStaff().FirstOrDefault(user =>
                string.Equals(user.Username, username, StringComparison.OrdinalIgnoreCase)
            );
        }

        public static bool MemberExists(string username)
        {
            return FindMember(username) != null;
        }

        public static void SaveMember(StoreUser user)
        {
            SaveUser(
                ResolvePath("~/App_Data/Member.xml"),
                "Members",
                "Member",
                user
            );
        }

        public static void EnsureStaffSeedAccount()
        {
            lock (SyncRoot)
            {
                string path = ResolvePath("~/App_Data/Staff.xml");
                XDocument document = LoadOrCreateDocument(path, "StaffMembers");

                bool alreadyExists = document.Root
                    .Elements("StaffMember")
                    .Any(element => string.Equals(
                        (string)element.Element("Username"),
                        SeedStaffUserName,
                        StringComparison.OrdinalIgnoreCase
                    ));

                if (alreadyExists)
                {
                    return;
                }

                document.Root.Add(CreateUserElement(new StoreUser
                {
                    Username = SeedStaffUserName,
                    DisplayName = SeedStaffDisplayName,
                    PasswordHash = SeedStaffPasswordHash,
                    Role = AuthenticationHelper.StaffRole,
                    CreatedUtc = DateTime.UtcNow
                }, "StaffMember"));

                document.Save(path);
            }
        }

        private static List<StoreUser> LoadUsers(string path, string rootName, string itemName, string role)
        {
            lock (SyncRoot)
            {
                XDocument document = LoadOrCreateDocument(path, rootName);

                return document.Root
                    .Elements(itemName)
                    .Select(element => new StoreUser
                    {
                        Username = ((string)element.Element("Username") ?? string.Empty).Trim(),
                        DisplayName = ((string)element.Element("DisplayName") ?? string.Empty).Trim(),
                        PasswordHash = ((string)element.Element("PasswordHash") ?? string.Empty).Trim(),
                        Role = role,
                        CreatedUtc = ParseCreatedUtc((string)element.Element("CreatedUtc"))
                    })
                    .OrderBy(user => user.Username)
                    .ToList();
            }
        }

        private static void SaveUser(string path, string rootName, string itemName, StoreUser user)
        {
            lock (SyncRoot)
            {
                XDocument document = LoadOrCreateDocument(path, rootName);
                document.Root.Add(CreateUserElement(user, itemName));
                document.Save(path);
            }
        }

        private static XElement CreateUserElement(StoreUser user, string itemName)
        {
            return new XElement(itemName,
                new XElement("Username", user.Username ?? string.Empty),
                new XElement("DisplayName", user.DisplayName ?? string.Empty),
                new XElement("PasswordHash", user.PasswordHash ?? string.Empty),
                new XElement("CreatedUtc", user.CreatedUtc == DateTime.MinValue ? DateTime.UtcNow.ToString("o") : user.CreatedUtc.ToString("o"))
            );
        }

        private static XDocument LoadOrCreateDocument(string path, string rootName)
        {
            EnsureDirectory(path);

            if (!File.Exists(path))
            {
                XDocument newDocument = new XDocument(new XElement(rootName));
                newDocument.Save(path);
                return newDocument;
            }

            XDocument document = XDocument.Load(path);
            if (document.Root == null || !string.Equals(document.Root.Name.LocalName, rootName, StringComparison.Ordinal))
            {
                document = new XDocument(new XElement(rootName));
                document.Save(path);
            }

            return document;
        }

        private static void EnsureDirectory(string path)
        {
            string directoryPath = Path.GetDirectoryName(path);
            if (!string.IsNullOrWhiteSpace(directoryPath) && !Directory.Exists(directoryPath))
            {
                Directory.CreateDirectory(directoryPath);
            }
        }

        private static DateTime ParseCreatedUtc(string createdUtcValue)
        {
            DateTime createdUtc;
            return DateTime.TryParse(createdUtcValue, out createdUtc)
                ? createdUtc
                : DateTime.UtcNow;
        }

        private static string ResolvePath(string appRelativePath)
        {
            HttpContext context = HttpContext.Current;
            if (context == null)
            {
                throw new InvalidOperationException("An active HTTP context is required to resolve XML storage paths.");
            }

            return context.Server.MapPath(appRelativePath);
        }
    }
}
