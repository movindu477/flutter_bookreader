using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore; // ✅ Required for ToListAsync
using FlutterAuthAPI.Data;
using FlutterAuthAPI.Models;

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
        public async Task<ActionResult<List<ComicBook>>> Get()
        {
            try
            {
                var booksFromDb = await _context.ComicBooks.ToListAsync();

                if (booksFromDb == null || !booksFromDb.Any())
                {
                    return NotFound(new { message = "No comic books found." });
                }

                return Ok(booksFromDb);
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
