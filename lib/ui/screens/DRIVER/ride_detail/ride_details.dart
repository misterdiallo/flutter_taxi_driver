import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/ride_model.dart';
import 'package:taxi_driver_app/ui/styles/colors.dart';

class DriverRideDetailsPage extends StatefulWidget {
  final RideModel ride;
  final int id;
  const DriverRideDetailsPage(
      {required this.ride, required this.id, super.key});

  @override
  State<DriverRideDetailsPage> createState() => _DriverRideDetailsPageState();
}

class _DriverRideDetailsPageState extends State<DriverRideDetailsPage> {
  RideModel? currentRide;

  Future updatedRideStatus(RideStatus status) async {
    await driverData
        .updatedRideStatus(currentRide!.ride_id, status)
        .then((value) async {
      if (value) {
        await driverData.getOneRide(currentRide!.ride_id).then((value) {
          if (value != null) {
            setState(() {
              currentRide = value;
            });
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // updateStatusAfterTime();
    currentRide = widget.ride;
  }

  @override
  void dispose() {
    super.dispose();
    // rideStatus = null;
    currentRide = null;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Builder(builder: (context) {
          return Content(
            theme: theme,
            ride: currentRide!,
            onSubmit: () async {
              await updatedRideStatus(
                currentRide!.ride_status == RideStatus.pending
                    ? RideStatus.accepted
                    : currentRide!.ride_status == RideStatus.accepted
                        ? RideStatus.ongoing
                        : currentRide!.ride_status == RideStatus.ongoing
                            ? RideStatus.completed
                            : RideStatus.pending,
              );
            },
          );
        }),
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    super.key,
    required this.theme,
    required this.ride,
    required this.onSubmit,
  });
  final Future<dynamic>? Function()? onSubmit;
  final ThemeData theme;
  final RideModel ride;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (_) {
      if (ride.ride_status == RideStatus.pending) {
        return SizedBox.expand(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Customer is Waiting',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
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
                                  ride.ride_origin_place.address,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                  ),
                                ),
                                title: Text(
                                  ride.ride_origin_place.name,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              ListTile(
                                dense: true,
                                subtitle: Text(
                                  ride.ride_end_place.address,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                  ),
                                ),
                                title: Text(
                                  ride.ride_end_place.name,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          elevation: 4.0,
                          margin: const EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                              vertical: 10.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  ride.fare,
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "To Earn",
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w300,
                                    // fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Builder(
                  builder: (context) {
                    final GlobalKey<SlideActionState> key = GlobalKey();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        var slideAction = SlideAction(
                          key: key,
                          onSubmit: onSubmit,
                          text: "Slide to Accept",
                          outerColor: weChatColor,
                          sliderButtonIcon: const Icon(
                            FontAwesomeIcons.arrowRight,
                          ),
                          height: 60,
                          sliderButtonIconPadding: 15,
                          sliderButtonYOffset: -5,
                          textStyle: theme.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                            color: theme.scaffoldBackgroundColor,
                          ),
                        );

                        return slideAction;
                      }),
                    );
                  },
                ),
              )
            ],
          ),
        );
      }
      if (ride.ride_status == RideStatus.accepted) {
        var user = ride.user;
        return SizedBox.expand(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "You've ${ride.ride_status.name.toUpperCase()} the ride",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
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
                                    ride.ride_origin_place.address,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                  ),
                                  title: Text(
                                    ride.ride_origin_place.name,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  dense: true,
                                  subtitle: Text(
                                    ride.ride_end_place.address,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                  ),
                                  title: Text(
                                    ride.ride_end_place.name,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            elevation: 4.0,
                            margin: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                                vertical: 10.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    ride.fare,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "You'll get",
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w300,
                                      // fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Customer Info',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Name:',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  user.full_name,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                Text(
                                  'Phone:',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  user.phone_number,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Builder(
                  builder: (context) {
                    final GlobalKey<SlideActionState> key = GlobalKey();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        var slideAction = SlideAction(
                          key: key,
                          onSubmit: onSubmit,
                          text: "START THE RIDE",
                          outerColor: dsecondaryColor,
                          sliderButtonIcon: const Icon(
                            FontAwesomeIcons.arrowRight,
                          ),
                          height: 60,
                          sliderButtonIconPadding: 15,
                          sliderButtonYOffset: -5,
                          textStyle: theme.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                            color: theme.scaffoldBackgroundColor,
                          ),
                        );

                        return slideAction;
                      }),
                    );
                  },
                ),
              )
            ],
          ),
        );
      }
      if (ride.ride_status == RideStatus.ongoing) {
        var user = ride.user;
        return SizedBox.expand(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'RIDE STARTED',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
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
                                    ride.ride_origin_place.address,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                  ),
                                  title: Text(
                                    ride.ride_origin_place.name,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  dense: true,
                                  subtitle: Text(
                                    ride.ride_end_place.address,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                  ),
                                  title: Text(
                                    ride.ride_end_place.name,
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
                    Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Customer Info',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Name:',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  user.full_name,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                Text(
                                  'Phone:',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  user.phone_number,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Builder(
                  builder: (context) {
                    final GlobalKey<SlideActionState> key = GlobalKey();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        var slideAction = SlideAction(
                          key: key,
                          onSubmit: onSubmit,
                          text: "END RIDE",
                          outerColor: theme.primaryColor,
                          sliderButtonIcon: const Icon(
                            FontAwesomeIcons.arrowRight,
                          ),
                          height: 60,
                          sliderButtonIconPadding: 15,
                          sliderButtonYOffset: -5,
                          textStyle: theme.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                            color: theme.scaffoldBackgroundColor,
                          ),
                        );

                        return slideAction;
                      }),
                    );
                  },
                ),
              )
            ],
          ),
        );
      }
      if (ride.ride_status == RideStatus.completed) {
        var user = ride.user;
        return SizedBox.expand(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'RIDE COMPLETED',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
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
                                    ride.ride_origin_place.address,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                  ),
                                  title: Text(
                                    ride.ride_origin_place.name,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  dense: true,
                                  subtitle: Text(
                                    ride.ride_end_place.address,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                  ),
                                  title: Text(
                                    ride.ride_end_place.name,
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
                    Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Customer Info',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Name:',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  user.full_name,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                Text(
                                  'Phone:',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  user.phone_number,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Builder(
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return Center(
                          child: RatingBar.builder(
                            itemPadding: const EdgeInsets.all(10.0),
                            initialRating: 0,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              switch (index) {
                                case 0:
                                  return Column(
                                    children: [
                                      const Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      Text(
                                        "Poor",
                                        style:
                                            theme.textTheme.bodyLarge!.copyWith(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  );
                                case 1:
                                  return Column(
                                    children: [
                                      const Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: Colors.orange,
                                        size: 30,
                                      ),
                                      Text(
                                        "Fair",
                                        style:
                                            theme.textTheme.bodyLarge!.copyWith(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  );
                                case 2:
                                  return Column(
                                    children: [
                                      Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.amber[600],
                                        size: 30,
                                      ),
                                      Text(
                                        "Average",
                                        style:
                                            theme.textTheme.bodyLarge!.copyWith(
                                          color: Colors.amber[600],
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  );
                                case 3:
                                  return Column(
                                    children: [
                                      const Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      Text(
                                        "Good",
                                        style:
                                            theme.textTheme.bodyLarge!.copyWith(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  );
                                case 4:
                                  return Column(
                                    children: [
                                      const Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Colors.blue,
                                        size: 30,
                                      ),
                                      Text(
                                        "Excellent",
                                        style:
                                            theme.textTheme.bodyLarge!.copyWith(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  );
                                default:
                                  return const Icon(
                                    Icons.sentiment_very_satisfied,
                                    color: Colors.green,
                                  );
                              }
                            },
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        );
                      }),
                    );
                  },
                ),
              )
            ],
          ),
        );
      }
      return Center(
        child: Column(
          children: [
            const Text("An error occured"),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                " Refresh",
                style: theme.textTheme.bodyLarge!.copyWith(
                  // fontSize: 1,
                  fontWeight: FontWeight.w400,
                  color: theme.scaffoldBackgroundColor,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
