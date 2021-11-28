import 'package:demo_getx/test/video/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class Video2PageViewPage extends StatelessWidget {
  final Video2PageViewLogic logic = Get.put(Video2PageViewLogic());
  final Video2PageViewState state = Get.find<Video2PageViewLogic>().state;

  // List<Video2fijkplayerPage> listWidget = [
  //  new Video2fijkplayerPage("asset:///assets/video/video1.mp4"),
  //  new Video2fijkplayerPage(
  //  "http://9890.vod.myqcloud.com/9890_4e292f9a3dd011e6b4078980237cc3d3.f20.mp4"),
  //  ];

  List<Widget> listWidget2 = [
    new VideoPage(),
    new VideoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(keepPage: false);
    controller.addListener(() {
      double? d = controller.page;

      ScrollPosition position = controller.position;

      print("controller.page：${d}");
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("抖音视频滑动效果"),
      ),
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: controller,
        children: listWidget2,
        onPageChanged: (int position) {
          print("当前的页面是 $position");
          // Video2fijkplayerPage page = listWidget[position];
          // page.logic.start();
        },
      ),
    );
  }
}
