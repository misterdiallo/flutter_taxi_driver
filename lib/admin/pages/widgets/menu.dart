import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/admin/admin_nav_controller.dart';
import 'package:taxi_driver_app/admin/admin_routes.dart';
import 'package:taxi_driver_app/admin/model/menu_modal.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/router.dart';

import '../../responsive.dart';

class Menu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Menu({super.key, required this.scaffoldKey});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<MenuModel> menu = [
    MenuModel(
        icon: 'assets/svg/home.svg',
        title: "Dashboard",
        route: AdminRoutes.AdminHomeRoute),
    MenuModel(
        icon: 'assets/svg/profile.svg',
        title: "Drivers",
        route: AdminRoutes.AdminDriverRoute),
    MenuModel(
        icon: 'assets/svg/profile.svg',
        title: "Users",
        route: AdminRoutes.AdminUserRoute),
    MenuModel(
        icon: 'assets/svg/history.svg',
        title: "Rides",
        route: AdminRoutes.AdminRideRoute),
    MenuModel(
        icon: 'assets/svg/setting.svg',
        title: "Settings",
        route: AdminRoutes.AdminSettingRoute),
    MenuModel(icon: 'assets/svg/signout.svg', title: "Signout", route: ""),
  ];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Colors.grey[800]!,
              width: 1,
            ),
          ),
          color: const Color(0xFF171821)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: Responsive.isMobile(context) ? 40 : 80,
            ),
            for (var i = 0; i < menu.length; i++)
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                  color: selected == i
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selected = i;
                    });
                    if (i == menu.length - 1) {
                      authController.logOut();
                      Get.offAllNamed(InitialRoute);
                    } else {
                      Get.find<AdminNavController>().changePage(menu[i].route);
                    }
                    widget.scaffoldKey.currentState!.closeDrawer();
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 7),
                        child: SvgPicture.asset(
                          menu[i].icon,
                          color: selected == i ? Colors.black : Colors.grey,
                        ),
                      ),
                      Text(
                        menu[i].title,
                        style: TextStyle(
                            fontSize: 16,
                            color: selected == i ? Colors.black : Colors.grey,
                            fontWeight: selected == i
                                ? FontWeight.w600
                                : FontWeight.normal),
                      )
                    ],
                  ),
                ),
              ),
          ],
        )),
      ),
    );
  }
}
