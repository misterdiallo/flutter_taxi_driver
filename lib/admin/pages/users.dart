import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';
import 'package:taxi_driver_app/core/services/user_service.dart';

import '../responsive.dart';
import 'widgets/activity_details_card.dart';
import 'widgets/bar_graph_card.dart';
import 'widgets/build_table_user.dart';
import 'widgets/header_widget.dart';
import 'widgets/line_chart_card.dart';

class AdminUserPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AdminUserPage({super.key, required this.scaffoldKey});

  @override
  State<AdminUserPage> createState() => _AdminUserPageState();
}

class _AdminUserPageState extends State<AdminUserPage> {
  @override
  void initState() {
    super.initState();
    userController.getAllTypeUsersData(UserType.customer);
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
              Header(scaffoldKey: widget.scaffoldKey, title: "Customers"),
              height(context),
              LayoutBuilder(
                builder: (context, constraints) {
                  return const BuildTableUsers(users: UserType.customer);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
