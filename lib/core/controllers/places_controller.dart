import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/place_model.dart';
import 'package:get/get.dart';

class PlacesController extends GetxController {
  static PlacesController instance = Get.find();
  final SupabaseClient supabaseClient = Supabase.instance.client;
  RxList<PlaceModel> allPlaces = RxList<PlaceModel>();

  getAllPlaces() async {
    print("get All Place");
    await supabaseController.getAll("places").then((resp) {
      if (resp == null) {
        allPlaces.value = [];
      } else {
        allPlaces.clear();
        allPlaces.addAll(PlaceModel.fromMapList(resp));
      }
    });
    return allPlaces;
  }

  Future<bool> addNewPlace(PlaceModel place) async {
    final data = {
      'name': place.name,
      'address': place.address,
      'latitude': place.latitude,
      'longitude': place.longitude,
      'description': place.description,
      'photo_url': place.photo_url,
      'type_place': place.type_place,
      'phone_number': place.phone_number,
      'website': place.website,
    };
    return await supabaseController.insert('places', data).then((value) async {
      if (value) {
        await getAllPlaces();
        return true;
      } else {
        return false;
      }
    });
  }

  Future<bool> editPlace(PlaceModel place) async {
    final data = {
      'name': place.name,
      'address': place.address,
      'latitude': place.latitude,
      'longitude': place.longitude,
      'description': place.description,
      'photo_url': place.photo_url,
      'type_place': place.type_place,
      'phone_number': place.phone_number,
      'website': place.website,
    };
    return await supabaseController
        .edit('places', data, "place_id", place.place_id)
        .then((value) async {
      if (value) {
        await getAllPlaces();
        return true;
      } else {
        return false;
      }
    });
  }
}
