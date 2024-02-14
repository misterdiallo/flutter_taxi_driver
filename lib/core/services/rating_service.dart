import '../models/rating_model.dart';
import '../models/user/user_type_model.dart';

List<RatingModel> ratingModels = [
  RatingModel(
    userId: "1",
    userType: UserType.driver,
    date: DateTime.now().subtract(const Duration(days: 5)),
    rating: 4.5,
    comment: "Good ride",
  ),
  RatingModel(
    userId: "2",
    userType: UserType.customer,
    date: DateTime.now().subtract(const Duration(days: 10)),
    rating: 4.8,
    comment: "Polite driver",
  ),
  RatingModel(
    userId: "3",
    userType: UserType.customer,
    date: DateTime.now().subtract(const Duration(days: 15)),
    rating: 4.2,
    comment: "Smooth ride",
  ),
  RatingModel(
    userId: "4",
    userType: UserType.driver,
    date: DateTime.now().subtract(const Duration(days: 20)),
    rating: 4.6,
    comment: "Friendly driver",
  ),
  RatingModel(
    userId: "5",
    userType: UserType.driver,
    date: DateTime.now().subtract(const Duration(days: 25)),
    rating: 3.9,
    comment: "Prompt service",
  ),
  RatingModel(
    userId: "6",
    userType: UserType.customer,
    date: DateTime.now().subtract(const Duration(days: 30)),
    rating: 4.0,
    comment: "Comfortable car",
  ),
  RatingModel(
    userId: "7",
    userType: UserType.driver,
    date: DateTime.now().subtract(const Duration(days: 35)),
    rating: 4.9,
    comment: "Excellent driver",
  ),
  RatingModel(
    userId: "8",
    userType: UserType.customer,
    date: DateTime.now().subtract(const Duration(days: 40)),
    rating: 3.7,
    comment: "Average experience",
  ),
  RatingModel(
    userId: "9",
    userType: UserType.customer,
    date: DateTime.now().subtract(const Duration(days: 45)),
    rating: 4.3,
    comment: "Safe journey",
  ),
  RatingModel(
    userId: "10",
    userType: UserType.driver,
    date: DateTime.now().subtract(const Duration(days: 50)),
    rating: 4.7,
    comment: "Great service overall",
  ),
];
