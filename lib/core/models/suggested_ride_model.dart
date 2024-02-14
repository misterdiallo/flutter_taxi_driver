import 'package:flutter/material.dart';

class SuggestedRideModel {
  final String vehicleType;
  final String? farePrice;
  final String? argument;
  final String? duration;
  final Widget image;
  bool selected;

  SuggestedRideModel({
    required this.vehicleType,
    this.farePrice,
    this.argument,
    this.duration,
    required this.image,
    required this.selected,
  });
}
