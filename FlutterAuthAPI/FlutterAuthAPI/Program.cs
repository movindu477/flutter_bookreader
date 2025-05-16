using FlutterAuthAPI.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// ✅ Register AppDbContext with your connection string
builder.Services.AddDbContext<AppDbContext>(options =>
	options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// ✅ Enable Swagger only in development
if (app.Environment.IsDevelopment())
{
	app.UseSwagger();
	app.UseSwaggerUI();

	// 🔓 Disable HTTPS redirection for Flutter to prevent 307 errors
	// Comment this out if you want to allow HTTP during local testing
	// DO NOT use this in production
	// app.UseHttpsRedirection(); <-- Comment or remove this line in development
}
else
{
	// ✅ In production, keep HTTPS redirection on
	app.UseHttpsRedirection();
}

app.UseAuthorization();

app.MapControllers();

app.Run();
