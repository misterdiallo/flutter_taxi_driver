import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';

class HomePageDriver extends StatefulWidget {
  const HomePageDriver({super.key});

  @override
  State<HomePageDriver> createState() => _HomePageDriverState();
}

class _HomePageDriverState extends State<HomePageDriver> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    driverData.listAvailableRides();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Obx(
            () => PageView(
              controller: bottomNavigationBarController.pageController.value,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                  bottomNavigationBarController.bottomBarPages.length, (index) {
                return bottomNavigationBarController.bottomBarPages[index].page;
              }),
            ),
          ),
          // Positioned(
          //   top: 10,
          //   right: 10,
          //   child: GestureDetector(
          //     onTap: () {
          //       notificationDrawerController.toggleDrawer(_scaffoldKey);
          //     },
          //     child: Container(
          //       margin: const EdgeInsets.only(right: 6),
          //       width: 30,
          //       height: 30,
          //       child: Stack(
          //         children: [
          //           Icon(
          //             Icons.notifications,
          //             color: theme.primaryColor,
          //             size: 30,
          //           ),
          //           notificationController.getUnreadNotifications().isNotEmpty
          //               ? Container(
          //                   width: 30,
          //                   height: 30,
          //                   alignment: Alignment.topRight,
          //                   child: Container(
          //                     width: 15,
          //                     height: 15,
          //                     decoration: BoxDecoration(
          //                       shape: BoxShape.circle,
          //                       color: theme.scaffoldBackgroundColor,
          //                       border: Border.all(
          //                           color: theme.highlightColor, width: 1),
          //                     ),
          //                     child: Padding(
          //                       padding: const EdgeInsets.all(0.0),
          //                       child: Center(
          //                         child: Text(
          //                           notificationController
          //                               .getUnreadNotifications()
          //                               .length
          //                               .toString(),
          //                           style: TextStyle(
          //                             fontSize: 10,
          //                             color: theme.primaryColor,
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 )
          //               : const SizedBox.shrink(),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: Obx(
        () => AnimatedNotchBottomBar(
          /// Provide NotchBottomBarController
          notchBottomBarController:
              bottomNavigationBarController.notchController.value,
          color: theme.primaryColor,
          showLabel: false,
          notchColor: theme.primaryColor.withOpacity(0.8),
          removeMargins: false,
          bottomBarWidth: 500,
          durationInMilliSeconds: 200,
          bottomBarItems: bottomNavigationBarController.bottomBarPages.map((e) {
            return BottomBarItem(
              inActiveItem: e.normalIcon,
              activeItem: e.normalIcon,
              itemLabel: e.title,
            );
          }).toList(),

          onTap: (index) {
            bottomNavigationBarController.pageController.value
                .jumpToPage(index);
          },
          kIconSize: 20,
          kBottomRadius: 5,
        ),
      ),
      endDrawer: Obx(() {
        if (notificationDrawerController.isDrawerOpen.value) {
          return NotificationPanel(
            onClose: () {
              notificationDrawerController.toggleDrawer(_scaffoldKey);
            },
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}

class NotificationPanel extends StatelessWidget {
  final VoidCallback onClose;
  final int maxTextLength;

  const NotificationPanel({
    Key? key,
    required this.onClose,
    this.maxTextLength = 20, // Default value for maxTextLength
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Widget makeListtile({
      required String title,
      required String message,
      void Function()? onTap,
      IconData iconData = Icons.info_outline,
      required bool isRead,
    }) {
      return ListTile(
          onTap: onTap,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          style: ListTileStyle.drawer,
          tileColor:
              isRead ? theme.primaryColor.withOpacity(0.4) : theme.primaryColor,
          leading: Container(
            padding: const EdgeInsets.only(right: 10.0),
            decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.white12))),
            child: Icon(iconData, color: Colors.white),
          ),
          title: Text(
            _truncateText(title, maxTextLength),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            _truncateText(message, 35),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.w300, color: Colors.white),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0));
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      color: theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Notifications (${notificationController.getUnreadNotifications().length})',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              var sortedNotifications =
                  notificationController.getNotificationsSortedByReadStatus();
              return ListView.builder(
                itemCount: sortedNotifications.length,
                itemBuilder: (context, index) {
                  var notif = sortedNotifications[index];
                  return Card(
                    elevation: 8.0,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    borderOnForeground: false,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      decoration: const BoxDecoration(
                          // color: theme.primaryColorDark,
                          ),
                      child: makeListtile(
                          title: notif.title,
                          message: notif.message,
                          isRead: notif.isRead,
                          onTap: () {
                            notificationController.markAsRead(index);
                            notificationController.update();
                          }),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  String _truncateText(String text, int maxLength) {
    return text.length <= maxLength
        ? text
        : '${text.substring(0, maxLength)}...';
  }
}
