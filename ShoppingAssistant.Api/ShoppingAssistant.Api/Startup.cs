using Microsoft.Extensions.DependencyInjection;
using ShoppingAssistant.Api.Repositories;
using ShoppingAssistant.Api.Repositories.Interfaces;
using ShoppingAssistant.Api.Services.Interfaces;
using ShoppingAssistant.Api.Services;

public class Startup
{
    public void ConfigureServices(IServiceCollection services)
    {
        // Configurarea serviciilor și dependențelor

        services.AddCors(options =>
        {
            options.AddDefaultPolicy(builder =>
            {
                builder.AllowAnyOrigin()
                       .AllowAnyMethod()
                       .AllowAnyHeader();
            });
        });
    }

    // Alte metode de configurare (dacă sunt necesare)
}
