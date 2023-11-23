using System.ComponentModel.DataAnnotations;

namespace OrderMicroservice.Models
{
    public class Product
    {
        [Key]
        public int ExternalProductId { get; set; }
        public DateTime Created { get; set; }
    }
}