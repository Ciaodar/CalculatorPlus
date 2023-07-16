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



    [HttpPut]
    public async Task<IActionResult> PostValue([FromBody] CalcHistory calcHistory)
    {
        await _mongoDBService.CreateAsync(calcHistory);
        return Created(string.Empty, calcHistory);
    }
    
}

