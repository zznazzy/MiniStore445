namespace MiniStoreWeb.Models
{
    public sealed class CheckoutPricingSummary
    {
        public int ItemCount { get; set; }

        public decimal Subtotal { get; set; }

        public decimal DiscountedSubtotal { get; set; }

        public decimal DiscountAmount { get; set; }

        public decimal? ShippingCost { get; set; }

        public decimal FinalTotal { get; set; }

        public string CouponCode { get; set; }

        public string CouponDescription { get; set; }

        public string Region { get; set; }
    }
}
