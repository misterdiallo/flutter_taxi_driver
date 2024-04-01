import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:permission_handler/permission_handler.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';
import 'package:taxi_driver_app/ui/styles/colors.dart';
import 'package:taxi_driver_app/ui/widgets/app_drawer.dart';
import 'package:taxi_driver_app/ui/widgets/bottom_map_container.dart';
import 'package:taxi_driver_app/ui/widgets/map_in_background_widget.dart';

class HomepageCustomer extends StatefulWidget {
  const HomepageCustomer({Key? key}) : super(key: key);

  @override
  _HomepageCustomerState createState() => _HomepageCustomerState();
}

class _HomepageCustomerState extends State<HomepageCustomer> {
  var myLocation;

  final List<Marker> _markers = [
    Marker(
      width: 60.0,
      height: 60.0,
      point: const LatLng(51.32, -0.083),
      child: Container(
        child: Image.asset(
          "assets/images/car2.png",
          width: 60.0,
          height: 60.0,
        ),
      ),
    ),
    Marker(
      width: 60.0,
      height: 60.0,
      point: const LatLng(51.3, -0.08),
      child: Container(
        child: Image.asset(
          "assets/images/car2.png",
          width: 60.0,
          height: 60.0,
        ),
      ),
    ),
    Marker(
      width: 60.0,
      height: 60.0,
      point: const LatLng(51.29, -0.077),
      child: Container(
        child: Image.asset(
          "assets/images/car2.png",
          width: 60.0,
          height: 60.0,
        ),
      ),
    )
  ];

  @override
  void initState() {
    super.initState();

    placesController.getAllPlaces();
    driverData.getAllCars();
    customerData.getAllMyRides();
    userController.getAllTypeUsersData(UserType.driver);
    // getMyLocation();
  }

  Future<Position> getMyLocation() async {
    bool currentPermissionStatusIsGranted =
        await Permission.location.status.isGranted.then((value) => value);
    try {
      if (!currentPermissionStatusIsGranted) {
        await Permission.location.request();
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true,
      );

      myLocation = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          point: myLocation!,
          child: const Column(
            children: <Widget>[
              SizedBox(
                width: 30.0,
                child: Icon(
                  FontAwesomeIcons.locationPin,
                  color: dprimaryColor,
                ),
              ),
              Text("Pick Up Here"),
            ],
          ),
          width: 120.0,
          height: 60.0,
        ),
      );

      print("My location is : $myLocation");
      return position;
    } catch (e) {
      // Handle error
      print("Error getting location: $e");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: FutureBuilder<Position>(
          // Specify your asynchronous function here
          future: getMyLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    lottie.Lottie.asset(
                      "assets/lotties/location.json",
                    ),
                    Text('${snapshot.error}')
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              // If the data is available, update your UI accordingly

              myLocation =
                  LatLng(snapshot.data!.latitude, snapshot.data!.longitude);

              return Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      MapInBackgroundWidget(
                        context: context,
                        markers: _markers,
                        myLocation: myLocation,
                      ),
                      Builder(
                        builder: (BuildContext context) {
                          return IconButton(
                            icon: const Icon(
                              Icons.menu,
                              size: 35.0,
                            ),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  HomeMapBottom(
                    theme: theme,
                  ),
                ],
              );
            } else {
// Display a loading indicator while waiting for the result
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    lottie.Lottie.asset(
                      "assets/lotties/location.json",
                    ),
                    const Text('Getting location...')
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
