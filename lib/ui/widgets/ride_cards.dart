import 'package:flutter/material.dart';

import 'ride_card.dart';

class RideCards extends StatelessWidget {
  const RideCards({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        RideCard(),
        RideCard(),
        RideCard(),
      ],
    );
  }
}
