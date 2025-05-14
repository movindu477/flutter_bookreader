using Microsoft.EntityFrameworkCore;
using FlutterAuthAPI.Models;

namespace FlutterAuthAPI.Data
{
	public class AppDbContext : DbContext
	{
		public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
		{
		}

		public DbSet<Fiction> Fiction { get; set; }
		public DbSet<User> Users { get; set; }
		public DbSet<NonFiction> NonFiction { get; set; }
		public DbSet<AcademicBook> AcademicBooks { get; set; }
	}
}
