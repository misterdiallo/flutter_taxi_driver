// ignore_for_file: non_constant_identifier_names

class PlaceModel {
  final String place_id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String? description;
  final String? photo_url;
  final String? type_place;
  final String? phone_number;
  final String? website;

  PlaceModel({
    required this.place_id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.description,
    this.photo_url,
    this.type_place,
    this.phone_number,
    this.website,
  });
  static List<PlaceModel> fromMapList(List<Map<String, dynamic>> mapList) {
    return mapList.map((map) => fromMap(map)).toList();
  }

  static PlaceModel fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      place_id: map["place_id"],
      name: map["name"],
      address: map["address"],
      latitude: map["latitude"].toDouble(),
      longitude: map["longitude"].toDouble(),
      description: map["description"],
      photo_url: map["photo_url"],
      type_place: map["type_place"],
      phone_number: map["phone_number"],
      website: map["website"],
    );
  }
}
