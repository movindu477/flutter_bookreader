namespace FlutterAuthAPI.Models
{
    public class ComicBook
    {
        public int Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string Author { get; set; } = string.Empty;
        public string ImageUrl { get; set; } = string.Empty;
    }
}