using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace TA.TopUp.Infrastructure.DataAccessAbstractions
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddDatabase(this IServiceCollection services, string connectionString)
        {
            services.AddDbContextFactory<TopUpSystemDbContext>(options =>
                options
                .UseSqlServer(connectionString)
                .UseQueryTrackingBehavior(QueryTrackingBehavior.NoTrackingWithIdentityResolution));

            return services;
        }
    }
}
