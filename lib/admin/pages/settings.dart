import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/admin/admin_setting_controller.dart';
import 'package:taxi_driver_app/admin/pages/widgets/title_with_line_widget.dart';

import '../responsive.dart';
import 'widgets/activity_details_card.dart';
import 'widgets/bar_graph_card.dart';
import 'widgets/header_widget.dart';
import 'widgets/line_chart_card.dart';

class AdminSettingPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AdminSettingPage({super.key, required this.scaffoldKey});

  @override
  State<AdminSettingPage> createState() => _AdminSettingPageState();
}

class _AdminSettingPageState extends State<AdminSettingPage> {
  final SettingsController controller = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    SizedBox height(BuildContext context) => SizedBox(
          height: Responsive.isDesktop(context) ? 30 : 20,
        );

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context) ? 15 : 18),
          child: Column(
            children: [
              SizedBox(
                height: Responsive.isMobile(context) ? 5 : 18,
              ),
              Header(scaffoldKey: widget.scaffoldKey, title: "Settings"),
              height(context),
              Column(
                children: <Widget>[
                  const TitleWithLineWidget(title: 'Notifications'),
                  Obx(() => SwitchListTile(
                        activeColor: Theme.of(context).primaryColor,
                        title: const Text('Enable Notifications'),
                        subtitle: const Text(
                            'Send trip requests, news, and updates.'),
                        value: controller.notificationsEnabled.value,
                        onChanged: (bool value) {
                          controller.notificationsEnabled.value = value;
                          controller.savePreferences();
                        },
                      )),
                  const TitleWithLineWidget(title: 'Taxi Rates'),
                  buildRateSettingTile(
                    context,
                    title: 'Taxi Rate per Kilometer',
                    rate: controller.rateTaxiPerKilometer,
                  ),
                  buildRateSettingTile(
                    context,
                    title: 'Taxi Rate per Minute',
                    rate: controller.rateTaxiPerMinute,
                  ),
                  const TitleWithLineWidget(title: 'Luxury Rates'),
                  buildRateSettingTile(
                    context,
                    title: 'Luxe Rate per Kilometer',
                    rate: controller.rateLuxePerKilometer,
                  ),
                  buildRateSettingTile(
                    context,
                    title: 'Luxe Rate per Minute',
                    rate: controller.rateLuxePerMinute,
                  ),
                  const TitleWithLineWidget(title: ''),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRateSettingTile(BuildContext context,
      {required String title, required Rx<double> rate}) {
    return Obx(() => ListTile(
          title: Text(title),
          subtitle: Text(rate.value.toStringAsFixed(2)),
          onTap: () => showEditDialog(context, title, rate),
        ));
  }

  Future<void> showEditDialog(
      BuildContext context, String title, Rx<double> rate) async {
    final TextEditingController textController =
        TextEditingController(text: rate.value.toStringAsFixed(2));
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $title'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(labelText: "New Rate"),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                final double? newValue = double.tryParse(textController.text);
                if (newValue != null) {
                  rate.value = newValue;
                  controller.savePreferences();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
