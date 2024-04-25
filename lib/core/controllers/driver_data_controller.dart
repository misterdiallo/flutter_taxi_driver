import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/car_model.dart';
import 'package:taxi_driver_app/core/models/place_model.dart';
import 'package:taxi_driver_app/core/models/ride_model.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';

class DriverDataController extends GetxController {
  static DriverDataController instance = Get.find();
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  RxList<CarModel> allCars = RxList<CarModel>();

  RxList<RideModel> listAvailableRides = <RideModel>[].obs;
  RxList<RideModel> listAllMyRides = <RideModel>[].obs;
  RxList<RideModel> listAllMyCompletedRides = <RideModel>[].obs;
  List<String> listCompletedRideFare = <String>[].obs;

  RideModel? findRideByIdInTheList(
    String rideId,
    List<RideModel> list,
  ) {
    for (var ride in list) {
      if (ride.ride_id == rideId) {
        return ride;
      }
    }
    return null; // If no ride with the specified ride_id is found
  }

  Future<bool> updatedRideStatus(rideId, RideStatus rideStatus) async {
    try {
      await _supabaseClient.from("rides").update(
        {
          "ride_status": rideStatus.name.toLowerCase(),
          "driver_id": authController.getUserModel()!.user_id,
        },
      ).eq('ride_id', rideId);
      return true;
    } on PostgrestException catch (error) {
      Get.snackbar(
        duration: const Duration(seconds: 3),
        'Update Request Error',
        error.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return false;
    } catch (error) {
      Get.snackbar(
        duration: const Duration(seconds: 3),
        'Update Request Error',
        error.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return false;
    }
  }

// RIDE
  Future<RideModel?> getOneRide(String rideId) async {
    try {
      final ride = await _supabaseClient
          .from("rides")
          .select()
          .eq('ride_id', rideId)
          .single();
      if (ride.isNotEmpty) {
        CarModel car = await supabaseController
            .getOneJoind("cars", "users", 'car_id', ride['car_id'])
            .then((value) => CarModel.fromMap(value!));
        UserModel user = await _supabaseClient
            .from("users")
            .select()
            .eq("user_id", ride['user_id'])
            .single()
            .then((value) => UserModel.fromMap(value));
        UserModel driver = car.user;
        PlaceModel origin = await _supabaseClient
            .from("places")
            .select()
            .eq("place_id", ride['ride_origin_place_id'])
            .single()
            .then((value) => PlaceModel.fromMap(value));
        PlaceModel destination = await _supabaseClient
            .from("places")
            .select()
            .eq("place_id", ride['ride_end_place_id'])
            .single()
            .then((value) => PlaceModel.fromMap(value));
        RideStatus rideStatus =
            RideStatusExtention.fromMap(ride['ride_status']);
        RideModel ridecreate = RideModel(
          ride_id: ride['ride_id'],
          user: user,
          driver: driver,
          fare: ride['fare'],
          start_time: DateTime.parse(ride['start_time']),
          end_time: ride['end_time'] == null
              ? null
              : DateTime.parse(ride['end_time']),
          car: car,
          ride_origin_place: origin,
          ride_end_place: destination,
          ride_status: rideStatus,
          createdAt: DateTime.parse(ride['created_at']),
        );
        return ridecreate;
      }
    } on PostgrestException catch (error) {
      Get.snackbar(
        duration: const Duration(seconds: 3),
        'Get Request Error',
        error.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return null;
    } catch (error) {
      print(error);
      Get.snackbar(
        duration: const Duration(seconds: 3),
        'Get Request Error',
        error.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );

      return null;
    }
    return null;
  }

  // RIDE
  Future<RxList<RideModel>> getAllPendingRides() async {
    listAvailableRides.clear();
    print("Get pending rides");
    try {
      final myRides = await _supabaseClient
          .from("rides")
          .select()
          .eq('ride_status', RideStatus.pending.name)
          .order("created_at");
      if (myRides.isNotEmpty) {
        for (var ride in myRides) {
          CarModel car = await supabaseController
              .getOneJoind("cars", "users", 'car_id', ride['car_id'])
              .then((value) => CarModel.fromMap(value!));
          UserModel user = await _supabaseClient
              .from("users")
              .select()
              .eq("user_id", ride['user_id'])
              .single()
              .then((value) => UserModel.fromMap(value));
          UserModel driver = car.user;
          PlaceModel origin = await _supabaseClient
              .from("places")
              .select()
              .eq("place_id", ride['ride_origin_place_id'])
              .single()
              .then((value) => PlaceModel.fromMap(value));
          PlaceModel destination = await _supabaseClient
              .from("places")
              .select()
              .eq("place_id", ride['ride_end_place_id'])
              .single()
              .then((value) => PlaceModel.fromMap(value));
          RideStatus rideStatus =
              RideStatusExtention.fromMap(ride['ride_status']);
          RideModel ridecreate = RideModel(
            ride_id: ride['ride_id'],
            user: user,
            driver: driver,
            fare: ride['fare'],
            start_time: DateTime.parse(ride['start_time']),
            end_time: ride['end_time'] == null
                ? null
                : DateTime.parse(ride['end_time']),
            car: car,
            ride_origin_place: origin,
            ride_end_place: destination,
            ride_status: rideStatus,
            createdAt: DateTime.parse(ride['created_at']),
          );
          listAvailableRides.add(ridecreate);
        }
      }
      return listAvailableRides;
    } on PostgrestException catch (error) {
      Get.snackbar(
        duration: const Duration(seconds: 3),
        'Get Request Error',
        error.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return listAvailableRides;
    } catch (error) {
      print(error);
      Get.snackbar(
        duration: const Duration(seconds: 3),
        'Get Request Error',
        error.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );

      return listAvailableRides;
    }
  }

  // RIDE
  Future<RxList<RideModel>> getAllMyRides() async {
    listAllMyRides.clear();
    try {
      final myRides = await _supabaseClient
          .from("rides")
          .select()
          .eq('driver_id', authController.getUserModel()!.user_id)
          .order("created_at");
      if (myRides.isNotEmpty) {
        for (var ride in myRides) {
          CarModel car = await supabaseController
              .getOneJoind("cars", "users", 'car_id', ride['car_id'])
              .then((value) => CarModel.fromMap(value!));
          UserModel user = await _supabaseClient
              .from("users")
              .select()
              .eq("user_id", ride['user_id'])
              .single()
              .then((value) => UserModel.fromMap(value));
          UserModel driver = car.user;
          PlaceModel origin = await _supabaseClient
              .from("places")
              .select()
              .eq("place_id", ride['ride_origin_place_id'])
              .single()
              .then((value) => PlaceModel.fromMap(value));
          PlaceModel destination = await _supabaseClient
              .from("places")
              .select()
              .eq("place_id", ride['ride_end_place_id'])
              .single()
              .then((value) => PlaceModel.fromMap(value));
          RideStatus rideStatus =
              RideStatusExtention.fromMap(ride['ride_status']);
          RideModel ridecreate = RideModel(
            ride_id: ride['ride_id'],
            user: user,
            driver: driver,
            fare: ride['fare'],
            start_time: DateTime.parse(ride['start_time']),
            end_time: ride['end_time'] == null
                ? null
                : DateTime.parse(ride['end_time']),
            car: car,
            ride_origin_place: origin,
            ride_end_place: destination,
            ride_status: rideStatus,
            createdAt: DateTime.parse(ride['created_at']),
          );
          listAllMyRides.add(ridecreate);
        }
      }
      return listAllMyRides;
    } on PostgrestException catch (error) {
      Get.snackbar(
        duration: const Duration(seconds: 3),
        'Get Request Error',
        error.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return listAllMyRides;
    } catch (error) {
      print(error);
      Get.snackbar(
        duration: const Duration(seconds: 3),
        'Get Request Error',
        error.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return listAllMyRides;
    }
  }

  Future<Map<String, List?>> getAllCompletedMyRides() async {
    listAllMyCompletedRides.clear();
    listCompletedRideFare.clear();
    try {
      final myRides = await _supabaseClient
          .from("rides")
          .select()
          .eq('driver_id', authController.getUserModel()!.user_id)
          .eq('ride_status', RideStatus.completed.name.toLowerCase())
          .order("created_at");
      if (myRides.isNotEmpty) {
        for (var ride in myRides) {
          CarModel car = await supabaseController
              .getOneJoind("cars", "users", 'car_id', ride['car_id'])
              .then((value) => CarModel.fromMap(value!));
          UserModel user = await _supabaseClient
              .from("users")
              .select()
              .eq("user_id", ride['user_id'])
              .single()
              .then((value) => UserModel.fromMap(value));
          UserModel driver = car.user;
          PlaceModel origin = await _supabaseClient
              .from("places")
              .select()
              .eq("place_id", ride['ride_origin_place_id'])
              .single()
              .then((value) => PlaceModel.fromMap(value));
          PlaceModel destination = await _supabaseClient
              .from("places")
              .select()
              .eq("place_id", ride['ride_end_place_id'])
              .single()
              .then((value) => PlaceModel.fromMap(value));
          RideStatus rideStatus =
              RideStatusExtention.fromMap(ride['ride_status']);
          RideModel ridecreate = RideModel(
            ride_id: ride['ride_id'],
            user: user,
            driver: driver,
            fare: ride['fare'],
            start_time: DateTime.parse(ride['start_time']),
            end_time: ride['end_time'] == null
                ? null
                : DateTime.parse(ride['end_time']),
            car: car,
            ride_origin_place: origin,
            ride_end_place: destination,
            ride_status: rideStatus,
            createdAt: DateTime.parse(ride['created_at']),
          );
          listAllMyCompletedRides.add(ridecreate);
          listCompletedRideFare.add(ridecreate.fare);
        }
      }
      return {
        "rides": listAllMyCompletedRides,
        "fares": listCompletedRideFare,
      };
    } on PostgrestException catch (error) {
      Get.snackbar(
        duration: const Duration(seconds: 3),
        'Get Request Error',
        error.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return {
        "rides": listAllMyCompletedRides,
        "fares": listCompletedRideFare,
      };
    } catch (error) {
      print(error);
      Get.snackbar(
        duration: const Duration(seconds: 3),
        'Get Request Error',
        error.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );

      return {
        "rides": listAllMyCompletedRides,
        "fares": listCompletedRideFare,
      };
    }
  }

  getAllCars() async {
    print("get All Cars");
    supabaseController.getAllJoined("cars", "users").then((resp) {
      if (resp == null) {
        allCars.value = [];
      } else {
        allCars.clear();
        allCars.value.addAll(CarModel.fromMapList(resp));
      }
    });
    return allCars;
  }

  Future<bool> newDriverWithCar(UserModel driver, CarModel car) async {
    try {
      return await _supabaseClient.auth.signUp(
        email: driver.email.toLowerCase(),
        password: "123456",
        data: {
          "email": driver.email.toLowerCase(),
          "password": "123456",
          "full_name": driver.full_name.toLowerCase(),
          "phone_number": driver.phone_number,
          "is_active": true,
          "user_type": UserType.driver.name.toLowerCase(),
          "address": "",
          "date_of_birth": driver.date_of_birth!.toIso8601String()
        },
      ).then((value) async {
        await supabaseController.insert('cars', {
          "license_number": car.license_number,
          "model": car.model,
          "plate_number": car.plate_number,
          "color": car.color,
          "user_id": value.user!.id,
        }).then((value) async {
          if (value) {
            await userController.getAllTypeUsersData(UserType.driver);
            return true;
          } else {
            return false;
          }
        });
        return true;
      });
    } on AuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return false;
    }
  }
}
