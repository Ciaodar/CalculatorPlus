using System;
using calculatorApi.Models;
using calculatorApi.Services;
using Microsoft.AspNetCore.Mvc;

namespace calculatorApi.Controllers;

[ApiController]
[Route("api/[controller]")]
public class CalculatorController : Controller {

    private readonly MongoDBService _mongoDBService;

    public CalculatorController(MongoDBService mongoDBService) {
        _mongoDBService = mongoDBService;
    }

    [HttpGet]
    public async Task<List<CalcHistory>> GetAll() {
        return await _mongoDBService.GetAsync();
    }



    [HttpPost]
    public async Task<IActionResult> PostValue([FromBody] CalcHistory calcHistory)
    {
        /*await _mongoDBService.CreateAsync(calcHistory);
        return Created(string.Empty, "Calculation was saved succesfully!");*/
        //BURAYA RABBITMQ PRODUCER KODUMUZ GELECEK
        return Ok();
    }
    /*public void ConfigureServices(IServiceCollection services)
    {
        services.AddStackExchangeRedisCache(OptionsBuilderConfigurationExtensions => options);
        services.AddDistributedRedisCache(option=>{
                    option.Configuration="127.0.0.1:6379";
                    option.InstanceName="main";                    
            });
        services.AddStackExchangeRedisCache(OptionsBuilderConfigurationExtensions => options.Configuration = "localhost:6379");
        //services.AddMemoryCache();
        services.AddControllersWithViews();
    }

    IDistributedCache _distributedCache;


    public CalculatorController(IDistributedCache distributedCache)
    {
        
        _distributedCache = distributedCache;
    } 

    [HttpGet]
    [Route("api/calculate/{index1}/{index2}")]
    public IActionResult Calculate(int index1 , int index2)
    {
        var cacheKey = $"result_{index1}_{index2}"; 
        var cachedResult = _distributedCache.GetString(cacheKey);
        if(!string.IsNullOrEmpty(cachedResult)){
            return Ok(cachedResult);
        }

        var result; //= ?Hesaplama metodu yazılıcak

       _distributedCache.SetString(cacheKey, result , new DistributedCacheEntryOptions{
        AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(5)
       });

       return Ok(result);
    }*/
    
}

