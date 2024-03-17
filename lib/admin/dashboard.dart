import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/admin/admin_nav_controller.dart';
import 'package:taxi_driver_app/admin/constant.dart';
import 'package:taxi_driver_app/admin/pages/profile.dart';
import 'pages/widgets/menu.dart';
import 'responsive.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var navController = Get.put(AdminNavController(scaffoldKey: _scaffoldKey),
        permanent: true); // Instantiate the controller
    return Scaffold(
      backgroundColor: primaryColorCode,
      key: _scaffoldKey,
      drawer: !Responsive.isDesktop(context)
          ? SizedBox(width: 250, child: Menu(scaffoldKey: _scaffoldKey))
          : null,
      endDrawer: Responsive.isMobile(context)
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const ProfileAdmin())
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 3,
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Menu(scaffoldKey: _scaffoldKey)),
              ),
            Expanded(
              flex: 8,
              // Use GetX to listen to changes
              child: Obx(() => navController.currentPage),
            ),
            if (!Responsive.isMobile(context))
              const Expanded(
                flex: 4,
                child: ProfileAdmin(),
              ),
          ],
        ),
      ),
    );
  }
}
