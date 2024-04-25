import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/ride_model.dart';
import 'package:taxi_driver_app/router.dart';
import 'package:taxi_driver_app/ui/widgets/get_color_function.dart';

class RideDetailsCustomer extends StatefulWidget {
  final RideModel? ride;
  final bool isPageOnly;

  const RideDetailsCustomer({
    Key? key,
    this.isPageOnly = false,
    this.ride,
  }) : super(key: key);

  @override
  State<RideDetailsCustomer> createState() => _RideDetailsCustomerState();
}

class _RideDetailsCustomerState extends State<RideDetailsCustomer> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    RideModel ride = widget.ride!;

    return Scaffold(
      appBar: widget.isPageOnly
          ? AppBar(
              centerTitle: true,
              title: Text(
                (ride.ride_status.name == RideStatus.pending.name)
                    ? "Searching "
                    : ride.ride_status.name.toUpperCase(),
                style: theme.textTheme.titleLarge,
              ),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
        child: SizedBox.expand(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      (ride.ride_status.name == RideStatus.pending.name)
                          ? 'Finding the nearest driver...'
                          : "Ride is ${ride.ride_status.name.toUpperCase()}",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: ride.ride_status.name == RideStatus.pending.name
                        ? CircularProgressIndicator(
                            color: theme.primaryColor,
                          )
                        : ride.ride_status.name == RideStatus.canceled.name
                            ? const SizedBox.shrink()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            ride.car!.user.full_name,
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          RatingBarIndicator(
                                            rating: 3.6,
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: theme.primaryColor,
                                            ),
                                            itemCount: 5,
                                            itemSize: 10.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      constraints: const BoxConstraints(
                                          maxWidth: 500, minWidth: 100),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  text: ride.car!.plate_number,
                                                  style: theme
                                                      .textTheme.bodyLarge!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 19,
                                                          color: theme
                                                              .primaryColor),
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      text: ride.car!.model
                                                          .toUpperCase(),
                                                      style: theme
                                                          .textTheme.bodyLarge!
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  SizedBox(
                                                    // width: 50,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Icon(
                                                          Icons.circle,
                                                          color:
                                                              getColorFromName(
                                                                  ride.car!
                                                                      .color),
                                                          size: 15,
                                                        ),
                                                        Text(
                                                          ride.car!.color
                                                              .toUpperCase(),
                                                          style: theme.textTheme
                                                              .bodyLarge!
                                                              .copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                          Row(
                                            children: [
                                              Text(
                                                "Status: ",
                                                style: theme
                                                    .textTheme.bodyLarge!
                                                    .copyWith(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(
                                                      text: ride
                                                          .ride_status.name
                                                          .toUpperCase(),
                                                      style: theme
                                                          .textTheme.bodyLarge!
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                        color:
                                                            theme.primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
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
                                text:
                                    "0${'${ride.start_time.month}'}. ${ride.start_time.day}th\n",
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: Colors.green[600],
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        "0${ride.start_time.hour > 9 ? ride.start_time.hour : '0${ride.start_time.hour}'}:${ride.start_time.minute > 9 ? ride.start_time.minute : '0${ride.start_time.minute}'}",
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
                                text: ride.end_time != null
                                    ? "${'${ride.end_time!.month}'}. ${ride.end_time!.day}th\n"
                                    : "--none--",
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: theme.primaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: ride.end_time != null
                                        ? "${ride.end_time!.hour > 9 ? ride.end_time!.hour : '0${ride.end_time!.hour}'}:${ride.end_time!.minute > 9 ? ride.end_time!.minute : '0${ride.end_time!.minute}'}"
                                        : "",
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
                          onSubmit: () async {
                            if (key.currentState!.submitted) {
                              print("in the submitedd");
                              await customerData.updatedRideStatus(
                                  ride.ride_id, RideStatus.canceled);

                              Get.offAllNamed(HomepageRoute);
                            } else {
                              key.currentState!.reset();
                              return null;
                            }
                          },
                          text: "Slide to Cancel",
                          outerColor: theme.primaryColor,
                          sliderButtonIcon: const Icon(
                            FontAwesomeIcons.xmark,
                          ),
                          submittedIcon: CircularProgressIndicator(
                            color: theme.scaffoldBackgroundColor,
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

                        if ((ride.ride_status.name !=
                                RideStatus.ongoing.name) &&
                            (ride.ride_status.name !=
                                RideStatus.canceled.name) &&
                            (ride.ride_status.name !=
                                RideStatus.completed.name)) {
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
