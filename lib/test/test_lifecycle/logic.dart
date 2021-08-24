import 'package:get/get.dart';

import 'state.dart';

class TestLifecycleLogic extends GetxController {
  final state = TestLifecycleState();

  @override
  void onReady() {
    // TODO: implement onReady
    print("implement onReady");
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    print("implement onClose");
    super.onClose();
  }
}
