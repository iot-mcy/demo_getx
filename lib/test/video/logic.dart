import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'state.dart';

class VideoLogic extends GetxController {
  final state = VideoState();

  void play() {
    state.controller.play();
    update();
  }

  void pause() {
    state.controller.pause();
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    state.controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      // closedCaptionFile: _loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    state.controller.addListener(() {
      print("");
    });
    state.controller.setLooping(true);
    state.controller.initialize();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    state.controller.dispose();
    super.onClose();
  }
}
