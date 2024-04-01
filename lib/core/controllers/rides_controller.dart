import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/ride_model.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';
import 'package:get/get.dart';

class RidesController extends GetxController {
  static RidesController instance = Get.find();
  final SupabaseClient supabaseClient = Supabase.instance.client;
  RxList<RideModel> allRides = RxList<RideModel>();

  getAllRides() async {
    print("get All rides");
    await supabaseController.getAll("rides").then((resp) {
      if (resp == null) {
        allRides.value = [];

        print(resp);
      } else {
        print(resp);
      }
    });
    return allRides;
  }
}
