using System.ComponentModel.DataAnnotations;

public class UserModel
{
    public int Id { get; set; }

    [Required(ErrorMessage = "Kullan�c� ad� zorunludur.")]
    public string username { get; set; }
}
