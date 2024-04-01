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
            "Ride ID: ${ride.ride_id}",
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("User"),
                  subtitle: Text(ride.user.full_name),
                ),
                ListTile(
                  leading: const Icon(Icons.directions_car),
                  title: const Text("Driver"),
                  subtitle: Text(ride.driver.full_name),
                ),
                ListTile(
                  leading: const Icon(Icons.monetization_on),
                  title: const Text("Fare"),
                  subtitle: Text("\$${ride.fare}"),
                ),
                ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Start Time"),
                  subtitle: Text(formatDateUtilsNew(ride.start_time)),
                ),
                ListTile(
                  leading: const Icon(Icons.timer_off),
                  title: const Text("End Time"),
                  subtitle: Text(ride.end_time != null
                      ? formatDateUtilsNew(ride.end_time!)
                      : 'N/A'),
                ),
                if (ride.car != null)
                  ListTile(
                    leading: const Icon(Icons.directions_car_filled),
                    title: const Text("Car"),
                    subtitle: Text(
                        "${ride.car!.model} (${ride.car!.license_number})"), // Assuming CarModel has make and model
                  ),
                if (ride.user_rating != null)
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text("User Rating"),
                    subtitle: Text(
                        "${ride.user_rating!.rating}/5"), // Assuming RatingModel has a rating field
                  ),
                if (ride.driver_rating != null)
                  ListTile(
                    leading: const Icon(Icons.star_outline),
                    title: const Text("Driver Rating"),
                    subtitle: Text("${ride.driver_rating!.rating}/5"),
                  ),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text("Origin"),
                  subtitle: Text(ride.ride_origin_place
                      .name), // Assuming PlaceModel has a name field
                ),
                ListTile(
                  leading: const Icon(Icons.location_off),
                  title: const Text("Destination"),
                  subtitle: Text(ride.ride_end_place.name),
                ),
                ListTile(
                  leading: const Icon(Icons.event_available),
                  title: const Text("Status"),
                  subtitle: Text(ride.ride_status.name
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
