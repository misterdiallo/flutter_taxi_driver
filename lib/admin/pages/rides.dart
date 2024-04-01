import 'package:flutter/material.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/ride_model.dart';
import 'package:taxi_driver_app/core/services/ride_service.dart';

import '../responsive.dart';
import 'widgets/activity_details_card.dart';
import 'widgets/bar_graph_card.dart';
import 'widgets/build_table_user.dart';
import 'widgets/header_widget.dart';
import 'widgets/line_chart_card.dart';

class AdminRidePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AdminRidePage({super.key, required this.scaffoldKey});

  @override
  State<AdminRidePage> createState() => _AdminRidePageState();
}

class _AdminRidePageState extends State<AdminRidePage> {
  @override
  void initState() {
    super.initState();
    ridesController.getAllRides();
  }

  @override
  Widget build(BuildContext context) {
    SizedBox height(BuildContext context) => SizedBox(
          height: Responsive.isDesktop(context) ? 30 : 20,
        );

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context) ? 15 : 18),
          child: Column(
            children: [
              SizedBox(
                height: Responsive.isMobile(context) ? 5 : 18,
              ),
              Header(scaffoldKey: widget.scaffoldKey, title: "All Rides"),
              height(context),
              LayoutBuilder(
                builder: (context, constraints) {
                  return RidesTable(rides: rideList);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
