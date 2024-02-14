import 'package:flutter/material.dart';
import 'package:taxi_driver_app/core/models/payement_card.dart';
import 'package:taxi_driver_app/ui/utils/card_image_utils.dart';

import '../../core/models/debit_card_model.dart';

class CardContainer extends StatelessWidget {
  final PaymentCardModel cardDetail;
  const CardContainer({required this.cardDetail, super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.all(0.0),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        leading: carImageUtils(paymentType: cardDetail.type),
        title: Text(
          cardDetail.cardNumber,
          style: const TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "Expires ${cardDetail.expiryDate}",
          style: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
