class PlaceModel {
  final String placeId;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String? description;
  final String? photoUrl;
  final String? typePlace;
  final String? phoneNumber;
  final String? website;

  PlaceModel({
    required this.placeId,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.description,
    this.photoUrl,
    this.typePlace,
    this.phoneNumber,
    this.website,
  });
}
