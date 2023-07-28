using System.ComponentModel.DataAnnotations;

public class UserModel
{
    public int Id { get; set; }

    [Required(ErrorMessage = "'Username' zorunludur.")]
    public string username { get; set; }
}
