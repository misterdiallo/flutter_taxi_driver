import 'package:taxi_driver_app/core/services/car_service.dart';
import 'package:taxi_driver_app/core/services/place_service.dart';
import 'package:taxi_driver_app/core/services/user_service.dart';

import '../models/place_model.dart';
import '../models/ride_model.dart';
import '../models/user/user_model.dart';

List<RideModel> rideList = [
  RideModel(
    ride_id: '1',
    user: users.first,
    driver: users.last,
    fare: '10 RMB',
    start_time: DateTime.now(),
    end_time: DateTime.now(),
    ride_origin_place: listPlaces[2],
    ride_end_place: listPlaces[4],
    ride_status: RideStatus.pending,
    car: carList.last,
    createdAt: DateTime.now(),
  ),
  RideModel(
    ride_id: '2',
    user: users.last,
    driver: users.first,
    fare: '32 RMB',
    start_time: DateTime.now(),
    ride_origin_place: listPlaces[4],
    ride_end_place: listPlaces[3],
    ride_status: RideStatus.pending,
    car: carList.first,
    createdAt: DateTime.now(),
  ),
];
