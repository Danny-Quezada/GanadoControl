﻿using Data.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProblemaFisicoController : ControllerBase
    {
        private readonly IProblemaFisicoRepository problemaFisicoRepository;

        public ProblemaFisicoController(IProblemaFisicoRepository problemaFisicoRepository)
        {
            this.problemaFisicoRepository = problemaFisicoRepository;
        }

        [HttpPost]
        public async Task<IActionResult> InsertarParto([FromForm] ProblemaFisico problemaFisico)
        {
            await problemaFisicoRepository.Insertar(problemaFisico);
            return Created("Creado", true);
        }
        [HttpGet("ganado/{idGanado}")]
        public async Task<IActionResult> ObtenerProbFisicoXGanado([FromForm] string idGanado)
        {
            return Ok(await problemaFisicoRepository.ObtenerProblemasFisicosPorGanado(idGanado));
        }
        [HttpPut("{id}")]
        public async Task<IActionResult> ActualizarProbFisico([FromForm]ProblemaFisico problema, [FromForm]int id)
        {
            problema.Id = id;
            await problemaFisicoRepository.ActualizarProblemaFisico(problema);
            return Ok("Actualizado correctamente");
        }
        [HttpDelete("{id}")]
        public async Task<IActionResult> EliminarProbFisico([FromForm]int id)
        {
            await problemaFisicoRepository.EliminarProblemaFisico(id);
            return NoContent();
        }

    }
}
