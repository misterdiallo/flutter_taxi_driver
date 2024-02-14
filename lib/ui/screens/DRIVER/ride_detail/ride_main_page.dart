import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:taxi_driver_app/core/models/place_model.dart';
import 'package:taxi_driver_app/core/models/ride_model.dart';
import 'package:taxi_driver_app/core/models/suggested_ride_model.dart';
import 'package:taxi_driver_app/core/services/car_service.dart';
import 'package:taxi_driver_app/core/services/place_service.dart';
import 'package:taxi_driver_app/core/services/ride_service.dart';
import 'package:taxi_driver_app/core/services/user_service.dart';
import 'package:taxi_driver_app/router.dart';
import 'package:taxi_driver_app/ui/screens/error_page.dart';
import 'package:taxi_driver_app/ui/widgets/dialog_error.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/api_map_config.dart';
import '../../../../core/models/route_details.dart';
import 'ride_details.dart';

class RideDetails extends StatefulWidget {
  final RideModel? ride;
  const RideDetails({Key? key, this.ride}) : super(key: key);

  @override
  State<RideDetails> createState() => _RideDetailsState();
}

class _RideDetailsState extends State<RideDetails>
    with SingleTickerProviderStateMixin {
  late MapZoomPanBehavior _zoomPanBehavior;
  MapTileLayerController? _mapController;
  AnimationController? _animationController;
  late Animation<double> _animation;
  late List<RouteDetails> _routes;
  List<MapLatLng> polyline = <MapLatLng>[];
  SuggestedRideModel? selectedRide;
  bool? successPayment;
  RideModel? rideDetails;
  String asyncData = "";
  PlaceModel? source;
  PlaceModel? destination;

  // Method to consume the OpenRouteService API
  Future<dynamic> getCoordinates({var startPoint, var endPoint}) async {
    // Requesting for openrouteservice api
    var response = await http.get(
      getRouteUrl(startPoint, endPoint),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var listOfPoints = data['features'][0]['geometry']['coordinates'];
      for (int i = 0; i < listOfPoints.length; i++) {
        polyline.add(MapLatLng(listOfPoints[i][1], listOfPoints[i][0]));
      }
      _animationController?.forward(from: 0);
      setState(() {
        asyncData = "Done";
      });
    } else {
      setState(() {
        asyncData = "Error";
      });
    }
    return polyline;
  }

  @override
  void initState() {
    super.initState();
    if (widget.ride == null) {
      Get.offAllNamed(DriverRoute);
    } else {
      source = widget.ride!.rideOriginPlace;
      destination = widget.ride!.rideEndPlace;
      _routes = <RouteDetails>[
        RouteDetails(
            MapLatLng(source!.latitude, source!.longitude),
            Icon(FontAwesomeIcons.locationDot,
                color: Colors.green[600], size: 30),
            source!.name),
        RouteDetails(
            MapLatLng(destination!.latitude, destination!.longitude),
            const Icon(Icons.location_on,
                color: Color.fromARGB(255, 115, 18, 11), size: 30),
            destination!.name),
      ];

      _mapController = MapTileLayerController();
      _zoomPanBehavior = MapZoomPanBehavior(
        minZoomLevel: 5,
        zoomLevel: 15,
        focalLatLng: MapLatLng(source!.latitude, source!.longitude),
        toolbarSettings: const MapToolbarSettings(
          direction: Axis.vertical,
          position: MapToolbarPosition.topRight,
        ),
        enableDoubleTapZooming: true,
      );
      getCoordinates(
        startPoint: "${source!.longitude}, ${source!.latitude}",
        endPoint: "${destination!.longitude}, ${destination!.latitude}",
      );

      _animationController = AnimationController(
        duration: const Duration(seconds: 3),
        vsync: this,
      );

      _animation = CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _animationController!.dispose();
    _mapController!.dispose();
    _routes.clear();
    super.dispose();
  }

  void showDialogOnError(BuildContext context,
      {String title = "Error",
      String content = "An error occurred. Please restart the app.",
      void Function()? onPressed}) {
    Get.dialog(
      barrierDismissible: false,
      ErrorDialog(title: title, content: content, onPressed: onPressed),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SlidingUpPanel(
          minHeight: MediaQuery.of(context).size.height * 0.4,
          borderRadius: radius,
          defaultPanelState: PanelState.OPEN,
          panel: Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(
                      0,
                      0,
                      0,
                      0.15,
                    ),
                    blurRadius: 25.0,
                  ),
                ],
                color: theme.scaffoldBackgroundColor),
            child: Builder(builder: (context) {
              return DriverRideDetailsPage(
                ride: widget.ride!,
              );
            }),
          ),
          body: Stack(
            children: [
              Container(
                // Replace this with your map widget
                color: theme.scaffoldBackgroundColor,
                height: MediaQuery.of(context).size.height * 0.7,
                child: SfMaps(
                  layers: [
                    const MapShapeLayer(
                      source: MapShapeSource.asset(
                        'map/china.json',
                        shapeDataField: 'city',
                      ),
                    ),
                    MapTileLayer(
                      initialZoomLevel: 10,
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      initialMarkersCount: _routes.length,
                      controller: _mapController,
                      markerBuilder: (BuildContext context, int index) {
                        if (_routes[index].icon != null) {
                          return MapMarker(
                            key: UniqueKey(),
                            latitude: _routes[index].latLan.latitude,
                            longitude: _routes[index].latLan.longitude,
                            alignment: Alignment.bottomCenter,
                            child: _routes[index].icon,
                          );
                        } else {
                          return MapMarker(
                            key: UniqueKey(),
                            latitude: _routes[index].latLan.latitude,
                            longitude: _routes[index].latLan.longitude,
                            iconColor: Colors.white,
                            iconStrokeWidth: 2.0,
                            size: const Size(15, 15),
                            iconStrokeColor: Colors.black,
                          );
                        }
                      },
                      tooltipSettings: const MapTooltipSettings(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        hideDelay: 2000,
                      ),
                      markerTooltipBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_routes[index].city,
                              style: theme.textTheme.bodySmall!.copyWith(
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 1))),
                        );
                      },
                      sublayers: <MapSublayer>[
                        MapPolylineLayer(
                            polylines: <MapPolyline>{
                              MapPolyline(
                                points: polyline,
                                color: theme.primaryColor,
                                width: 6.0,
                              )
                            },
                            animation: _animation,
                            tooltipBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '${_routes[0].city.toUpperCase()} - to - ${_routes[1].city.toUpperCase()}',
                                    style: theme.textTheme.bodySmall!.copyWith(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1))),
                              );
                            }),
                      ],
                      zoomPanBehavior: _zoomPanBehavior,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: Icon(
                      Icons.close,
                      size: 30,
                      color: theme.scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
