import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/core/models/ride_model.dart';
import 'package:taxi_driver_app/core/services/ride_service.dart';
import 'package:taxi_driver_app/router.dart';

import 'ride_detail/ride_main_page.dart';

class RideDriverTab extends StatefulWidget {
  const RideDriverTab({Key? key}) : super(key: key);

  @override
  _RideDriverTabState createState() => _RideDriverTabState();
}

class _RideDriverTabState extends State<RideDriverTab> {
  late List<RideModel> displayedRides;

  @override
  void initState() {
    super.initState();
    // Simulated data for demonstration purposes
    displayedRides = rideList;
  }

  // Function to accept a ride
  void acceptRide(int index) {
    print("Ride accepted");
    // setState(() {
    //   displayedRides[index].rideStatus.name = RideStatus.accepted.name;
    // });
    // // Navigate to RideDetails page
    Get.to(() => RideDetails(ride: displayedRides[index]),
        routeName: DriverRideDetailsRoute);
  }

  // Function to decline a ride
  void declineRide(int index) {
    setState(() {
      displayedRides.removeAt(index); // Remove the declined ride
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ride Requests (${displayedRides.length})',
          // style: theme.textTheme.bodyLarge!.copyWith(
          //   fontSize: 20,
          //   fontWeight: FontWeight.w300,
          //   // color: theme.scaffoldBackgroundColor,
          // ),
        ),
      ),
      body: RefreshIndicator(
        color: theme.primaryColor,
        backgroundColor: theme.primaryColor.withOpacity(0.4),
        onRefresh: () async {
          // Implement logic to refresh the displayed rides
          List<RideModel> updatedRideList = rideList;
          setState(() {
            // Refresh the displayed rides
            displayedRides = updatedRideList;
          });
        },
        child: ListView.builder(
          itemCount: displayedRides.length,
          itemBuilder: (context, index) {
            final ride = displayedRides[index];
            return GestureDetector(
              onTap: () {
                // Navigate to RideDetails page when Card is clicked
                Get.to(() => RideDetails(ride: ride));
              },
              child: Card(
                elevation: 4, // Add elevation for a card-like appearance
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.6,
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // Center horizontally
                        children: [
                          SizedBox(
                            height: 95.0, // Adjust the height of the line
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.green[600],
                                ),
                                Container(
                                  width: 4.0, // Diameter of dots
                                  height:
                                      4.0, // Height of dots (same as the line)
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black, // Color of dots
                                  ),
                                ),
                                Container(
                                  width: 4.0, // Diameter of dots
                                  height:
                                      4.0, // Height of dots (same as the line)
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black, // Color of dots
                                  ),
                                ),
                                Container(
                                  width: 4.0, // Diameter of dots
                                  height:
                                      4.0, // Height of dots (same as the line)
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black, // Color of dots
                                  ),
                                ),
                                Icon(
                                  Icons.location_on,
                                  color: Colors.red[600],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align start horizontally
                              children: [
                                ListTile(
                                  minVerticalPadding: 0,
                                  dense: true,
                                  subtitle: Text(
                                    ride.rideOriginPlace.address,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                  ),
                                  title: Text(
                                    ride.rideOriginPlace.name,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  dense: true,
                                  subtitle: Text(
                                    ride.rideEndPlace.address,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                  ),
                                  title: Text(
                                    ride.rideEndPlace.name,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Builder(builder: (context) {
                      if (ride.rideStatus == RideStatus.pending) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Implement logic to accept the ride
                                  // You can call a function here to accept the ride
                                  acceptRide(index);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Accept',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    // fontSize: 1,
                                    fontWeight: FontWeight.bold,
                                    color: theme.scaffoldBackgroundColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Implement logic to accept the ride
                                  // You can call a function here to accept the ride
                                  declineRide(index);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.focusColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Decline',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    // fontSize: 1,
                                    fontWeight: FontWeight.bold,
                                    color: theme.scaffoldBackgroundColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Implement logic to accept the ride
                              // You can call a function here to accept the ride
                              acceptRide(index);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              ride.rideStatus.name.toUpperCase(),
                              style: theme.textTheme.bodyLarge!.copyWith(
                                // fontSize: 1,
                                fontWeight: FontWeight.bold,
                                color: theme.scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                        );
                      }
                    })
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
