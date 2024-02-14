import 'package:get/get.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/place_model.dart';
import 'package:taxi_driver_app/core/models/ride_model.dart';

import '../models/payement_card.dart';

class CustomerDataController extends GetxController {
  static CustomerDataController instance = Get.find();
  List<PaymentCardModel> listPaymentCards = [
    PaymentCardModel(
        cardNumber: '**** **** **** 1234',
        expiryDate: '12/22',
        cardHolderName: authController.fullName.toString(),
        type: PaymentMethodType.visa),
    PaymentCardModel(
        cardNumber: '**** **** **** 5678',
        expiryDate: '08/24',
        cardHolderName: authController.fullName.toString(),
        type: PaymentMethodType.mastercard),
    PaymentCardModel(
        cardNumber: '**** **** **** 9012',
        expiryDate: '04/24',
        cardHolderName: authController.fullName.toString(),
        type: PaymentMethodType.unionPay),
    PaymentCardModel(
        cardNumber: '**** **** **** 3456',
        expiryDate: '11/26',
        cardHolderName: authController.fullName.toString(),
        type: PaymentMethodType.weChatPay),
    PaymentCardModel(
        cardNumber: '**** **** **** 7890',
        expiryDate: '09/22',
        cardHolderName: authController.fullName.toString(),
        type: PaymentMethodType.alipay),
    PaymentCardModel(
        cardNumber: '**** **** **** 2345',
        expiryDate: '02/25',
        cardHolderName: authController.fullName.toString(),
        type: PaymentMethodType.paypal),
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
  void addRide(RideModel ride) {
    listOfMyRides.add(ride);
    update();
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
