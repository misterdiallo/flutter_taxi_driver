import 'package:flutter/material.dart';

Color getColorFromName(String colorName) {
  switch (colorName.toLowerCase()) {
    case 'red':
      return Colors.red;
    case 'green':
      return Colors.green;
    case 'blue':
      return Colors.blue;
    case 'yellow':
      return Colors.yellow;
    case 'orange':
      return Colors.orange;
    case 'purple':
      return Colors.purple;
    case 'pink':
      return Colors.pink;
    case 'cyan':
      return Colors.cyan;
    case 'teal':
      return Colors.teal;
    case 'amber':
      return Colors.amber;
    case 'brown':
      return Colors.brown;
    case 'grey':
      return Colors.grey;
    default:
      throw ArgumentError('Invalid color name: $colorName');
  }
}
