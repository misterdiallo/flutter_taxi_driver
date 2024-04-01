import 'package:flutter/material.dart';

import 'package:taxi_driver_app/core/models/payement_card.dart';
import 'package:taxi_driver_app/ui/utils/card_image_utils.dart';

import '../../core/models/debit_card_model.dart';

class CardContainer extends StatelessWidget {
  final PaymentCardModel cardDetail;
  final bool isPage;
  const CardContainer({required this.cardDetail, this.isPage = false, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double screenWidth = MediaQuery.of(context).size.width;

    // Calculate font size based on screen width
    final double fontSize = screenWidth * 0.02; // Adjust this factor as needed

    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: isPage
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: carImageUtils(
                      paymentType: cardDetail.type,
                      width: 55,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            // width: screenWidth * 0.2,
                            child: Text(
                              cardDetail.cardNumber,
                              style: const TextStyle(
                                fontSize: 15, // Use the calculated font size
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                          Text(
                            "Expires ${cardDetail.expiryDate}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: carImageUtils(
                      paymentType: cardDetail.type,
                      width: 35,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.2,
                            child: Text(
                              cardDetail.cardNumber,
                              style: TextStyle(
                                fontSize:
                                    fontSize, // Use the calculated font size
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                          Text(
                            "Expires ${cardDetail.expiryDate}",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: fontSize *
                                  0.8, // Adjust the expiration date font size
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
