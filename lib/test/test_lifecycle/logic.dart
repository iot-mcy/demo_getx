import 'package:get/get.dart';

import 'state.dart';

class TestLifecycleLogic extends GetxController {
  final state = TestLifecycleState();

  void increment() => state.count + 1;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ///每次`count1`变化时调用。
    ever(state.count, (_) => print("$_ has been changed"));

    ///只有在变量$_第一次被改变时才会被调用。
    once(state.count, (_) => print("$_ was changed once"));

    ///防DDos - 每当用户停止输入1秒时调用，例如。
    debounce(state.count, (_) => print("debouce$_"), time: Duration(seconds: 1));

    ///忽略1秒内的所有变化。
    interval(state.count, (_) => print("interval $_"), time: Duration(seconds: 1));

  }

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
