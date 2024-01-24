using Microsoft.EntityFrameworkCore;
using OrderMicroservice.Data.Interfaces;
using OrderMicroservice.Models;

namespace OrderMicroservice.Data.Repositories
{
    public class ProductRepo : IProductRepo
    {
        private readonly AppDbContext _context;

        public ProductRepo(AppDbContext context)
        {
            _context = context;
        }

        public void CreateProduct(Product product)
        {
            if (product == null)
            {
                throw new ArgumentNullException(nameof(product));
            }

            _context.Products.Add(product);
            _context.SaveChanges();
        }

        public void DeleteProduct(Product product)
        {
            if (product == null)
            {
                throw new ArgumentNullException(nameof(product));
            }

            _context.Products.Remove(product);
            _context.SaveChanges();
        }

        public Product GetProductById(int productId)
        {
            return _context.Products.FirstOrDefault(p => p.ExternalProductId == productId);
        }

        public async Task<bool> SaveChangesAsync()
        {
            return await _context.SaveChangesAsync() >= 0;
        }
    }
}