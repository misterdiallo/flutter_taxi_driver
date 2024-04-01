import 'user/user_type_model.dart';

class RatingModel {
  final String rating_id;
  final String user_id;
  final UserType user_type;
  final DateTime date;
  final double rating;
  final String comment;

  RatingModel({
    required this.rating_id,
    required this.user_id,
    required this.user_type,
    required this.date,
    required this.rating,
    required this.comment,
  });
}
