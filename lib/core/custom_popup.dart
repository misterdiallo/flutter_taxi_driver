// custom_popup.dart

import 'package:flutter/material.dart';
import 'package:taxi_driver_app/core/controllers/app/app_constant.dart';

import '../admin/constant.dart';

void showCustomPopup(BuildContext context, String message,
    {bool isError = false}) {
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).size.height *
          0.8, // Position at bottom of the screen
      width: MediaQuery.of(context).size.width, // Take full width
      child: Material(
        color: Colors.transparent, // Transparent background
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: isError ? Colors.red[900] : primaryColorCode,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    ),
  );

  // Add the overlay to the screen
  Overlay.of(context).insert(overlayEntry);

  // Remove the overlay after 5 seconds
  Future.delayed(const Duration(seconds: 8))
      .then((value) => overlayEntry.remove());
}
