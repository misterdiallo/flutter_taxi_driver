import 'user/user_model.dart';

class CarModel {
  final String carId;
  final String licenseNumber;
  final String model;
  final String plateNumber;
  final String color;
  final UserModel user;

  CarModel({
    required this.carId,
    required this.licenseNumber,
    required this.model,
    required this.plateNumber,
    required this.color,
    required this.user,
  });
}
