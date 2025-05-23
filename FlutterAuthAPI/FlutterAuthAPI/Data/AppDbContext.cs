﻿using Microsoft.EntityFrameworkCore;
using FlutterAuthAPI.Models;

namespace FlutterAuthAPI.Data
{
	public class AppDbContext : DbContext
	{
		public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
		{
		}

		// Book category tables
		public DbSet<Fiction> Fiction { get; set; }
		public DbSet<NonFiction> NonFiction { get; set; }
		public DbSet<AcademicBook> AcademicBooks { get; set; }
		public DbSet<ComicBook> ComicBooks { get; set; }



		// User table
		public DbSet<User> Users { get; set; }
	}
}
