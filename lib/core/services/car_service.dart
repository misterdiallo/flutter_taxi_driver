import 'package:taxi_driver_app/ui/utils/plate_gen.dart';

import '../models/car_model.dart';
import '../models/user/user_model.dart';
import '../models/user/user_type_model.dart';

List<CarModel> carList = [
  CarModel(
    carId: "1",
    licenseNumber: "ABC123",
    model: "Sedan",
    plateNumber: generateChinesePlateNumber("鲁"),
    color: "Blue",
    user: UserModel(
      userId: "2",
      fullName: "Jane Smith",
      email: "jane.smith@example.com",
      phoneNumber: "9876543210",
      // password: "9876543210",
      userType: UserType.driver,
    ),
  ),
  CarModel(
    carId: "2",
    licenseNumber: "DEF456",
    model: "SUV",
    plateNumber: generateChinesePlateNumber("鲁"),
    color: "Red",
    user: UserModel(
      userId: "3",
      fullName: "Michael Johnson",
      email: "michael.johnson@example.com",
      phoneNumber: "5556667777",
      // password: "5556667777",
      userType: UserType.driver,
    ),
  ),
  // Add more instances as needed
];
