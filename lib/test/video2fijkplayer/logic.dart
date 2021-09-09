import 'package:fijkplayer/fijkplayer.dart';
import 'package:get/get.dart';

import 'state.dart';

class Video2fijkplayerLogic extends GetxController {
  final state = Video2fijkplayerState();

  void startPlay() async {
    // state.player.setOption(FijkOption.hostCategory, "enable-snapshot", 1);
    // state.player.setOption(FijkOption.hostCategory, "request-screen-on", 1);
    // state.player.setOption(FijkOption.hostCategory, "request-audio-focus", 1);
    // state.player.setOption(FijkOption.playerCategory, "mediacodec-all-videos", 1);

    FijkOption fijkOption = new FijkOption();
    fijkOption.setHostOption("enable-snapshot", 1);
    fijkOption.setHostOption("request-screen-on", 1);
    fijkOption.setHostOption("request-audio-focus", 1);
    fijkOption.setPlayerOption("mediacodec-all-videos", 1);
    await state.player.applyOptions(fijkOption);

    await state.player
        .setDataSource(
            "http://9890.vod.myqcloud.com/9890_4e292f9a3dd011e6b4078980237cc3d3.f20.mp4",
            autoPlay: false,
            showCover: true)
        .then((value) {
      print("setDataSource then: ");
    }).catchError((e) {
      print("setDataSource error: $e");
    });
  }

  void start() {
    state.player.start().then((value) {
      update();
    });
  }

  void pause() {
    state.player.pause().then((value) {
      update();
    });
  }

  void stop() {
    state.player.stop().then((value) {
      update();
    });
  }

  void reset() {
    state.player.reset().then((value) {
      update();
    });
  }

  void seekTo(int msec) {
    state.player.seekTo(msec).then((value) {
      update();
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    startPlay();
    state.player..addListener(_fijkValueListener);
    super.onInit();
  }

  void _fijkValueListener() {
    FijkValue value = state.player.value;

    if (value.prepared) {
      print("value.prepared");
    }
    if (value.audioRenderStart) {
      print("value.audioRenderStart");
    }
    if (value.videoRenderStart) {
      print("value.videoRenderStart");
    }
    if (value.fullScreen) {
      print("value.fullScreen");
    }
    if (value.completed) {
      print("value.completed");
    }

    if (value.state == FijkState.idle) {
      print("value.state==idle");
    } else if (value.state == FijkState.initialized) {
      print("value.state==initialized");
    } else if (value.state == FijkState.asyncPreparing) {
      print("value.state==asyncPreparing");
    } else if (value.state == FijkState.prepared) {
      print("value.state==prepared");
    } else if (value.state == FijkState.started) {
      print("value.state==started");
    } else if (value.state == FijkState.paused) {
      print("value.state==paused");
    } else if (value.state == FijkState.completed) {
      print("value.state==completed");
    } else if (value.state == FijkState.stopped) {
      print("value.state==stopped");
    } else if (value.state == FijkState.end) {
      print("value.state==end");
    } else if (value.state == FijkState.error) {
      print("value.state==error");
    }

    update();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    state.player.removeListener(_fijkValueListener);
    state.player.release();
    super.onClose();
  }
}
