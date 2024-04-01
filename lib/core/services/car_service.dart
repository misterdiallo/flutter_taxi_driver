import 'package:taxi_driver_app/ui/utils/plate_gen.dart';

import '../models/car_model.dart';
import '../models/user/user_model.dart';
import '../models/user/user_type_model.dart';

List<CarModel> carList = [
  CarModel(
    car_id: "1",
    license_number: "ABC123",
    model: "Sedan",
    plate_number: generateChinesePlateNumber("鲁"),
    color: "Blue",
    user: UserModel(
      user_id: "2",
      full_name: "Jane Smith",
      email: "jane.smith@example.com",
      phone_number: "9876543210",
      // password: "9876543210",
      user_type: UserType.driver,
    ),
  ),
  CarModel(
    car_id: "2",
    license_number: "DEF456",
    model: "SUV",
    plate_number: generateChinesePlateNumber("鲁"),
    color: "Red",
    user: UserModel(
      user_id: "3",
      full_name: "Michael Johnson",
      email: "michael.johnson@example.com",
      phone_number: "5556667777",
      // password: "5556667777",
      user_type: UserType.driver,
    ),
  ),
  // Add more instances as needed
];
