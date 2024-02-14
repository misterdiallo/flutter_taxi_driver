import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class RouteDetails {
  RouteDetails(this.latLan, this.icon, this.city);

  MapLatLng latLan;
  Widget? icon;
  String city;
}
