import 'user/user_type_model.dart';

class RatingModel {
  final String userId;
  final UserType userType;
  final DateTime date;
  final double rating;
  final String comment;

  RatingModel({
    required this.userId,
    required this.userType,
    required this.date,
    required this.rating,
    required this.comment,
  });
}
