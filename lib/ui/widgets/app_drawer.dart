import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/services/user_service.dart';

import '../../router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List drawerMenu = [
      {
        "icon": Icons.restore,
        "text": "My rides",
        "route": MyRidesRoute,
      },
      {
        "icon": Icons.credit_card,
        "text": "My payments",
        "route": PaymentRoute,
      },
      {
        "icon": Icons.logout,
        "text": "Logout",
        "route": "logout",
      },
      // {
      //   "icon": Icons.chat,
      //   "text": "Support",
      //   "route": ChatRiderRoute,
      // }
    ];
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width -
          (MediaQuery.of(context).size.width * 0.2),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              height: 170.0,
              color: theme.primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CircleAvatar(
                    radius: 30.0,
                    child: Icon(FontAwesomeIcons.faceGrimace),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        authController.fullName.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(ProfileRoute);
                        },
                        child: const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Text(
                    authController.phoneNumber.toString(),
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 15.0,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 20.0,
                ),
                child: ListView(
                  children: drawerMenu.map((menu) {
                    return GestureDetector(
                      onTap: () {
                        if (menu['route'] == "logout") {
                          authController.logoutUser();
                        }
                        Navigator.of(context).pushNamed(menu["route"]);
                      },
                      child: ListTile(
                        leading: Icon(menu["icon"]),
                        title: Text(
                          menu["text"],
                          style: const TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
