import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/core/custom_popup.dart';
import 'package:taxi_driver_app/core/models/ride_model.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';
import 'package:taxi_driver_app/ui/utils/date_utlis.dart';

class RideManager {
  final BuildContext context;
  RideManager(this.context);

  void showRideDetails(RideModel ride) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Ride ID: ${ride.rideId}",
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("User"),
                  subtitle: Text(ride.user.fullName),
                ),
                ListTile(
                  leading: const Icon(Icons.directions_car),
                  title: const Text("Driver"),
                  subtitle: Text(ride.driver.fullName),
                ),
                ListTile(
                  leading: const Icon(Icons.monetization_on),
                  title: const Text("Fare"),
                  subtitle: Text("\$${ride.fare}"),
                ),
                ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Start Time"),
                  subtitle: Text(formatDateUtilsNew(ride.startTime)),
                ),
                ListTile(
                  leading: const Icon(Icons.timer_off),
                  title: const Text("End Time"),
                  subtitle: Text(ride.endTime != null
                      ? formatDateUtilsNew(ride.endTime!)
                      : 'N/A'),
                ),
                if (ride.car != null)
                  ListTile(
                    leading: const Icon(Icons.directions_car_filled),
                    title: const Text("Car"),
                    subtitle: Text(
                        "${ride.car!.model} (${ride.car!.licenseNumber})"), // Assuming CarModel has make and model
                  ),
                if (ride.userRating != null)
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text("User Rating"),
                    subtitle: Text(
                        "${ride.userRating!.rating}/5"), // Assuming RatingModel has a rating field
                  ),
                if (ride.driverRating != null)
                  ListTile(
                    leading: const Icon(Icons.star_outline),
                    title: const Text("Driver Rating"),
                    subtitle: Text("${ride.driverRating!.rating}/5"),
                  ),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text("Origin"),
                  subtitle: Text(ride.rideOriginPlace
                      .name), // Assuming PlaceModel has a name field
                ),
                ListTile(
                  leading: const Icon(Icons.location_off),
                  title: const Text("Destination"),
                  subtitle: Text(ride.rideEndPlace.name),
                ),
                ListTile(
                  leading: const Icon(Icons.event_available),
                  title: const Text("Status"),
                  subtitle: Text(ride.rideStatus.name
                      .toUpperCase()), // Assuming rideStatus is an enum
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
