import 'package:flutter/material.dart';
import 'package:taxi_driver_app/admin/pages/widgets/build_table_user.dart';
import 'package:taxi_driver_app/admin/pages/widgets/user_manager.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';
import 'package:taxi_driver_app/core/services/user_service.dart';

import '../responsive.dart';
import 'widgets/activity_details_card.dart';
import 'widgets/bar_graph_card.dart';
import 'widgets/header_widget.dart';
import 'widgets/line_chart_card.dart';

class AdminDriverPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AdminDriverPage({super.key, required this.scaffoldKey});

  @override
  State<AdminDriverPage> createState() => _AdminDriverPageState();
}

class _AdminDriverPageState extends State<AdminDriverPage> {
  @override
  Widget build(BuildContext context) {
    SizedBox height(BuildContext context) => SizedBox(
          height: Responsive.isDesktop(context) ? 30 : 20,
        );
    List<UserModel> drivers =
        users.where((user) => user.userType == UserType.driver).toList();

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
              Header(scaffoldKey: widget.scaffoldKey, title: "Drivers"),
              height(context),
              LayoutBuilder(
                builder: (context, constraints) {
                  return BuildTableUsers(users: drivers);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
