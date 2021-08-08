import 'package:demo_getx/provider/view_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
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
                if (state.isLoading) {
                  debugPrint("viewState: Loading");
                  return ViewStateLoadingWidget();
                } else if (state.isEmpty) {
                  debugPrint("viewState: Empty");
                  return ViewStateEmptyWidget(onPressed: () {
                    logic.getPictureList();
                  });
                } else if (state.isError) {
                  debugPrint("viewState: Error");
                  return ViewStateErrorWidget(
                      error: state.viewStateError,
                      onPressed: () {
                        logic.getPictureList();
                      });
                } else if (state.isIdle) {
                  debugPrint("viewState: Idle");
                  if (state.pictureList.length > 0) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        primary: false,
                        itemCount: state.pictureList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading:
                                Image.network(state.pictureList[index].thumb),
                            title: Text(state.pictureList[index].thumb),
                          );
                        });
                  } else {
                    return Container();
                  }
                }
                debugPrint("viewState: null");
                return Container();
              }),
          GetBuilder<TestTwoLogic>(
              id: 2,
              builder: (logic) {
                if (state.isLoading) {
                  debugPrint("viewState: Loading");
                  return ViewStateLoadingWidget();
                } else if (state.isEmpty) {
                  debugPrint("viewState: Empty");
                  return ViewStateEmptyWidget(onPressed: () {
                    logic.getPictureList();
                  });
                } else if (state.isError) {
                  debugPrint("viewState: Error");
                  return ViewStateErrorWidget(
                      error: state.viewStateError,
                      onPressed: () {
                        logic.getPictureList();
                      });
                } else if (state.isIdle) {
                  debugPrint("viewState: Idle");
                  if (state.pictureList2.length > 0) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        primary: false,
                        itemCount: state.pictureList2.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading:
                                Image.network(state.pictureList2[index].thumb),
                            title: Text(state.pictureList2[index].thumb),
                          );
                        });
                  } else {
                    return Container();
                  }
                }
                debugPrint("viewState2: null");
                return Text("viewState2: null");
              }),
          Padding(padding: EdgeInsets.only(top: 5)),
          OutlinedButton(
              onPressed: () {
                logic.getPictureList();
              },
              child: Text("请求1")),
          Padding(padding: EdgeInsets.only(top: 5)),
          OutlinedButton(
            onPressed: () {
              logic.getPictureList2();
            },
            child: Text('请求2'),
          ),
        ],
      ),
    );
  }
}
