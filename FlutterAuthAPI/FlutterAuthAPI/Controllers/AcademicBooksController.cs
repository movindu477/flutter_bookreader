using FlutterAuthAPI.Data;
using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("api/[controller]")]
public class AcademicBooksController : ControllerBase
{
    private readonly AppDbContext _context;

    public AcademicBooksController(AppDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public IActionResult GetAcademicBooks()
    {
        var books = _context.AcademicBooks
            .Select(book => new
            {
                title = book.BookName,
                author = book.Author,
                imageUrl = $"data:image/jpeg;base64,{Convert.ToBase64String(book.ImageData)}"
            }).ToList();

        return Ok(books);
    }
}
