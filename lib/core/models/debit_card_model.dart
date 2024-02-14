import 'package:flutter/material.dart';

class DebitCardModel {
  final Image logo;
  final String lastDigits;
  final String expiry;
  DebitCardModel({
    required this.logo,
    required this.lastDigits,
    required this.expiry,
  });
}
