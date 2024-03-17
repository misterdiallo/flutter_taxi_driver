import 'package:flutter/material.dart';
import 'package:taxi_driver_app/core/controllers/app/app_constant.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';

import '../constant.dart';
import '../responsive.dart';
import 'widgets/scheduled.dart';
import 'widgets/weightHeightBloodCard.dart';

class ProfileAdmin extends StatelessWidget {
  const ProfileAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Responsive.isMobile(context) ? 10 : 30.0),
          topLeft: Radius.circular(Responsive.isMobile(context) ? 10 : 30.0),
        ),
        color: cardBackgroundColor,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              // Image.asset(
              //   AppConstant.appLogoPath,
              // ),
              Icon(
                Icons.info_outline,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                AppConstant.appName.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.all(Responsive.isMobile(context) ? 15 : 20.0),
                child: const WeightHeightBloodCard(),
              ),
              SizedBox(
                height: Responsive.isMobile(context) ? 20 : 40,
              ),
              Scheduled()
            ],
          ),
        ),
      ),
    );
  }
}
