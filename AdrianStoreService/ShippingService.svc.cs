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
            if (!string.IsNullOrEmpty(region) && region.Trim().ToUpperInvariant() != "US")
            {
                baseRate += 10m;
            }

            return baseRate;
        }
    }
}
