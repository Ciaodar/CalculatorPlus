using System.Threading.Tasks;
using calculatorApi.Models;
using Microsoft.Extensions.Options;
using Npgsql;

namespace calculatorApi.Services
{
    public class UserService
    {
        private readonly string _connectionString;

        public UserService(IOptions<DbSettings> dbSettings)
        {
            _connectionString = dbSettings.Value.ConnectionString;
        }

        public async Task<User> RegisterUserAsync(User user)
        {
            using (var connection = new NpgsqlConnection(_connectionString))
            {
                await connection.OpenAsync();

                using (var cmd = new NpgsqlCommand())
                {
                    cmd.Connection = connection;

                    cmd.CommandText = "INSERT INTO users (username, email, password) VALUES (@username, @email, @password)";
                    cmd.Parameters.AddWithValue("username", user.Username);
                    cmd.Parameters.AddWithValue("email", user.Email);
                    cmd.Parameters.AddWithValue("password", user.Password);

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
