import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logic.dart';

class TestThreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return TestThreeLogic();
    });
    Get.putAsync<SharedPreferences>(() async {
      final ap = await SharedPreferences.getInstance();
      await ap.setInt('counter', 12345);
      return ap;
    });
  }
}
