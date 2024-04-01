import 'package:taxi_driver_app/core/controllers/controllers.dart';

import '../models/user/user_model.dart';
import '../models/user/user_type_model.dart';

// List<UserModel>? listUser = authController.getAllUsers().then((value) => value);

// set users

List<UserModel> users = [
  UserModel(
    user_id: 'user000001',
    full_name: 'Abriko',
    email: 'abriko@gmail.com',
    phone_number: '8618354919286',
    user_type: UserType.customer,
  ),
  UserModel(
    user_id: 'Admin',
    full_name: 'Admin',
    email: 'admin@gmail.com',
    phone_number: '123456',
    user_type: UserType.admin,
  ),
  UserModel(
    user_id: "101",
    full_name: "Driver 1",
    email: "driver1@example.com",
    phone_number: "1112223333",
    // password: "1112223333",
    user_type: UserType.driver,
  ),
  UserModel(
    user_id: "102",
    full_name: "Driver 2",
    email: "driver2@example.com",
    phone_number: "4445556666",
    // password: "4445556666",
    user_type: UserType.driver,
  ),
  UserModel(
    user_id: "103",
    full_name: "Driver 3",
    email: "driver3@example.com",
    phone_number: "7778889999",
    // password: "7778889999",
    user_type: UserType.driver,
  ),
  UserModel(
    user_id: "104",
    full_name: "Driver 4",
    email: "driver4@example.com",
    phone_number: "1239876543",
    // password: "1239876543",
    user_type: UserType.driver,
  ),
];
