import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/suggested_ride_model.dart';

List<SuggestedRideModel> suggestedRidesList = [
  SuggestedRideModel(
    vehicleType: "TAXI",
    image: const Icon(
      FontAwesomeIcons.taxi,
      size: 40,
    ),
    farePrice: "32 RMB",
    duration: "5 to 9 min",
    selected: true,
  ),
  SuggestedRideModel(
    vehicleType: "LUXE CAR",
    image: const Icon(
      FontAwesomeIcons.carRear,
      size: 40,
    ),
    argument: "Best choice",
    farePrice: "52 RMB",
    duration: "5 to 15 min",
    selected: false,
  ),
];
