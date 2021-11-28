import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'logic.dart';
import 'state.dart';

class VideoPage extends StatelessWidget {
  final VideoLogic logic = Get.put(VideoLogic());
  final VideoState state = Get.find<VideoLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("视频播放"),
      // ),
      body: Center(
        child: AspectRatio(
          aspectRatio: state.controller.value.aspectRatio,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              VideoPlayer(state.controller),
              ClosedCaption(text: state.controller.value.caption.text),
              _ControlsOverlay(controller: state.controller, logic: logic),
              VideoProgressIndicator(state.controller, allowScrubbing: true),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          state.controller.value.isPlaying ? logic.pause() : logic.play();
        },
        child: GetBuilder<VideoLogic>(builder: (logic) {
          return Icon(
            state.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          );
        }),
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay(
      {Key? key, required this.controller, required this.logic})
      : super(key: key);

  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;
  final VideoLogic logic;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: GetBuilder<VideoLogic>(builder: (logic) {
            return controller.value.isPlaying
                ? SizedBox.shrink()
                : Container(
                    color: Colors.black26,
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 100.0,
                      ),
                    ),
                  );
          }),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? logic.pause() : logic.play();
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (context) {
              return [
                for (final speed in _examplePlaybackRates)
                  PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}
