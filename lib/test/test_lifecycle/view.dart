import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class TestLifecyclePage extends StatelessWidget {
  final TestLifecycleLogic logic = Get.put(TestLifecycleLogic());
  final TestLifecycleState state = Get.find<TestLifecycleLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("生命周期"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(""),
          ],
        ),
      ),
    );
  }
}
