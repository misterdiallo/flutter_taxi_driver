import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/ride_model.dart';
import 'package:taxi_driver_app/ui/screens/CUSTOMER/ride_detail_page_customer.dart';
import 'package:taxi_driver_app/ui/utils/conversion_utils.dart';
import 'package:taxi_driver_app/ui/utils/date_utlis.dart';
import 'package:taxi_driver_app/ui/utils/money_formatter.dart';
import '../../widgets/ride_card.dart';
import '../../widgets/ride_cards.dart';
import 'ride_detail/ride_main_page.dart';

class DriverBalance extends StatefulWidget {
  const DriverBalance({super.key});

  @override
  State<DriverBalance> createState() => _DriverBalanceState();
}

class _DriverBalanceState extends State<DriverBalance> {
  late Stream<Map<String, List?>> _pendingRidesStream;

  @override
  void initState() {
    super.initState();
    _pendingRidesStream = driverData.getAllCompletedMyRides().asStream();
  }

  Future<void> refreshAllMyRides() async {
    setState(() {
      _pendingRidesStream = driverData.getAllCompletedMyRides().asStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Balance"),
      ),
      body: RefreshIndicator(
        color: theme.primaryColor,
        backgroundColor: theme.primaryColor.withOpacity(0.4),
        onRefresh: refreshAllMyRides,
        child: StreamBuilder(
            stream: _pendingRidesStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final List<RideModel> pendingRides =
                    snapshot.data!['rides']!.cast<RideModel>();
                final List<String> fares =
                    snapshot.data!['fares']!.cast<String>();
                if (pendingRides.isEmpty) {
                  return const Center(
                    child: Text('You should complete at least a ride.'),
                  );
                } else {
                  var totalBalance = MoneyFormatter.calculateTotalFare(fares);
                  return Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                MoneyFormatter.formatStringToMoney(
                                    totalBalance.toString()),
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 28,
                                  color: theme.primaryColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Implement logic to accept the ride
                                  // You can call a function here to accept the ride
                                  // acceptRide(ride, index);
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
                                  'Withdraw',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    // fontSize: 1,
                                    fontWeight: FontWeight.bold,
                                    color: theme.scaffoldBackgroundColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        // Use Expanded to make the ListView take remaining space
                        child: ListView.builder(
                          itemCount: pendingRides.length,
                          itemBuilder: (context, index) {
                            final ride = pendingRides[index];
                            return GestureDetector(
                              onTap: () {
                                // Navigate to RideDetails page when Card is clicked
                                Get.to(() =>
                                        RideDetails(ride: ride, id: index))!
                                    .then((value) async {
                                  await refreshAllMyRides();
                                });
                              },
                              child: Card(
                                elevation:
                                    4, // Add elevation for a card-like appearance
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.6,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 95.0,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.green[600],
                                                ),
                                                Container(
                                                  width: 4.0,
                                                  height: 4.0,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Container(
                                                  width: 4.0,
                                                  height: 4.0,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Container(
                                                  width: 4.0,
                                                  height: 4.0,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black,
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ListTile(
                                                  minVerticalPadding: 0,
                                                  dense: true,
                                                  subtitle: Text(
                                                    ride.ride_origin_place
                                                        .address,
                                                    style: theme
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  title: Text(
                                                    ride.ride_origin_place.name,
                                                    style: theme
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  dense: true,
                                                  subtitle: Text(
                                                    ride.ride_end_place.address,
                                                    style: theme
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  title: Text(
                                                    ride.ride_end_place.name,
                                                    style: theme
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              ride.ride_status.name
                                                  .toUpperCase(),
                                              style: theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: theme.primaryColor,
                                              ),
                                            ),
                                            Text(
                                              MoneyFormatter
                                                  .formatStringToMoney(
                                                      ride.fare),
                                              style: theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              }
            }),
      ),
    );
  }
}
