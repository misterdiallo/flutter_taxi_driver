import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapInBackgroundWidget extends StatefulWidget {
  final List<Marker> markers;
  final LatLng? myLocation;
  final BuildContext context;
  const MapInBackgroundWidget({
    super.key,
    required this.context,
    required this.markers,
    required this.myLocation,
  });

  @override
  State<MapInBackgroundWidget> createState() => _MapInBackgroundWidgetState();
}

class _MapInBackgroundWidgetState extends State<MapInBackgroundWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 230.0,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: widget.myLocation != null
              ? widget.myLocation!
              : const LatLng(51.3, -0.08),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: widget.markers,
          ),
        ],
      ),
    );
  }
}
