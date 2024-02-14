import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:taxi_driver_app/core/models/ride_model.dart';
import 'package:taxi_driver_app/router.dart';
import 'package:taxi_driver_app/ui/widgets/get_color_function.dart';

class RideDetailsCustomer extends StatefulWidget {
  final RideModel? ride;

  const RideDetailsCustomer({
    Key? key,
    this.ride,
  }) : super(key: key);

  @override
  State<RideDetailsCustomer> createState() => _RideDetailsCustomerState();
}

class _RideDetailsCustomerState extends State<RideDetailsCustomer> {
  RideStatus? rideStatus;

  Future<void> updateStatusAfterTime() async {
    await Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        rideStatus = RideStatus.accepted;
      });
    });
    await Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        rideStatus = RideStatus.ongoing;
      });
    });
    await Future.delayed(const Duration(seconds: 30), () {
      setState(() {
        rideStatus = RideStatus.completed;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateStatusAfterTime();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    RideModel ride = widget.ride!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox.expand(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      (rideStatus != null)
                          ? (rideStatus!.name == RideStatus.pending.name)
                              ? 'Driver on the way...'
                              : "Ride is ${rideStatus!.name.toUpperCase()}..."
                          : 'Driver on the way...',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    FontAwesomeIcons.taxi,
                                    color: theme.primaryColor,
                                    size: 30,
                                  ),
                                ),
                                Text(
                                  ride.car!.user.fullName,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                RatingBarIndicator(
                                  rating: 3.6,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: theme.primaryColor,
                                  ),
                                  itemCount: 5,
                                  itemSize: 15.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: ride.car!.plateNumber,
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19,
                                                color: theme.primaryColor),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: ride.car!.model.toUpperCase(),
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        SizedBox(
                                          width: 55,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                color: getColorFromName(
                                                    ride.car!.color),
                                                size: 15,
                                              ),
                                              Text(
                                                ride.car!.color,
                                                style: theme
                                                    .textTheme.bodyLarge!
                                                    .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Card(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: rideStatus == null
                                            ? ride.rideStatus.name.toUpperCase()
                                            : rideStatus!.name.toUpperCase(),
                                        style:
                                            theme.textTheme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: theme.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
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
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // Center horizontally
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "Today\n",
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: Colors.green[600],
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        "${ride.startTime.hour > 9 ? ride.startTime.hour : '0${ride.startTime.hour}'}:${ride.startTime.minute > 9 ? ride.startTime.minute : '0${ride.startTime.minute}'}",
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.green[600],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "Today\n",
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: theme.primaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        "${ride.endTime!.hour > 9 ? ride.endTime!.hour : '0${ride.endTime!.hour}'}:${ride.endTime!.minute > 9 ? ride.endTime!.minute : '0${ride.endTime!.minute}'}",
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: theme.primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
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
                          onSubmit: () {
                            Future.delayed(const Duration(seconds: 2), () {
                              if (key.currentState!.submitted) {
                                return Get.offAllNamed(HomepageRoute);
                              } else {
                                key.currentState!.reset();
                                return null;
                              }
                            });
                            return null;
                          },
                          text: "Slide to Cancel",
                          outerColor: theme.primaryColor,
                          sliderButtonIcon: const Icon(
                            FontAwesomeIcons.xmark,
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

                        if (rideStatus != null) {
                          if ((rideStatus!.name != RideStatus.ongoing.name) &&
                              (rideStatus!.name != RideStatus.completed.name)) {
                            return slideAction;
                          } else {
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
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(
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
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(
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
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(
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
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(
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
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(
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
                          }
                        } else {
                          return slideAction;
                        }
                      }),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
