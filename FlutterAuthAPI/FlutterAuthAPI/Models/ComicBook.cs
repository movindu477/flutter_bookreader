using System.ComponentModel.DataAnnotations;

namespace FlutterAuthAPI.Models
{
    public class ComicBook
    {
        [Key]
        public int Id { get; set; }
        public string BookName { get; set; } = string.Empty;
        public string Author { get; set; } = string.Empty;
        public byte[] ImageData { get; set; } = Array.Empty<byte>();
    }
}
