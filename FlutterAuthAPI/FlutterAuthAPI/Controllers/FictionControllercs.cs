using FlutterAuthAPI.Data;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Linq;

namespace FlutterAuthAPI.Controllers
{
	[ApiController]
	[Route("api/[controller]")]
	public class FictionController : ControllerBase
	{
		private readonly AppDbContext _context;

		public FictionController(AppDbContext context)
		{
			_context = context;
		}

		[HttpGet]
		public IActionResult GetFictionBooks()
		{
			var books = _context.Fiction
					.Select(f => new
					{
						title = f.BookName,
						author = f.Author,
						imageUrl = $"data:image/jpeg;base64,{Convert.ToBase64String(f.ImageData)}"
					})
					.ToList();

			return Ok(books);
		}
	}
}
