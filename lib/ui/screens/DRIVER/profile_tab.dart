import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/core/controllers/app/app_constant.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/services/user_service.dart';
import 'package:taxi_driver_app/ui/widgets/icon_style.dart';
import 'package:taxi_driver_app/ui/widgets/settings_group_widget.dart';
import 'package:taxi_driver_app/ui/widgets/settings_item.widget.dart';
import 'package:taxi_driver_app/ui/widgets/small_user_profile_card.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: RefreshIndicator(
        color: theme.primaryColor,
        backgroundColor: theme.primaryColor.withOpacity(0.4),
        onRefresh: () async {},
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // User card
                SmallUserProfileCard(
                  cardColor: theme.primaryColor,
                  userName: authController.getUserModel()!.full_name,
                  userProfilePic: const AssetImage("assets/images/car.png"),
                  theme: theme,
                  userTraillingButton: Container(
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.all(5.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: theme.scaffoldBackgroundColor,
                        size: 15,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  userMoreInfo: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return SizedBox(
                      child: RatingBar.builder(
                        initialRating: 3,
                        itemSize: 10,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: theme.scaffoldBackgroundColor,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    );
                  }),
                  onTap: () {},
                ),

                SettingsGroup(
                  items: [
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.history_toggle_off_outlined,
                      iconStyle: IconStyle(
                        iconsColor: theme.cardColor,
                        withBackground: true,
                        backgroundColor: theme.primaryColor,
                      ),
                      title: 'Ride History',
                      subtitle: "Check your rides history",
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: FontAwesomeIcons.star,
                      iconStyle: IconStyle(
                        iconsColor: theme.cardColor,
                        withBackground: true,
                        backgroundColor: theme.primaryColor,
                      ),
                      title: 'Reviews',
                      subtitle: "Check what customers think",
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: FontAwesomeIcons.moneyBillTransfer,
                      iconStyle: IconStyle(
                        iconsColor: theme.cardColor,
                        withBackground: true,
                        backgroundColor: theme.primaryColor,
                      ),
                      title: 'Balance',
                      subtitle: "Check how much you made",
                    ),
                  ],
                ),
                SettingsGroup(
                  items: [
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.dark_mode_rounded,
                      iconStyle: IconStyle(
                        iconsColor: theme.cardColor,
                        withBackground: true,
                        backgroundColor: theme.primaryColor,
                      ),
                      title: 'Dark mode',
                      subtitle: "Automatic",
                      trailing: StatefulBuilder(
                        builder: (context, setState) {
                          return Switch.adaptive(
                            value: appController.isDarkMode,
                            onChanged: (value) {
                              appController.changeTheme(value);
                            },
                            activeColor: theme.primaryColor,
                          );
                        },
                      ),
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.info_rounded,
                      iconStyle: IconStyle(
                        backgroundColor: Colors.purple,
                      ),
                      title: 'About',
                      subtitle: "Learn more about ${AppConstant.appName}'App",
                    ),
                  ],
                ),
                // You can add a settings title
                SettingsGroup(
                  settingsGroupTitle: "Account",
                  items: [
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.exit_to_app_rounded,
                      title: "Sign Out",
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: CupertinoIcons.delete_solid,
                      title: "Delete account",
                      titleStyle: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
