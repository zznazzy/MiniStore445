namespace MiniStoreWeb.Models
{
    public sealed class ProductRecord
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string Category { get; set; }

        public decimal Price { get; set; }

        public string Description { get; set; }

        public string Image { get; set; }

        public bool InStock { get; set; }

        public bool Featured { get; set; }

        public int StockQuantity { get; set; }

        public bool IsPurchasable
        {
            get { return InStock && StockQuantity > 0; }
        }
    }
}
