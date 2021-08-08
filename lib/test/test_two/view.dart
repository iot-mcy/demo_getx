import 'package:demo_getx/net/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'modes/picture.dart';
import 'state.dart';

class TestTwoPage extends StatelessWidget {
  final TestTwoLogic logic = Get.put(TestTwoLogic());
  final TestTwoState state = Get.find<TestTwoLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("网络请求图片"),
      ),
      body: Column(
        children: [
          GetBuilder<TestTwoLogic>(
              id: 1,
              builder: (logic) {
                if (state.pictureList().isLoading) {
                  debugPrint("viewState: Loading");
                  return Text("viewState: Loading");
                } else if (state.pictureList().isEmpty) {
                  debugPrint("viewState: Empty");
                  return Text("viewState: Empty");
                } else if (state.pictureList().isError) {
                  debugPrint("viewState: Error");
                  return Text("viewState: Error");
                } else if (state.pictureList().isIdle) {
                  debugPrint("viewState: Idle");
                  return Text("viewState: Idle");
                }
                debugPrint("viewState: null");
                return Text("viewState: null");
              }),
          GetBuilder<TestTwoLogic>(
              id: 2,
              builder: (logic) {
                debugPrint("viewState2: null");
                return Text("viewState2: null");
              }),
          Padding(padding: EdgeInsets.only(top: 5)),
          OutlinedButton(
              onPressed: () async {

              },
              child: Text("请求")),
          Padding(padding: EdgeInsets.only(top: 5)),
          OutlinedButton(
            onPressed: () {
              // getPictureList();
              logic.getPictureList2();
            },
            child: Text('请求2'),
          ),
        ],
      ),
    );
  }
}
