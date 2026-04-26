using System;
using System.Collections.Generic;

namespace MiniStoreWeb.Models
{
    public sealed class FakeOrderReceipt
    {
        public string Username { get; set; }

        public string OrderNumber { get; set; }

        public DateTime CreatedAt { get; set; }

        public string PaymentMethod { get; set; }

        public string Region { get; set; }

        public string CouponCode { get; set; }

        public string CouponDescription { get; set; }

        public decimal Subtotal { get; set; }

        public decimal DiscountAmount { get; set; }

        public decimal DiscountedSubtotal { get; set; }

        public decimal ShippingCost { get; set; }

        public decimal FinalTotal { get; set; }

        public List<StoreCartItemView> Items { get; set; }
    }
}
