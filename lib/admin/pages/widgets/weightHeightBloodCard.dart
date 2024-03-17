import 'package:flutter/material.dart';
import 'package:taxi_driver_app/admin/constant.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';
import 'package:taxi_driver_app/core/services/user_service.dart';

import 'custom_card.dart';

class WeightHeightBloodCard extends StatelessWidget {
  const WeightHeightBloodCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: const Color(0xFF2F353E),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          details(
              "Customer",
              users
                  .where((user) => user.userType == UserType.customer)
                  .length
                  .toString()),
          details(
              "Driver",
              users
                  .where((user) => user.userType == UserType.driver)
                  .length
                  .toString()),
          details(
              "Admin",
              users
                  .where((user) => user.userType == UserType.admin)
                  .length
                  .toString()),
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
