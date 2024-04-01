import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:taxi_driver_app/admin/constant.dart';
import 'package:taxi_driver_app/core/controllers/auth/users_controller.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';
import 'package:taxi_driver_app/core/services/user_service.dart';

import 'custom_card.dart';

class WeightHeightBloodCard extends StatefulWidget {
  const WeightHeightBloodCard({
    super.key,
  });

  @override
  State<WeightHeightBloodCard> createState() => _WeightHeightBloodCardState();
}

class _WeightHeightBloodCardState extends State<WeightHeightBloodCard> {
  @override
  void initState() {
    super.initState();
    userController.countUsers(UserType.admin);
    userController.countUsers(UserType.driver);
    userController.countUsers(UserType.customer);
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: const Color(0xFF2F353E),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => details(
              "Customer",
              userController.totalCustomer.value.toString(),
            ),
          ),
          Obx(
            () => details("Driver", userController.totalDriver.toString()),
          ),
          Obx(
            () => details("Admin", userController.totalAdmin.toString()),
          ),
        ],
      ),
    );
  }

  Widget details(String key, String value) {
    return Column(
      children: [
        Text(
          key,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
