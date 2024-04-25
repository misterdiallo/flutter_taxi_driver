import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';
import 'package:taxi_driver_app/router.dart';

class LoginController extends GetxController {
  static LoginController instance = Get.find();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  final RxBool isLoading = false.obs;
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  // Define a FocusNode
  // Function to hide keyboard
  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
  }

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;
    // Check if email and password are not empty
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Email and Password are required',
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return;
    }

    // Check email format
    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Error',
        'Invalid email format',
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return;
    }

    // Check password length
    if (password.length < 4) {
      Get.snackbar(
        'Error',
        'Password length limit',
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email.toLowerCase(),
        password: password,
      );
      var accessToken = response.session!.accessToken;
      var expiresAt = response.session!.expiresAt;
      authController.setTokenValidTill(expiresAt!);
      authController.setToken(accessToken);
      Get.snackbar(
        'Success',
        'Logged in successfully',
        backgroundColor: Colors.green[900],
        colorText: Colors.white,
      );
      isLoading.value = false;
      await authController.getProfile().then((value) {
        value ? Get.offAllNamed(InitialRoute) : null;
      });
    } on AuthException catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      print(e);
    }
  }

  Future<void> register() async {
    final email = emailController.text;
    final password = passwordController.text;
    final fullname = fullNameController.text;
    final phonenumber = phoneController.text;
    // Check if email and password are not empty
    if (email.isEmpty ||
        password.isEmpty ||
        phonenumber.isEmpty ||
        fullname.isEmpty) {
      Get.snackbar(
        'Error',
        'All the field are required',
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return;
    }

    // Check email format
    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Error',
        'Invalid email format',
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return;
    }
    // Check full format
    if (!GetUtils.isPhoneNumber(phonenumber)) {
      Get.snackbar(
        'Error',
        'Invalid phone number format',
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return;
    }

    // Check password length
    if (password.length < 6) {
      Get.snackbar(
        'Error',
        'Password length limit',
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return;
    }

    /// REGISTER
    isLoading.value = true;
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email.toLowerCase(),
        password: password,
        data: {
          "email": email.toLowerCase(),
          "password": password,
          "full_name": fullname.toLowerCase(),
          "phone_number": phonenumber,
          "is_active": true,
          "user_type": UserType.customer.name.toLowerCase(),
          "address": "",
          "date_of_birth":
              DateTime.parse("2000-01-01").toUtc().toIso8601String(),
        },
      );
      isLoading.value = false;
      Get.snackbar(
        'Success',
        'Sign Up success',
        backgroundColor: Colors.green[900],
        colorText: Colors.white,
      );
      Get.toNamed(LoginRoute);
    } on AuthException catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
    }
  }
}
