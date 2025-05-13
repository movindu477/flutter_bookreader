using System.ComponentModel.DataAnnotations;

public class Fiction
{
	[Key] // ✅ This is required
	public int BookId { get; set; }

	public string BookName { get; set; }
	public string Author { get; set; }
	public byte[] ImageData { get; set; }
}
