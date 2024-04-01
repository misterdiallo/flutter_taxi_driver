import 'package:taxi_driver_app/core/models/user/user_type_model.dart';

import 'user/user_model.dart';

class CarModel {
  final String car_id;
  final String license_number;
  final String model;
  final String plate_number;
  final String color;
  final UserModel user;

  CarModel({
    required this.car_id,
    required this.license_number,
    required this.model,
    required this.plate_number,
    required this.color,
    required this.user,
  });
  static List<CarModel> fromMapList(List<Map<String, dynamic>> mapList) {
    return mapList.map((map) => fromMap(map)).toList();
  }

  static CarModel fromMap(Map<String, dynamic> map) {
    return CarModel(
      car_id: map['car_id'],
      license_number: map['license_number'],
      model: map['model'],
      plate_number: map['plate_number'],
      color: map['color'],
      user: UserModel(
        user_id: map['users']['user_id'],
        full_name: map['users']['full_name'],
        email: map['users']['email'],
        phone_number: map['users']['phone_number'],
        user_type: UserTypeExtension.fromMap(
            map['users']['user_type'].toString().toLowerCase()),
      ),
    );
  }
}
