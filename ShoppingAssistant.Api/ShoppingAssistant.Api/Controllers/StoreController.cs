using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MongoDB.Bson;
using ShoppingAssistant.Api.Models;
using ShoppingAssistant.Api.Services;
using ShoppingAssistant.Api.Services.Interfaces;

namespace ShoppingAssistant.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StoreController : ControllerBase
    {
        private readonly IStoreService _storeService;

        public StoreController(IStoreService storeService)
        {
            _storeService = storeService;
        }
        [HttpGet]
        public IEnumerable<Store> GetStore()
        {
            return _storeService.GetAllStores();
        }

        [HttpPost]
        public async Task<IActionResult> Create(Store store)
        {
            await _storeService.AddStoreAsync(store);

            return CreatedAtAction(nameof(GetById), new { id = store.Id }, store);
        }

        [HttpGet("id")]
        public IActionResult GetById(string id)
        {
            var store = _storeService.GetStore(ObjectId.Parse(id));

            return store == null ? NotFound() : Ok(store);
        }

        [HttpGet("list")]
        public IActionResult GetStoresByIds([FromQuery] List<string> ids)
        {
            var stores = _storeService.GetStoresByIds(ids);

            return Ok(stores);
        }
    }
}
