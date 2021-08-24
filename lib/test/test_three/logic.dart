import 'package:get/get.dart';

import 'state.dart';

class TestThreeLogic extends GetxController {
  final state = TestThreeState();

  ///自增
  void increase() {
    state.count = ++state.count;
    update();
  }

  void setCount(int count) {
    state.count = count;
    update();
  }
}
