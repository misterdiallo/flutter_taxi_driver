import 'dart:convert';

import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:taxi_driver_app/core/controllers/users/user_provider.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  final isLoading = false.obs;
  final UserProvider userProvider = Get.find();

  @override
  Future<void> onInit() async {
    super.onInit();
    // await getAllUsers();
  }

  // ----- INTERNAL ----------
  String? getLoginResponseToken(Response apiResponse) {
    if (apiResponse.hasError) {
      return null;
    }
    if (apiResponse.isOk &&
        apiResponse.statusCode == 200 &&
        !(json.decode(apiResponse.body)['token'].isBlank)) {
      return json.decode(apiResponse.body)['token'].toString();
    }
    return null;
  }

  UserType? getTokenDataInfo(String token) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['role'].toString() == UserType.admin.name
        ? UserType.admin
        : payload['role'].toString() == UserType.customer.name
            ? UserType.customer
            : payload['role'].toString() == UserType.driver.name
                ? UserType.driver
                : null;
  }

  // ----- API CALL----------

  Future<Response> loginUser(LoginUserRequest userRequest) async {
    isLoading.value = true;
    try {
      var response = await userProvider.loginUser(userRequest);
      print(response.body);
      return response;
    } finally {
      isLoading.value = false;
    }
  }

  Future<Response> getAllUsers() async {
    isLoading.value = true;
    try {
      var response = await userProvider.getAll();
      print(response.body);
      return response;
    } finally {
      isLoading.value = false;
    }
  }

  Future<Response> getUserById(String id) async {
    isLoading.value = true;
    try {
      var response = await userProvider.getById(id);
      print(response.body);
      return response;
    } finally {
      isLoading.value = false;
    }
  }

  Future<Response> createUser(UserModel user) async {
    isLoading.value = true;
    try {
      var response = await userProvider.create(user);
      print(response.body);
      return response;
    } finally {
      isLoading.value = false;
    }
  }

  Future<Response> updateUser(UserModel user) async {
    isLoading.value = true;
    try {
      var response = await userProvider.update(user);
      print(response.body);
      return response;
    } finally {
      isLoading.value = false;
    }
  }

  Future<Response> removeUser(String id) async {
    isLoading.value = true;
    try {
      var response = await userProvider.remove(id);
      print(response.body);
      return response;
    } finally {
      isLoading.value = false;
    }
  }
}
