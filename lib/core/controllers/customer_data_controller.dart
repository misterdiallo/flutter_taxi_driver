import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/car_model.dart';
import 'package:taxi_driver_app/core/models/place_model.dart';
import 'package:taxi_driver_app/core/models/ride_model.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';

import '../models/payement_card.dart';

class CustomerDataController extends GetxController {
  static CustomerDataController instance = Get.find();
  final SupabaseClient supabaseClient = Supabase.instance.client;
  List<PaymentCardModel> listPaymentCards = [
    PaymentCardModel(
      cardNumber: '**** **** **** 1234',
      expiryDate: '12/22',
      cardHolderName: authController.fullName.toString(),
      type: PaymentMethodType.visa,
      user_id: "",
    ),
    PaymentCardModel(
      cardNumber: '**** **** **** 5678',
      expiryDate: '08/24',
      cardHolderName: authController.fullName.toString(),
      type: PaymentMethodType.mastercard,
      user_id: "",
    ),
    PaymentCardModel(
      cardNumber: '**** **** **** 9012',
      expiryDate: '04/24',
      cardHolderName: authController.fullName.toString(),
      type: PaymentMethodType.unionPay,
      user_id: "",
    ),
    PaymentCardModel(
      cardNumber: '**** **** **** 3456',
      expiryDate: '11/26',
      cardHolderName: authController.fullName.toString(),
      type: PaymentMethodType.weChatPay,
      user_id: "",
    ),
    PaymentCardModel(
      cardNumber: '**** **** **** 7890',
      expiryDate: '09/22',
      cardHolderName: authController.fullName.toString(),
      type: PaymentMethodType.alipay,
      user_id: "",
    ),
    PaymentCardModel(
      cardNumber: '**** **** **** 2345',
      expiryDate: '02/25',
      cardHolderName: authController.fullName.toString(),
      type: PaymentMethodType.paypal,
      user_id: "",
    ),
    // Add more payment methods as needed
  ];

  RxList<RideModel> listOfMyRides = <RideModel>[].obs;
  RxList<PaymentCardModel> listOfMyDebit = <PaymentCardModel>[].obs;
  RxList<PlaceModel> listOfMyPlaces = <PlaceModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    listOfMyDebit.addAll(listPaymentCards);
  }

// RIDE
  Future getAllMyRides() async {
    try {
      final myRides = await supabaseClient
          .from("rides")
          .select()
          .eq('user_id', authController.getUserModel()!.user_id)
          .order("created_at");
      if (myRides.isNotEmpty) {
        listOfMyRides.clear();
        for (var ride in myRides) {
          CarModel car = await supabaseController
              .getOneJoind("cars", "users", 'car_id', ride['car_id'])
              .then((value) => CarModel.fromMap(value!));
          UserModel user = await supabaseClient
              .from("users")
              .select()
              .eq("user_id", ride['user_id'])
              .single()
              .then((value) => UserModel.fromMap(value));
          UserModel driver = car.user;
          PlaceModel origin = await supabaseClient
              .from("places")
              .select()
              .eq("place_id", ride['ride_origin_place_id'])
              .single()
              .then((value) => PlaceModel.fromMap(value));
          PlaceModel destination = await supabaseClient
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
          listOfMyRides.add(ridecreate);
        }
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
  }

  Future<bool> addRide(RideModel ride) async {
    final data = {
      'ride_id': ride.ride_id,
      'user_id': ride.user.user_id,
      'driver_id': ride.driver.user_id,
      'fare': ride.fare,
      'start_time': ride.start_time.toIso8601String(),
      'car_id': ride.car!.car_id,
      'ride_origin_place_id': ride.ride_origin_place.place_id,
      'ride_end_place_id': ride.ride_end_place.place_id,
      'ride_status': ride.ride_status.name.toString().toLowerCase(),
    };
    return await supabaseController.insert('rides', data).then((value) async {
      if (value) {
        await getAllMyRides();
        return true;
      } else {
        return false;
      }
    });
  }

  Future<bool> updatedRideStatus(rideId, RideStatus rideStatus) async {
    try {
      await supabaseClient
          .from("rides")
          .update({"ride_status": rideStatus.name.toLowerCase()})
          .eq('ride_id', rideId)
          .then((value) async => await getAllMyRides());
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

  void deleteRide(int index) {
    listOfMyRides.removeAt(index);
    update();
  }

  void updatedRide(int index, RideModel ride) {
    listOfMyRides[index] = ride;
    update();
  }

// PAYMENT

  void addPayment(PaymentCardModel card) {
    listOfMyDebit.add(card);
    update();
  }
}
