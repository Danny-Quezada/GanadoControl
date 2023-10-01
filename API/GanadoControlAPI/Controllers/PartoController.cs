﻿using Data.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PartoController : ControllerBase
    {
        private readonly IPartoRepository partoRepository;

        public PartoController(IPartoRepository partoRepository)
        {
            this.partoRepository = partoRepository;
        }

        [HttpPost]
        public async Task<IActionResult> InsertarParto([FromForm] Parto parto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if(parto is null)
            {
                return BadRequest("El objeto Parto es nulo");
            }
            try
            {
                await partoRepository.Insertar(parto);
                return Created("Creado", true);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error a la hora de insertar parto {ex.Message}");
            }
        }
    }
}
