using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FlutterAuthAPI.Models
{
    [Table("Comics")]
    public class ComicBook
    {
        [Key]
        [Column("BookID")] // ✅ Matches your DB
        public int Id { get; set; }

        [Column("BookName")]
        public string BookName { get; set; } = string.Empty;

        [Column("Author")]
        public string Author { get; set; } = string.Empty;

        [Column("ImageData")]
        public byte[] ImageData { get; set; } = Array.Empty<byte>();
    }
}
