using Microsoft.AspNetCore.Mvc;
using FlutterAuthAPI.Models;

namespace YourAspNetProject.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ComicBooksController : ControllerBase
    {
        [HttpGet]
        public ActionResult<List<ComicBook>> Get()
        {
            var books = new List<ComicBook>
            {
                new ComicBook
                {
                    Id = 1,
                    Title = "Watchmen",
                    Author = "Alan Moore & Dave Gibbons",
                    ImageUrl = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASw..."
                },
                new ComicBook
                {
                    Id = 2,
                    Title = "Maus: A Survivor’s Tale",
                    Author = "Art Spiegelman",
                    ImageUrl = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASw..."
                }
            };

            return Ok(books);
        }
    }
}