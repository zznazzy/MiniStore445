using System;

namespace BellaStoreService
{
    public class Service1 : IService1
    {
        public decimal GetDiscountedTotal(decimal subtotal, string couponCode)
        {
            if (subtotal < 0)
            {
                subtotal = 0;
            }

            decimal discountPercent = GetDiscountPercent(couponCode);
            decimal total = subtotal * (1 - discountPercent);

            return Math.Round(total, 2);
        }

        public string GetCouponDescription(string couponCode)
        {
            string normalized = NormalizeCoupon(couponCode);

            switch (normalized)
            {
                case "SAVE10":
                    return "SAVE10 applies a 10% discount.";
                case "STUDENT15":
                    return "STUDENT15 applies a 15% discount.";
                case "VIP20":
                    return "VIP20 applies a 20% discount.";
                default:
                    return "No valid coupon applied.";
            }
        }

        private decimal GetDiscountPercent(string couponCode)
        {
            string normalized = NormalizeCoupon(couponCode);

            switch (normalized)
            {
                case "SAVE10":
                    return 0.10m;
                case "STUDENT15":
                    return 0.15m;
                case "VIP20":
                    return 0.20m;
                default:
                    return 0.00m;
            }
        }

        private string NormalizeCoupon(string couponCode)
        {
            return (couponCode ?? string.Empty).Trim().ToUpperInvariant();
        }
    }
}