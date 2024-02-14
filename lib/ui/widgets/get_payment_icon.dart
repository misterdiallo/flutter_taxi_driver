import 'package:taxi_driver_app/core/models/payement_card.dart';

String getPaymentIcon(PaymentCardModel cardInfo) {
  switch (cardInfo.type) {
    case PaymentMethodType.visa:
      return "assets/images/cards/visa.png";
    case PaymentMethodType.mastercard:
      return "assets/images/cards/mastercard.png";
    case PaymentMethodType.unionPay:
      return "assets/images/cards/unionpay.png";
    case PaymentMethodType.weChatPay:
      return "assets/images/cards/wechat.png";
    case PaymentMethodType.alipay:
      return "assets/images/cards/alipay.png";
    case PaymentMethodType.paypal:
      return "assets/images/cards/paypal.png";
  }
}
