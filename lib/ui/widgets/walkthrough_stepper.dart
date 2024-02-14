import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_driver_app/core/controllers/app/navigation_provider.dart';

class SplashStepper extends StatelessWidget {
  final PageController controller;

  const SplashStepper({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        3,
        (int index) {
          return Consumer<NavigationProvider>(
            builder: (BuildContext context, NavigationProvider walkthrough,
                Widget? child) {
              return GestureDetector(
                onTap: () {
                  controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Container(
                    height: 5.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: index <= walkthrough.currentPageValue
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: const EdgeInsets.only(right: 5.0),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
