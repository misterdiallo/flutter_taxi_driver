import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:taxi_driver_app/router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lotties/error.json', // Replace with your Lottie animation file path
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text("An error occured, please refresh the app."),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
              ),
              onPressed: () {
                Get.offAllNamed(InitialRoute);
              },
              child: const Text(
                "Refresh",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
