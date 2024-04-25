import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController extends GetxController {
  RxList<ConnectivityResult> connectionStatus = [ConnectivityResult.none].obs;
  final Connectivity _connectivity = Connectivity();
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    // Start the timer to check connectivity every 30 seconds
    _timer = Timer.periodic(const Duration(seconds: 60), (_) {
      initConnectivity();
    });
  }

  @override
  void onClose() {
    // Cancel the timer when the controller is closed
    _timer.cancel();
    super.onClose();
  }

  Future<void> initConnectivity() async {
    try {
      List<ConnectivityResult> result = await _connectivity.checkConnectivity();
      // _updateConnectionStatus(result);
    } catch (e) {
      // Delay execution of snackbar to ensure overlay is configured
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.snackbar(
          'Network Error',
          'Couldn\'t check connectivity status: $e',
          backgroundColor: Colors.red[900],
          colorText: Colors.white,
        );
      });
      print(e);
    }
  }

  // void _updateConnectionStatus(List<ConnectivityResult> result) {
  //   connectionStatus.value = result;
  //   // Delay execution of snackbar to ensure overlay is configured
  //   Future.delayed(const Duration(milliseconds: 100), () {
  //     Get.snackbar(
  //       'Network',
  //       'Connectivity changed: ${connectionStatus.}',
  //       backgroundColor: Colors.green[900],
  //       colorText: Colors.white,
  //     );
  //   });
  // }
}
