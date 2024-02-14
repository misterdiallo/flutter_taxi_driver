class FareModel {
  final double taxi;
  final double luxe;
  FareModel({
    required this.luxe,
    required this.taxi,
  });
}

class FareCalculator {
  static FareModel calculateFare(double distance, double duration) {
    // Assuming fare rates per kilometer and per minute
    double rateTaxiPerKilometer = 6; // $0.5 per kilometer
    double rateTaxiPerMinute = 0.5; // $0.1 per minute
    double rateLuxePerKilometer = 12; // $0.5 per kilometer
    double rateLuxePerMinute = 1; // $0.1 per minute

    // Calculate fare based on distance and duration
    double fareTaxi =
        (distance * rateTaxiPerKilometer) + (duration * rateTaxiPerMinute);
    double fareLuxe =
        (distance * rateLuxePerKilometer) + (duration * rateLuxePerMinute);

    // Additional charges or discounts can be applied here if needed

    return FareModel(luxe: fareLuxe, taxi: fareTaxi);
  }
}
