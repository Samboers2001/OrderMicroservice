using System.ComponentModel.DataAnnotations;

namespace OrderMicroservice.Models
{
    public class Order
    {
        [Key]
        public int OrderId { get; set; }

        public int CustomerId { get; set; }

        [Required]
        public DateTime Created { get; set; }

        public ICollection<OrderRow> OrderRows { get; set; }
    }

}