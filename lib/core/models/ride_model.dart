import 'package:taxi_driver_app/core/models/car_model.dart';
import 'package:taxi_driver_app/core/models/place_model.dart';
import 'package:taxi_driver_app/core/models/rating_model.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';

enum RideStatus {
  pending,
  accepted,
  ongoing,
  completed,
  canceled,
}

class RideModel {
  final String rideId;
  final UserModel user;
  final UserModel driver;
  final String fare;
  final DateTime startTime;
  final DateTime? endTime;
  final CarModel? car;
  final RatingModel? userRating;
  final RatingModel? driverRating;
  final PlaceModel rideOriginPlace;
  final PlaceModel rideEndPlace;
  final RideStatus rideStatus;
  final DateTime createdAt;
  final DateTime? updatedAt;

  RideModel({
    required this.rideId,
    required this.user,
    required this.driver,
    required this.fare,
    required this.startTime,
    this.endTime,
    required this.car,
    this.userRating,
    this.driverRating,
    required this.rideOriginPlace,
    required this.rideEndPlace,
    required this.rideStatus,
    required this.createdAt,
    this.updatedAt,
  });

  RideModel updateRideStatus(RideStatus newStatus, {DateTime? updateTime}) {
    return RideModel(
      rideId: rideId,
      user: user,
      driver: driver,
      fare: fare,
      startTime: startTime,
      endTime: endTime,
      car: car,
      userRating: userRating,
      driverRating: driverRating,
      rideOriginPlace: rideOriginPlace,
      rideEndPlace: rideEndPlace,
      rideStatus: newStatus,
      createdAt: createdAt,
      updatedAt: updateTime ?? DateTime.now(),
    );
  }
}
