import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/router.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final authStore = GetStorage();

  bool get isLoggedInUser => authStore.read("isLoggedInUser") ?? false;
  void setIsLoggedInUser(bool val) => authStore.write("isLoggedInUser", val);
  String? get token => authStore.read("token");
  void setToken(String val) => authStore.write("token", val);
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

  void logOut() => authStore.erase();

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

  UserModel? getUserModel() {
    if (userId != null &&
        fullName != null &&
        email != null &&
        phoneNumber != null &&
        userType != null) {
      return UserModel(
        userId: userId!,
        fullName: fullName!,
        email: email!,
        phoneNumber: phoneNumber!,
        userType: UserType.customer.name == userType!
            ? UserType.customer
            : UserType.driver.name == userType!
                ? UserType.driver
                : UserType.admin,
      );
    }
    return null;
  }

  logoutUser() {
    logOut();
    checkLoginAndRouteUser();
  }
}
