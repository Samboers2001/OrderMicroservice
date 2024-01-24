using OrderMicroservice.Models;
using System.Threading.Tasks;

namespace OrderMicroservice.Data.Interfaces
{
    public interface IProductRepo
    {
        void CreateProduct(Product product);
        void DeleteProduct(Product product);
        Product GetProductById(int productId);
        Task<bool> SaveChangesAsync();
    }
}