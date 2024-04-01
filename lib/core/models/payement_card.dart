enum PaymentMethodType { visa, mastercard, unionPay, weChatPay, alipay, paypal }

class PaymentCardModel {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final PaymentMethodType type;
  final String user_id;

  PaymentCardModel({
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.type,
    required this.user_id,
  });
}
