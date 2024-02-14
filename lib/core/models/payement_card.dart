enum PaymentMethodType { visa, mastercard, unionPay, weChatPay, alipay, paypal }

class PaymentCardModel {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final PaymentMethodType type;

  PaymentCardModel({
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.type,
  });
}
