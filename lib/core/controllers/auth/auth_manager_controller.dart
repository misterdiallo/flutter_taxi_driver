import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/router.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final authStore = GetStorage();
  final SupabaseClient supabaseClient = Supabase.instance.client;

  bool get isLoggedInUser => authStore.read("isLoggedInUser") ?? false;
  void setIsLoggedInUser(bool val) => authStore.write("isLoggedInUser", val);
  String? get token => authStore.read("token");
  void setToken(String val) => authStore.write("token", val);
  int? get tokenValidTill => authStore.read("tokenValidTill");
  void setTokenValidTill(int val) => authStore.write("tokenValidTill", val);
  bool get isDriver => authStore.read("isDriver") ?? false;
  void setIsDriver(bool val) => authStore.write("isDriver", val);
  bool get isAdmin => authStore.read("isAdmin") ?? false;
  void setIsAdmin(bool val) => authStore.write("isAdmin", val);
  bool get isCustomer => authStore.read("isCustomer") ?? false;
  void setIsCustomer(bool val) => authStore.write("isCustomer", val);

  String? get fullName => authStore.read("fullName");
  void setFullName(String val) => authStore.write("fullName", val);
  String? get email => authStore.read("email");
  void setEmail(String val) => authStore.write("email", val);
  String? get phoneNumber => authStore.read("phoneNumber");
  void setPhoneNumber(String val) => authStore.write("phoneNumber", val);
  String? get userId => authStore.read("userId");
  void setUserId(String userId) => authStore.write("userId", userId);
  String? get userType => authStore.read("userType");
  void setUserType(UserType userType) =>
      authStore.write("userType", userType.name);

  String? checkLoginAndRouteUser() {
    if (isLoggedInUser) {
      if (isCustomer) {
        return CustomerRoute;
      } else if (isDriver) {
        return DriverRoute;
      } else if (isAdmin) {
        return AdminRoute;
      } else {
        return null;
      }
    } else {
      return UnAuthenticatedPageRoute;
    }
  }

  /// PROFILE FROM DB
  Future<bool> getProfile() async {
    try {
      final userId = supabaseClient.auth.currentUser!.id;
      final data = await supabaseClient
          .from('users')
          .select()
          .eq('user_id', userId)
          .single();
      UserType userType =
          UserTypeExtension.fromMap(data['user_type'].toString().toLowerCase());
      authController.setUserId(data['user_id']);
      authController.setUserType(userType);
      authController.setIsCustomer(userType == UserType.customer);
      authController.setIsDriver(userType == UserType.driver);
      authController.setIsAdmin(userType == UserType.admin);
      authController.setFullName(data['full_name']);
      authController.setPhoneNumber(data['phone_number']);
      authController.setEmail(data['email']);
      authController.setIsLoggedInUser(true);
      return true;
    } on PostgrestException catch (error) {
      Get.snackbar(
        'Authentication Error',
        error.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return false;
    } catch (error) {
      Get.snackbar(
        'Authentication Error',
        error.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );

      return false;
    }
  }

  /// PROFILE A USER FROM DB
  Future<UserModel?> getUserFromDB(String email,
      {UserType type = UserType.customer}) async {
    try {
      final data = await supabaseClient
          .from('users')
          .select()
          .eq('email', email.toLowerCase())
          .eq('user_type', type.name.toLowerCase())
          .maybeSingle();
      print(data.toString());
      if (data == null) {
        return null;
      }
      UserType userType =
          UserTypeExtension.fromMap(data['user_type'].toString().toLowerCase());
      UserModel userModel = UserModel(
        user_id: data['user_id'],
        full_name: data['full_name'],
        email: 'email',
        phone_number: data['phone_number'],
        user_type: userType,
      );
      return userModel;
    } on PostgrestException catch (error) {
      Get.snackbar(
        'Check Info Error',
        error.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return null;
    } catch (error) {
      Get.snackbar(
        'Check Info Error',
        error.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return null;
    }
  }

  ///  ALL USER FROM DB
  Future<Map<String, dynamic>?> getAllUsers(
      {UserType type = UserType.customer}) async {
    try {
      final res = await supabaseClient
          .from('users')
          .select('*')
          .eq("user_type", type.name.toLowerCase())
          .count(CountOption.exact);
      final data = res.data;
      final count = res.count;
      if (count < 1 || data.isEmpty) {
        return null;
      }

      return {
        'count': count,
        'data': UserModelExtension.convertToUserModelList(data)
      };
    } on PostgrestException catch (error) {
      Get.snackbar(
        'Check Info Error',
        error.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return null;
    } catch (error) {
      Get.snackbar(
        'Check Info Error',
        error.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return null;
    }
  }

  UserModel? getUserModel() {
    if (userId != null &&
        fullName != null &&
        email != null &&
        phoneNumber != null &&
        userType != null) {
      return UserModel(
        user_id: userId!,
        full_name: fullName!,
        email: email!,
        phone_number: phoneNumber!,
        user_type: UserType.customer.name == userType!
            ? UserType.customer
            : UserType.driver.name == userType!
                ? UserType.driver
                : UserType.admin,
      );
    }
    return null;
  }

  logoutUser() async {
    await loginController.logout();
    authStore.erase();
    Get.offAllNamed(checkLoginAndRouteUser().toString());
  }
}
