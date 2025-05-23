using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using FlutterAuthAPI.Data;
using FlutterAuthAPI.Models;
using System.Text; // Required for Convert.ToBase64String

namespace FlutterAuthAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ComicBooksController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ComicBooksController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<List<ComicBookDto>>> Get()
        {
            try
            {
                var booksFromDb = await _context.ComicBooks.ToListAsync();

                if (booksFromDb == null || !booksFromDb.Any())
                {
                    return NotFound(new { message = "No comic books found." });
                }

                var bookDtos = booksFromDb.Select(book => new ComicBookDto
                {
                    Id = book.Id,
                    Title = book.BookName,
                    Author = book.Author,
                    ImageUrl = $"data:image/png;base64,{Convert.ToBase64String(book.ImageData)}"
                }).ToList();

                return Ok(bookDtos);
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new
                {
                    message = "Error retrieving data",
                    error = ex.Message
                });
            }
        }
    }
}
