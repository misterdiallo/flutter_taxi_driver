import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taxi_driver_app/core/models/payement_card.dart';

Widget carImageUtils({
  required PaymentMethodType paymentType,
  double? width,
  double? height,
}) {
  // Define the possible characters and numbers for Chinese license plates
  String assetName = '';
  switch (paymentType) {
    case PaymentMethodType.visa:
      assetName = 'assets/images/cards/visa.png';
      break;
    case PaymentMethodType.mastercard:
      assetName = 'assets/images/cards/mastercard.png';
      break;
    case PaymentMethodType.unionPay:
      assetName = 'assets/images/cards/unionpay.png';
      break;
    case PaymentMethodType.weChatPay:
      assetName = 'assets/images/cards/wechat.png';
      break;
    case PaymentMethodType.alipay:
      assetName = 'assets/images/cards/alipay.png';
      break;
    case PaymentMethodType.paypal:
      assetName = 'assets/images/cards/paypal.png';
      break;
    default:
      assetName = 'assets/images/cards/contact_less.png';
  }

  return Image.asset(
    assetName,
    width: width,
    height: height,
  );
}
