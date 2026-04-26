namespace MiniStoreWeb.Models
{
    public sealed class StoreCartItemView
    {
        public int ProductId { get; set; }

        public string Name { get; set; }

        public string Category { get; set; }

        public string Description { get; set; }

        public string Image { get; set; }

        public decimal UnitPrice { get; set; }

        public int Quantity { get; set; }

        public bool InStock { get; set; }

        public int StockQuantity { get; set; }

        public bool CanIncreaseQuantity { get; set; }

        public int RemainingAvailableQuantity { get; set; }

        public decimal LineTotal
        {
            get { return UnitPrice * Quantity; }
        }
    }
}
