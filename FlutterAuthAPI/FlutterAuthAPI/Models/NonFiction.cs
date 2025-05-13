using System.ComponentModel.DataAnnotations;

namespace FlutterAuthAPI.Models
{
    public class NonFiction
    {
        [Key]
        public int BookId { get; set; }

        public string BookName { get; set; }

        public string Author { get; set; }

        public byte[] ImageData { get; set; }
    }
}
