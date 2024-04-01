// ignore_for_file: non_constant_identifier_names

import 'package:taxi_driver_app/core/models/car_model.dart';
import 'package:taxi_driver_app/core/models/place_model.dart';
import 'package:taxi_driver_app/core/models/rating_model.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';

import 'user/user_type_model.dart';

class RideModel {
  final String ride_id;
  final UserModel user;
  final UserModel driver;
  final String fare;
  final DateTime start_time;
  final DateTime? end_time;
  final CarModel? car;
  final RatingModel? user_rating;
  final RatingModel? driver_rating;
  final PlaceModel ride_origin_place;
  final PlaceModel ride_end_place;
  final RideStatus ride_status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  RideModel({
    required this.ride_id,
    required this.user,
    required this.driver,
    required this.fare,
    required this.start_time,
    this.end_time,
    required this.car,
    this.user_rating,
    this.driver_rating,
    required this.ride_origin_place,
    required this.ride_end_place,
    required this.ride_status,
    required this.createdAt,
    this.updatedAt,
  });

  RideModel updateRideStatus(RideStatus newStatus, {DateTime? updateTime}) {
    return RideModel(
      ride_id: ride_id,
      user: user,
      driver: driver,
      fare: fare,
      start_time: start_time,
      end_time: end_time,
      car: car,
      user_rating: user_rating,
      driver_rating: driver_rating,
      ride_origin_place: ride_origin_place,
      ride_end_place: ride_end_place,
      ride_status: newStatus,
      createdAt: createdAt,
      updatedAt: updateTime ?? DateTime.now(),
    );
  }

  static List<RideModel> fromMapList(List<Map<String, dynamic>> mapList) {
    return mapList.map((map) => fromMap(map)).toList();
  }

  static RideModel fromMap(Map<String, dynamic> map) {
    return RideModel(
      ride_id: map['ride_id'],
      user: UserModel(
        user_id: map['users']['user_id'],
        full_name: map['users']['full_name'],
        email: map['users']['email'],
        phone_number: map['users']['phone_number'],
        user_type: UserTypeExtension.fromMap(
            map['users']['user_type'].toString().toLowerCase()),
      ),
      driver: UserModel(
        user_id: map['drivers']['user_id'],
        full_name: map['drivers']['full_name'],
        email: map['drivers']['email'],
        phone_number: map['drivers']['phone_number'],
        user_type: UserTypeExtension.fromMap(
            map['drivers']['user_type'].toString().toLowerCase()),
      ),
      fare: map['fare'],
      start_time: map['start_time'],
      car: CarModel(
        car_id: map['cars']['car_id'],
        license_number: map['cars']['license_number'],
        model: map['cars']['model'],
        plate_number: map['cars']['plate_number'],
        color: map['cars']['color'],
        user: UserModel(
          user_id: map['users']['user_id'],
          full_name: map['users']['full_name'],
          email: map['users']['email'],
          phone_number: map['users']['phone_number'],
          user_type: UserTypeExtension.fromMap(
              map['users']['user_type'].toString().toLowerCase()),
        ),
      ),
      ride_origin_place: PlaceModel(
        place_id: map['origin']['place_id'],
        name: map['origin']['name'],
        address: map['origin']['address'],
        latitude: double.parse(map['origin']['latitude']),
        longitude: double.parse(map['origin']['longitude']),
      ),
      ride_end_place: PlaceModel(
        place_id: map['destination']['place_id'],
        name: map['destination']['name'],
        address: map['destination']['address'],
        latitude: double.parse(map['destination']['latitude']),
        longitude: double.parse(map['destination']['longitude']),
      ),
      ride_status: RideStatusExtention.fromMap(
          map['ride_status'].toString().toLowerCase()),
      createdAt: map['createdAt'],
    );
  }
}

enum RideStatus {
  pending,
  accepted,
  ongoing,
  completed,
  canceled,
}

extension RideStatusExtention on RideStatus {
  String toMap() {
    return toString().split('.').last;
  }

  static RideStatus fromMap(String value) {
    switch (value) {
      case 'accepted':
        return RideStatus.accepted;
      case 'pending':
        return RideStatus.pending;
      case 'ongoing':
        return RideStatus.ongoing;
      case 'completed':
        return RideStatus.completed;
      case 'canceled':
        return RideStatus.canceled;
      default:
        return RideStatus.pending;
    }
  }
}
