// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;

namespace SampleServer;

/// <summary>
/// ASP .NET Core pipeline initialization.
/// </summary>
public class Startup
{
    /// <summary>
    /// This method gets called by the runtime. Use this method to add services to the container.
    /// </summary>
    public void ConfigureServices(IServiceCollection services)
    {
        services
            .AddControllers()
            .AddJsonOptions(options => options.JsonSerializerOptions.WriteIndented = true);
    }

    /// <summary>
    /// This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
    /// </summary>
    public void Configure(IApplicationBuilder app)
    {
        // Disabling https redirection behind the proxy. Forwarders are not currently set up so we can't tell if the external connection used https.
        // Nor do we know the correct port to redirect to.
        // app.UseHttpsRedirection();

        app.UseWebSockets();

        app.UseRouting();
        app.UseEndpoints(endpoints =>
        {
            endpoints.MapControllers();
        });
    }
}
