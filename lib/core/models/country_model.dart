/// Model object to hold the Country data
class CountryModel {
  /// Instantiates an [CountryModel] with the specified [name], and [countryCode]
  const CountryModel({
    required this.name,
    required this.countryCode,
  });

  /// the 2-letter ISO code
  final String countryCode;

  /// Country name
  final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryModel &&
          runtimeType == other.runtimeType &&
          countryCode == other.countryCode;

  @override
  int get hashCode => countryCode.hashCode;
}
