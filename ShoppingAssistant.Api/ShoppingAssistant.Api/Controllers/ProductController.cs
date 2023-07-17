using Microsoft.AspNetCore.Mvc;
using MongoDB.Bson;
using ShoppingAssistant.Api.Models;
using ShoppingAssistant.Api.Services.Interfaces;

namespace ShoppingAssistant.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly IProductService _productService;

        public ProductController(IProductService productService)
        {
            _productService = productService;
        }

        [HttpGet]
        public async Task<IEnumerable<Product>> GetProduct()
        {
            Response.Headers.Add("Access-Control-Allow-Origin", "*");
            return await _productService.GetAllProductsAsync();
        }

        [HttpGet("id")]
        public async Task<IActionResult> GetById(string id)
        {
            var product = await _productService.GetProductAsync(ObjectId.Parse(id));
            Response.Headers.Add("Access-Control-Allow-Origin", "*");

            return product == null ? NotFound() : Ok(product);
        }

        [HttpGet("barcode")]
        public async Task<IActionResult> GetByBarcode(string barcode)
        {
            var product = _productService.GetProductByBarcode(barcode);
            Response.Headers.Add("Access-Control-Allow-Origin", "*");

            return product == null ? NotFound() : Ok(product);
        }

        [HttpGet("hint")]
        public IActionResult GetByHint(string hint)
        {
            var products = _productService.GetProductsByHint(hint);
            Response.Headers.Add("Access-Control-Allow-Origin", "*");

            return products == null ? NotFound() : Ok(products);
        }

        [HttpGet("priceHistory")]
        public async Task<IActionResult> GetProductPriceHistory(string productId)
        {
            if (!ObjectId.TryParse(productId, out _))
            {
                return BadRequest("Invalid ID format"); // Return 400 Bad Request response
            }

            if (!_productService.ProductExists(productId))
            {
                return NotFound();
            }

            Response.Headers.Add("Access-Control-Allow-Origin", "*");

            var priceHistory = _productService.GetProductPriceHistory(ObjectId.Parse(productId));

            return priceHistory == null ? NotFound() : Ok(priceHistory);
        }

        [HttpPost("{productId}/priceHistory")]
        public IActionResult AddPriceHistory(string productId, PriceHistory priceHistory)
        {
            Response.Headers.Add("Access-Control-Allow-Origin", "*");

            if (!ObjectId.TryParse(productId, out _))
            {
                return BadRequest("Invalid ID format"); // Return 400 Bad Request response
            }

            if (!_productService.ProductExists(productId))
            {
                return NotFound();
            }

            _productService.AddPriceHistory(productId, priceHistory);

            return Ok();
        }

        [HttpPost]
        public async Task<IActionResult> Create(Product product)
        {
            await _productService.AddProduct(product);
            Response.Headers.Add("Access-Control-Allow-Origin", "*");

            return CreatedAtAction(nameof(GetById), new { id = product.Id }, product);
        }

        [HttpPost("{productId}/reviews")]
        public IActionResult AddReview(string productId, Review reviewInput)
        {
            Response.Headers.Add("Access-Control-Allow-Origin", "*");

            if (!ObjectId.TryParse(productId, out _))
            {
                return BadRequest("Invalid ID format"); // Return 400 Bad Request response
            }

            if (!_productService.ProductExists(productId))
            {
                return NotFound();
            }

            var review = new Review
            {
                Rating = reviewInput.Rating,
                Comment = reviewInput.Comment,
                UserId = reviewInput.UserId,
                UserName = reviewInput.UserName,
                DateTime = DateTime.UtcNow
            };

            _productService.AddReview(productId, review);

            return Ok();
        }
    }
}
