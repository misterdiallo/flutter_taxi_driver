import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FirstRunCheckService extends GetxService {
  Future<FirstRunCheckService> init() async => this;

  final box = GetStorage();
  bool get isFirstRun => box.read("isFirstRun") ?? true;
  void updateFirstRunToNo(bool val) => box.write('isFirstRun', val);
}
