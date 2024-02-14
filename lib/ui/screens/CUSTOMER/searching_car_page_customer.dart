import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:taxi_driver_app/core/api_map_config.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/place_model.dart';
import 'package:taxi_driver_app/core/models/ride_model.dart';
import 'package:taxi_driver_app/core/models/route_api.dart';
import 'package:taxi_driver_app/core/models/route_details.dart';
import 'package:taxi_driver_app/core/models/suggested_ride_model.dart';
import 'package:taxi_driver_app/core/services/car_service.dart';
import 'package:taxi_driver_app/core/services/place_service.dart';
import 'package:taxi_driver_app/core/services/ride_service.dart';
import 'package:taxi_driver_app/core/services/user_service.dart';
import 'package:taxi_driver_app/router.dart';
import 'package:taxi_driver_app/ui/screens/CUSTOMER/ride_detail_page_customer.dart';
import 'package:taxi_driver_app/ui/screens/CUSTOMER/ride_payement_page_customer.dart';
import 'package:taxi_driver_app/ui/screens/CUSTOMER/suggested_rides_page_customer.dart';
import 'package:taxi_driver_app/ui/screens/error_page.dart';
import 'package:taxi_driver_app/ui/widgets/dialog_error.dart';
import 'package:uuid/uuid.dart';

class SearchingCar extends StatefulWidget {
  const SearchingCar({Key? key}) : super(key: key);

  @override
  State<SearchingCar> createState() => _SearchingCarState();
}

class _SearchingCarState extends State<SearchingCar>
    with SingleTickerProviderStateMixin {
  late MapZoomPanBehavior _zoomPanBehavior;
  MapTileLayerController? _mapController;
  AnimationController? _animationController;
  late Animation<double> _animation;
  late List<RouteDetails> _routes;
  List<MapLatLng> polyline = <MapLatLng>[];
  double duration = 0.0;
  double distance = 0.0;
  RouteApiInfo? routeApiInfo;
  SuggestedRideModel? selectedRide;
  bool? successPayment;
  RideModel? rideDetails;
  String asyncData = "";
  PlaceModel? source;
  PlaceModel? destination;

  // Method to consume the OpenRouteService API
  Future<RouteApiInfo> getCoordinates({var startPoint, var endPoint}) async {
    var response = await http.get(getRouteUrl(startPoint, endPoint));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var feature = data['features'][0];
      var summary = feature['properties']['summary'];

      duration = summary['duration'];
      distance = summary['distance'];

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
    routeApiInfo = RouteApiInfo(
        duration: duration, distance: distance, polyline: polyline);
    return routeApiInfo!;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var arguments = Get.arguments;
      if (arguments != null &&
          arguments.containsKey('source') &&
          arguments.containsKey('destination')) {
        source = listPlaces.firstWhere(
          (place) =>
              place.name.toLowerCase() ==
                  Get.arguments['source'].toString().toLowerCase() ||
              place.address.toLowerCase() ==
                  Get.arguments['source'].toString().toLowerCase(),
        );
        destination = listPlaces.firstWhere(
          (place) =>
              place.name.toLowerCase() ==
                  Get.arguments['destination'].toString().toLowerCase() ||
              place.address.toLowerCase() ==
                  Get.arguments['destination'].toString().toLowerCase(),
        );
        if (source != null || destination != null) {
          // _routeJson = 'assets/map/china.json';
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
        } else {
          showDialogOnError(context);
        }
      } else {
        showDialogOnError(context);
      }
    });
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Builder(builder: (context) {
          if (asyncData == "Done") {
            BorderRadiusGeometry radius = const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            );
            return SlidingUpPanel(
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
                  // 0
                  if (selectedRide == null) {
                    print("0: In the step: StepZero");
                    return SuggestedRides(
                      routeApiInfo: routeApiInfo!,
                      source: source,
                      destination: destination,
                      onRideSelected: (theRideSelected) {
                        // Handle the selected ride here
                        setState(() {
                          selectedRide = theRideSelected;
                        });
                      },
                    );
                  }
                  // 1
                  if (selectedRide != null &&
                      selectedRide.runtimeType == SuggestedRideModel &&
                      (successPayment != true || successPayment == null)) {
                    print("1: In the step: SelectCarRidePriceDone");
                    return RidePaymentPageCustomer(
                      rideDetails: selectedRide!,
                      onConfirmPayment: (selectedPaymentMethod, success) {
                        // Handle payment confirmation
                        if (success) {
                          // Payment successful]
                          var ride = RideModel(
                            rideId: const Uuid().v4(),
                            user: authController.getUserModel()!,
                            car: carList[0],
                            driver: carList[0].user,
                            fare: selectedRide!.farePrice.toString(),
                            startTime: DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                DateTime.now().hour,
                                DateTime.now().minute + 5),
                            endTime: DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                DateTime.now().hour,
                                DateTime.now().minute + 55),
                            rideOriginPlace: source!,
                            rideEndPlace: destination!,
                            rideStatus: RideStatus.pending,
                            createdAt: DateTime.now(),
                          );
                          customerData.addRide(ride);

                          setState(() {
                            rideDetails = ride;
                            successPayment = success;
                          });
                        } else {
                          showDialogOnError(
                            context,
                            content:
                                'Payment failed with Selected payment: ${selectedPaymentMethod.type.name}',
                            onPressed: () {
                              Get.back();
                            },
                          );
                        }
                      },
                    );
                  }
                  // 2
                  if (successPayment == true &&
                      rideDetails != null &&
                      rideDetails.runtimeType == RideModel) {
                    print("2: In the step: PaymentOkayStartRide");
                    return RideDetailsCustomer(
                      ride: rideDetails!,
                    );
                  }
                  // default
                  return const SizedBox.shrink();
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
                          markerTooltipBuilder:
                              (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(_routes[index].city,
                                  style: theme.textTheme.bodySmall!.copyWith(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1))),
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
                                tooltipBuilder:
                                    (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        '${_routes[0].city.toUpperCase()} - to - ${_routes[1].city.toUpperCase()}',
                                        style: theme.textTheme.bodySmall!
                                            .copyWith(
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
                      onTap: () => Get.offAllNamed(HomepageRoute),
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
            );
          } else if (asyncData == "Error") {
            return const ErrorPage();
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: theme.primaryColor,
              ), // Show CircularProgressIndicator while data is being fetched
            );
          }
        }),
      ),
    );
  }
}
