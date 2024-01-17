using OrderMicroservice.Models;
using System.Threading.Tasks;

namespace OrderMicroservice.Data.Interfaces
{
    public interface IProductRepo
    {
        void CreateProduct(Product product);
        Task<Product> GetProductById(int productId);
        Task<bool> SaveChangesAsync();
    }
}