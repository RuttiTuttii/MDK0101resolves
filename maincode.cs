using System.Configuration;

namespace WpfAppConfig
{
    public static class ConfigManager
    {
        public static string Login => ConfigurationManager.AppSettings["Login"];
        public static string Password => ConfigurationManager.AppSettings["Password"];
        public static string Email => ConfigurationManager.AppSettings["Email"];

        public static void SaveSettings(string login, string password, string email)
        {
            Configuration config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
            
            config.AppSettings.Settings["Login"].Value = login;
            config.AppSettings.Settings["Password"].Value = password;
            config.AppSettings.Settings["Email"].Value = email;
            
            config.Save(ConfigurationSaveMode.Modified);
            ConfigurationManager.RefreshSection("appSettings");
        }
    }
}