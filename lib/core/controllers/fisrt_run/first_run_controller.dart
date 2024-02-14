import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FirstRunCheckController extends GetxController {
  static const _firstRunSettingsKey = 'is_first_run';
  static const _firstCallSettingsKey = 'is_first_call';
  static const _firstRunSettingDateTime = 'first_run_date_time';

  final box = GetStorage();
  static FirstRunCheckController instance = Get.find();
  bool? _isFirstRun;

  /// Checks if the application is being run for the first time.
  Future<bool> isFirstCall() async {
    bool firstCall = box.read(_firstCallSettingsKey) ?? true;
    box.write(_firstCallSettingsKey, false);
    return firstCall;
  }

  /// Checks if the application is being run for the first time ever or after a reset.
  Future<bool> isFirstRun() async {
    if (_isFirstRun != null) {
      return _isFirstRun!;
    } else {
      final box = GetStorage();
      bool isFirstRun = box.read(_firstRunSettingsKey) ?? true;
      box.write(_firstRunSettingsKey, false);
      box.write(_firstRunSettingDateTime, DateTime.now().toString());
      _isFirstRun = isFirstRun;
      return isFirstRun;
    }
  }

  /// Resets the first run status and first call status.
  Future<void> reset() async {
    final box = GetStorage();
    box.write(_firstRunSettingsKey, true);
    box.write(_firstCallSettingsKey, true);
  }
}
