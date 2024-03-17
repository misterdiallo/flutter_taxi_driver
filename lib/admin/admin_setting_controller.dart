import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final box = GetStorage();
  var notificationsEnabled = false.obs;
  var darkModeEnabled = false.obs;
  var preferredNavigationApp = 'Google Maps'.obs;

  // Pricing rates
  Rx<double> rateTaxiPerKilometer = 0.0.obs;
  Rx<double> rateTaxiPerMinute = 0.0.obs;
  Rx<double> rateLuxePerKilometer = 0.0.obs;
  Rx<double> rateLuxePerMinute = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadPreferences();
  }

  void loadPreferences() {
    notificationsEnabled.value = box.read('notificationsEnabled') ?? true;
    darkModeEnabled.value = box.read('darkModeEnabled') ?? false;
    rateTaxiPerKilometer.value = box.read('rateTaxiPerKilometer') ?? 6.0;
    rateTaxiPerMinute.value = box.read('rateTaxiPerMinute') ?? 0.5;
    rateLuxePerKilometer.value = box.read('rateLuxePerKilometer') ?? 12.0;
    rateLuxePerMinute.value = box.read('rateLuxePerMinute') ?? 1.0;
  }

  void savePreferences() {
    box.write('notificationsEnabled', notificationsEnabled.value);
    box.write('darkModeEnabled', darkModeEnabled.value);
    box.write('rateTaxiPerKilometer', rateTaxiPerKilometer.value);
    box.write('rateTaxiPerMinute', rateTaxiPerMinute.value);
    box.write('rateLuxePerKilometer', rateLuxePerKilometer.value);
    box.write('rateLuxePerMinute', rateLuxePerMinute.value);
  }
}
