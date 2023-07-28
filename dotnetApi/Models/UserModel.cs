using System.ComponentModel.DataAnnotations;

public class UserModel
{
    public int Id { get; set; }

    [Required(ErrorMessage = "Kullanýcý adý zorunludur.")]
    public string username { get; set; }
}
