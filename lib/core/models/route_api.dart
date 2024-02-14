import 'package:syncfusion_flutter_maps/maps.dart';

class RouteApiInfo {
  final double duration;
  final double distance;
  final List<MapLatLng> polyline;

  RouteApiInfo(
      {required this.duration, required this.distance, required this.polyline});
}
