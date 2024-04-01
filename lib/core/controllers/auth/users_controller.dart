import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  final SupabaseClient supabaseClient = Supabase.instance.client;
  RxInt totalDriver = 0.obs;
  RxInt totalAdmin = 0.obs;
  RxInt totalCustomer = 0.obs;
  RxList<UserModel> allCustomers = RxList<UserModel>();
  RxList<UserModel> allDrivers = RxList<UserModel>();
  RxList<UserModel> allAdmins = RxList<UserModel>();

  countUsers(UserType userType) async {
    final data = await authController.getAllUsers(type: userType);
    if (data != null) {
      switch (userType) {
        case UserType.driver:
          totalDriver.value = data['count'];
          break;
        case UserType.admin:
          totalAdmin.value = data['count'];
          break;
        case UserType.customer:
          totalCustomer.value = data['count'];
          break;
      }
    }
  }

  getAllTypeUsersData(UserType userType) async {
    final data = await authController.getAllUsers(type: userType);
    if (data != null) {
      switch (userType) {
        case UserType.driver:
          allDrivers.clear();
          allDrivers.addAll(data['data']);
          break;
        case UserType.admin:
          allAdmins.clear();
          allAdmins.addAll(data['data']);
          break;
        case UserType.customer:
          allCustomers.clear();
          allCustomers.addAll(data['data']);
          break;
      }
    }
  }
}
