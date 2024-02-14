import 'package:flutter/material.dart';
import 'package:taxi_driver_app/core/models/payement_card.dart';
import 'package:badges/badges.dart' as badges;
import 'package:taxi_driver_app/ui/widgets/get_payment_icon.dart';

class PaymentCardWidget extends StatelessWidget {
  final PaymentCardModel cardInfo;
  final bool isSelected;

  const PaymentCardWidget({
    Key? key,
    required this.cardInfo,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCreditCard(
      color: const Color(0xFF000000),
      cardExpiration: cardInfo.expiryDate,
      cardHolder: cardInfo.cardHolderName.toUpperCase(),
      cardNumber: cardInfo.cardNumber,
      isSelected: isSelected,
    );
  }

  // Build the credit card widget
  Widget _buildCreditCard({
    required Color color,
    required String cardNumber,
    required String cardHolder,
    required String cardExpiration,
    required bool isSelected,
  }) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 0, end: 3),
      badgeAnimation: const badges.BadgeAnimation.slide(),
      badgeStyle: isSelected
          ? const badges.BadgeStyle(
              badgeColor: Colors.green,
            )
          : const badges.BadgeStyle(
              padding: EdgeInsets.all(0.0),
            ),
      badgeContent: isSelected
          ? const Icon(
              Icons.done,
              color: Colors.white,
            )
          : null,
      child: _buildCardPayment(
          color: color,
          cardNumber: cardNumber,
          cardHolder: cardHolder,
          cardExpiration: cardExpiration,
          isSelected: isSelected),
    );
  }

  // build the card
  Card _buildCardPayment({
    required Color color,
    required String cardNumber,
    required String cardHolder,
    required String cardExpiration,
    required bool isSelected,
  }) {
    return Card(
      elevation: 4.0,
      color: isSelected ? Colors.green.withOpacity(0.5) : color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 200,
        width: 250,
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, bottom: 22.0, top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                cardNumber,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'CARD HOLDER',
                  value: cardHolder,
                ),
                _buildDetailsBlock(label: 'VALID THRU', value: cardExpiration),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build the top row containing logos
  Row _buildLogosBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "assets/images/cards/contact_less.png",
          height: 20,
          width: 18,
        ),
        Image.asset(
          getPaymentIcon(cardInfo),
          height: 50,
          width: 50,
        ),
      ],
    );
  }

// Build Column containing the cardholder and expiration information
  Column _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
