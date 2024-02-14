import '../models/user/user_model.dart';
import '../models/user/user_type_model.dart';

// set users
List<UserModel> users = [
  UserModel(
    userId: 'user000001',
    fullName: 'Abriko',
    email: 'abriko@gmail.com',
    phoneNumber: '8618354919286',
    userType: UserType.customer,
  ),
  UserModel(
    userId: 'user000002',
    fullName: 'User02',
    email: 'user@email.com',
    phoneNumber: '123456',
    userType: UserType.customer,
  ),
  UserModel(
    userId: "101",
    fullName: "Driver 1",
    email: "driver1@example.com",
    phoneNumber: "1112223333",
    // password: "1112223333",
    userType: UserType.driver,
  ),
  UserModel(
    userId: "102",
    fullName: "Driver 2",
    email: "driver2@example.com",
    phoneNumber: "4445556666",
    // password: "4445556666",
    userType: UserType.driver,
  ),
  UserModel(
    userId: "103",
    fullName: "Driver 3",
    email: "driver3@example.com",
    phoneNumber: "7778889999",
    // password: "7778889999",
    userType: UserType.driver,
  ),
  UserModel(
    userId: "104",
    fullName: "Driver 4",
    email: "driver4@example.com",
    phoneNumber: "1239876543",
    // password: "1239876543",
    userType: UserType.driver,
  ),
];
