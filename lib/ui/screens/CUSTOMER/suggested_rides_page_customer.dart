import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taxi_driver_app/core/models/place_model.dart';
import 'package:taxi_driver_app/core/models/route_api.dart';
import 'package:taxi_driver_app/core/models/suggested_ride_model.dart';
import 'package:taxi_driver_app/core/services/suggested_ride_service.dart';
import 'package:taxi_driver_app/ui/utils/conversion_utils.dart';
import 'package:taxi_driver_app/ui/utils/fare_calculator.dart';
import 'package:taxi_driver_app/ui/widgets/vehicle_selection.dart';

class SuggestedRides extends StatefulWidget {
  final PlaceModel? source;
  final PlaceModel? destination;
  final RouteApiInfo? routeApiInfo;
  final void Function(SuggestedRideModel?)? onRideSelected; // Callback function
  const SuggestedRides(
      {Key? key,
      this.destination,
      this.source,
      this.onRideSelected,
      this.routeApiInfo})
      : super(key: key);

  @override
  State<SuggestedRides> createState() => _SuggestedRidesState();
}

class _SuggestedRidesState extends State<SuggestedRides> {
  SuggestedRideModel? selectedRide;
  FareModel? fareModel;
  List<SuggestedRideModel> suggestRidesList = [];

  @override
  void initState() {
    super.initState();
    var routeApiInfo = widget.routeApiInfo;
    fareModel = FareCalculator.calculateFare(
      ConversionUtil.metersToKilometersDouble(
        routeApiInfo!.distance,
      ),
      ConversionUtil.secondsToHoursOrMinutesDouble(
        routeApiInfo.distance,
      ),
    );
    suggestRidesList.add(
      SuggestedRideModel(
        vehicleType: "TAXI",
        image: const Icon(
          FontAwesomeIcons.taxi,
          size: 30,
        ),
        argument: "Best choice",
        selected: true,
        farePrice: "${fareModel!.taxi.toStringAsFixed(2)} RMB",
        duration: ConversionUtil.secondsToHoursOrMinutes(routeApiInfo.distance),
      ),
    );
    suggestRidesList.add(
      SuggestedRideModel(
        vehicleType: "LUXE",
        image: const Icon(
          FontAwesomeIcons.carRear,
          size: 30,
        ),
        selected: false,
        farePrice: "${fareModel!.luxe.toStringAsFixed(2)} RMB",
        duration: ConversionUtil.secondsToHoursOrMinutes(routeApiInfo.distance),
      ),
    );
    selectedRide = suggestRidesList.first;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
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
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: 40.0,
              ),
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                itemCount: suggestRidesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: VehicleSelection(
                      vehicleType: suggestRidesList[index].vehicleType,
                      farePrice: suggestRidesList[index].farePrice,
                      argument: suggestRidesList[index].argument,
                      duration: suggestRidesList[index].duration,
                      image: suggestRidesList[index].image,
                      selected: suggestRidesList[index] == selectedRide,
                      onTap: () {
                        setState(() {
                          selectedRide = suggestRidesList[index];
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                  child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 50.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.scaffoldBackgroundColor,
                      side: BorderSide(color: theme.primaryColor),
                    ),
                    onPressed: () {
                      widget.onRideSelected!(selectedRide);
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'ORDER NOW\n',
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (selectedRide != null)
                            TextSpan(
                              text: '${selectedRide!.farePrice}',
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                        ],
                      ),
                    )),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
