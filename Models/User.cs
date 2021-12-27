using System.ComponentModel.DataAnnotations;

namespace betaluchs.Models
{
    public class User
    {
        [Key]
        public String Id { get; set; }

        public DateOnly BirtDate { get; set; }

        public DateOnly RegisterDate { get; set; }

        public Boolean AgeDisplay { get; set; }

        public String Email { get; set; }

        public Boolean EmailDisplay { get; set; }

        public String Username { get; set; }

        public String PGPKey { get; set; }

        public String PasswordHash { get; set; }

    }
}