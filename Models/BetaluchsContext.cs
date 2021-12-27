using Microsoft.EntityFrameworkCore;

namespace betaluchs.Models
{
    public class BetaluchsContext : DbContext
    {
        public BetaluchsContext(DbContextOptions<BetaluchsContext> options) : base(options) { }

        #region Required
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            return;
        }
        #endregion

        public DbSet<User> Users { get; set; }
    }
}