using System.Threading.Tasks;
using calculatorApi.Models;
using Microsoft.Extensions.Options;
using Npgsql;

namespace calculatorApi.Services
{
    public class UserService
    {
        private readonly string _connectionString;

        public UserService(IOptions<DBSettings> dbSettings)
        {
            _connectionString = dbSettings.Value.ConnectionString;
        }

        public async Task<UserModel> RegisterUserAsync(UserModel user)
        {
            using (var connection = new NpgsqlConnection(_connectionString))
            {
                await connection.OpenAsync();

                using (var cmd = new NpgsqlCommand())
                {
                    cmd.Connection = connection;

                    cmd.CommandText = "INSERT INTO users (username, UserId) VALUES (@username, @UserId)";
                    cmd.Parameters.AddWithValue("username", user.username);
                    cmd.Parameters.AddWithValue("UserId", user.Id);


                    try
                    {
                        await cmd.ExecuteNonQueryAsync();
                        return user;
                    }
                    catch
                    {
                        // Kayıt işlemi başarısız olursa burada uygun bir hata işleme yapılabilir.
                        return null;
                    }
                }
            }
        }
    }
}
