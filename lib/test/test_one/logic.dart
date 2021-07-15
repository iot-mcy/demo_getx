import 'package:demo_getx/test/test_one/user.dart';
import 'package:get/get.dart';

import 'state.dart';

class TestOneLogic extends GetxController {
  final state = TestOneState();

  void increment() {
    state.counter++;
    update();
  }

  void updateUser(String name, int age) {
    // state.user.update((user) {
    //   if (user != null) {
    //     user.name = name;
    //     user.age = age;
    //   }
    // });
    state.user(User(name: name, age: age));
  }
}
