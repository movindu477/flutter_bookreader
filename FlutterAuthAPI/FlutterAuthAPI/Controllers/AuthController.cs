using Microsoft.AspNetCore.Mvc;
using FlutterAuthAPI.Data;
using FlutterAuthAPI.Models;
using System.Linq;

namespace FlutterAuthAPI.Controllers
{
	[ApiController]
	[Route("api/[controller]")]
	public class AuthController : ControllerBase
	{
		private readonly AppDbContext _context;

		public AuthController(AppDbContext context)
		{
			_context = context;
		}

		// POST: api/auth/login
		[HttpPost("login")]
		public IActionResult Login([FromForm] string email, [FromForm] string password)
		{
			var user = _context.Users.FirstOrDefault(u => u.Email == email && u.Password == password);

			if (user != null)
			{
				return Ok(new
				{
					status = "success",
					username = user.Username
				});
			}

			return Unauthorized(new
			{
				status = "error",
				message = "Invalid credentials"
			});
		}

		// POST: api/auth/register
		[HttpPost("register")]
		public IActionResult Register([FromForm] string email, [FromForm] string username, [FromForm] string password)
		{
			// Check if email already exists
			if (_context.Users.Any(u => u.Email == email))
			{
				return BadRequest(new
				{
					status = "error",
					message = "Email already exists"
				});
			}

			// Create new user
			var newUser = new User
			{
				Email = email,
				Username = username,
				Password = password
			};

			_context.Users.Add(newUser);
			_context.SaveChanges();

			return Ok(new
			{
				status = "success",
				message = "User registered successfully"
			});
		}
	}
}
