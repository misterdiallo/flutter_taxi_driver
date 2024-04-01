import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/services/user_service.dart';

import '../models/payement_card.dart';

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
