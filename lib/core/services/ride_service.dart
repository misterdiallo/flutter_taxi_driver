import 'package:taxi_driver_app/core/services/car_service.dart';
import 'package:taxi_driver_app/core/services/place_service.dart';
import 'package:taxi_driver_app/core/services/user_service.dart';

import '../models/place_model.dart';
import '../models/ride_model.dart';
import '../models/user/user_model.dart';

List<RideModel> rideList = [
  RideModel(
    rideId: '1',
    user: users.first,
    driver: users.last,
    fare: '10 RMB',
    startTime: DateTime.now(),
    endTime: DateTime.now(),
    rideOriginPlace: listPlaces[2],
    rideEndPlace: listPlaces[4],
    rideStatus: RideStatus.pending,
    car: carList.last,
    createdAt: DateTime.now(),
  ),
  RideModel(
    rideId: '2',
    user: users.last,
    driver: users.first,
    fare: '32 RMB',
    startTime: DateTime.now(),
    rideOriginPlace: listPlaces[4],
    rideEndPlace: listPlaces[3],
    rideStatus: RideStatus.pending,
    car: carList.first,
    createdAt: DateTime.now(),
  ),
];
