import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class TestOnePage extends StatelessWidget {
  final TestOneLogic logic = Get.put(TestOneLogic());
  final TestOneState state = Get.find<TestOneLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<TestOneLogic>(
              builder: (logic) => Text(
                "你点了 ${state.counter} 次",
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Obx(() => Text(
                "Name: ${state.user().name} ，Age: ${state.user.value.age}")),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            OutlinedButton(
                onPressed: () {
                  logic.increment();
                  logic.updateUser("DM", state.counter);
                },
                child: Text("+")),
          ],
        ),
      ),
    );
  }
}
