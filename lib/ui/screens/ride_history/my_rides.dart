import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/ride_model.dart';
import 'package:taxi_driver_app/ui/utils/date_utlis.dart';
import '../../widgets/ride_card.dart';
import '../../widgets/ride_cards.dart';

class MyRides extends StatelessWidget {
  const MyRides({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<RideModel> listOfMyRides = customerData.listOfMyRides;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.back();
                },
              )
            : null,
        title: Text(
          "Rides History",
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: listOfMyRides.isNotEmpty
            ? ListView.builder(
                itemCount: listOfMyRides.length,
                itemBuilder: (context, index) {
                  final ride = listOfMyRides[index];
                  return Card(
                    elevation: 2,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          children: [
                            TextSpan(
                              text: ride.ride_origin_place.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            const TextSpan(
                              text: ' to ',
                            ),
                            TextSpan(
                              text: ride.ride_end_place.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(formatToDateTimeFromApi(
                              ride.start_time.toString())),
                          Text(ride.fare),

                          Text(ride.car!
                              .plate_number), // Replace with actual driver name
                        ],
                      ),
                      // trailing: Chip(
                      //   backgroundColor: theme.primaryColor,
                      //   label: Text(
                      //     ride.ride_status.name.toString().toUpperCase(),
                      //     style: const TextStyle(color: Colors.white),
                      //   ),
                      // ),
                      // Add more details as needed (car, ratings, etc.)
                    ),
                  );
                  // return Container(
                  //   margin: const EdgeInsets.only(bottom: 15.0),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(15.0),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.withOpacity(0.3),
                  //         spreadRadius: 2,
                  //         blurRadius: 5,
                  //         offset: const Offset(0, 2),
                  //       ),
                  //     ],
                  //   ),
                  //   child: ListTile(
                  //     contentPadding: const EdgeInsets.all(15.0),
                  //     title: Text(
                  //       ride.car!.plate_number.toString(),
                  //       style: const TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //     subtitle: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         const SizedBox(height: 5.0),
                  //         Text(
                  //           "${ride.ride_origin_place.name} - ${ride.ride_end_place.name}",
                  //           style: theme.textTheme.bodyLarge!.copyWith(
                  //             fontWeight: FontWeight.w300,
                  //           ),
                  //           maxLines: 3,
                  //           overflow: TextOverflow.ellipsis,
                  //         ),
                  //         const SizedBox(height: 5.0),
                  //         Text(
                  //           formatToDateTimeFromApi(ride.start_time.toString())
                  //               .toString(), // Format date as per your requirement
                  //           style: const TextStyle(
                  //             color: Colors.grey,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     trailing: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.end,
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           ride.fare,
                  //           style: theme.textTheme.bodyLarge!.copyWith(
                  //             // fontSize: 20.0,
                  //             color: theme.primaryColor,
                  //             fontWeight: FontWeight.w400,
                  //           ),
                  //         ),
                  //         const SizedBox(height: 5.0),
                  //         Text(
                  //           "Price",
                  //           style: theme.textTheme.bodyLarge!.copyWith(
                  //             color: Colors.grey,
                  //             fontWeight: FontWeight.w200,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // );
                },
              )
            : const Center(
                child: Text("-- Empty --"),
              ),
      ),
    );
  }
}
