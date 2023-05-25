using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ShoppingAssistant.Api.Models;
using ShoppingAssistant.Api.Services;

namespace ShoppingAssistant.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {

        public ProductController() { }

        [HttpGet]
        public async Task<IEnumerable<Product>> GetProduct()
        {
            var productService = new ProductService();

            return await productService.GetAllProductsAsync();
        }

        [HttpGet("id")]
        public async Task<IActionResult> GetById(string id)
        {
            var productService = new ProductService();

            var product = productService.GetProductAsync(id);

            return product == null ? NotFound() : Ok(product);
        }

        [HttpPost]
        public async Task<IActionResult> Create(Product product)
        {
            var productService = new ProductService();

            productService.AddProduct(product);

            return CreatedAtAction(nameof(GetById), new { id = product.Id }, product);
        }
    }
}
