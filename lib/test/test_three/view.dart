import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logic.dart';
import 'state.dart';

class TestThreePage extends StatelessWidget {
  final logic = Get.find<TestThreeLogic>();
  final TestThreeState state = Get.find<TestThreeLogic>().state;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试Binding'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<TestThreeLogic>(builder: (logic) {
              return Text("点击了${state.count}次");
            }),
            OutlinedButton(
                onPressed: () {
                  _prefs.then((SharedPreferences prefs) {
                    int count = prefs.getInt('counter') ?? 0;
                    logic.setCount(count);
                  });
                },
                child: Text("加载缓存")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logic.increase();
          _prefs.then((SharedPreferences prefs) {
            prefs.setInt('counter', state.count);
          });
          // SharedPreferences prefs = await _prefs;
          // prefs.setInt('counter', state.count);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
