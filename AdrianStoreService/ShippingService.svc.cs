namespace AdrianStoreService
{
    public class ShippingService : IShippingService
    {
        public decimal CalculateShipping(decimal subtotal, string region)
        {
            if (subtotal >= 50m)
            {
                return 0m;
            }

            decimal baseRate = 5m;
            string normalized = (region ?? string.Empty).Trim().ToUpperInvariant();

            switch (normalized)
            {
                case "US":
                case "DOMESTIC":
                    return baseRate;
                case "CA":
                case "CANADA":
                    return baseRate + 5m;
                case "INTL":
                case "INTERNATIONAL":
                    return baseRate + 10m;
                default:
                    return baseRate + 10m;
            }
        }
    }
}
