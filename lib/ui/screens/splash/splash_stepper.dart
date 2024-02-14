import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:taxi_driver_app/core/controllers/auth/auth_manager_controller.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/controllers/app/navigation_provider.dart';
import '../../../router.dart';
import '../../widgets/walkthrough_stepper.dart';
import '../../widgets/walkthrough_template.dart';

class WalkThrough extends StatelessWidget {
  final PageController _pageViewController = PageController(initialPage: 0);

  WalkThrough({super.key});
  @override
  Widget build(BuildContext context) {
    final NavigationProvider walkthroughProvider =
        Provider.of<NavigationProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  controller: _pageViewController,
                  onPageChanged: (int index) {
                    walkthroughProvider.onPageChange(index);
                  },
                  children: <Widget>[
                    WalkThroughTemplate(
                      title: "Pay with Ease",
                      subtitle:
                          "All your favorite payment methods in one convenient place",
                      image: Image.asset("assets/images/walkthrough1.png"),
                    ),
                    WalkThroughTemplate(
                      title: "Earn Bonuses on Every Ride",
                      subtitle:
                          "Enjoy exciting bonuses on each ride – our way of saying thank you!",
                      image: Image.asset("assets/images/walkthrough2.png"),
                    ),
                    WalkThroughTemplate(
                      title: "Invite Friends and Earn Rewards",
                      subtitle:
                          "Invite friends to join and both of you earn rewarding bonuses!",
                      image: Image.asset("assets/images/walkthrough3.png"),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SplashStepper(controller: _pageViewController),
                    ),
                    ClipOval(
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        child: IconButton(
                          icon: const Icon(
                            Icons.trending_flat,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            if (_pageViewController.page! >= 2) {
                              Get.offAllNamed(InitialRoute);
                            }
                            _pageViewController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          padding: const EdgeInsets.all(13.0),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
