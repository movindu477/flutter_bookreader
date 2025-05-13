using FlutterAuthAPI.Data;
using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("api/[controller]")]
public class NonFictionController : ControllerBase
{
    private readonly AppDbContext _context;

    public NonFictionController(AppDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public IActionResult GetNonFictionBooks()
    {
        var books = _context.NonFiction
            .Select(book => new
            {
                title = book.BookName,
                author = book.Author,
                imageUrl = $"data:image/jpeg;base64,{Convert.ToBase64String(book.ImageData)}"
            })
            .ToList();

        return Ok(books);
    }
}
