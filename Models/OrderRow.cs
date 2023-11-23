using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace OrderMicroservice.Models
{
    public class OrderRow
    {
        [Key]
        public int OrderRowId { get; set; }

        [Required]
        public DateTime Created { get; set; }
        public int OrderId { get; set; }

        public int ProductId { get; set; }

        public int Quantity { get; set; }
        public decimal Price { get; set; }

        [ForeignKey("OrderId")]
        public Order Order { get; set; }
    }
}