import 'dart:math';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class Video2fijkplayerPage extends StatelessWidget {
  final Video2fijkplayerLogic logic = Get.put(Video2fijkplayerLogic());
  final Video2fijkplayerState state = Get.find<Video2fijkplayerLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FijkPlayer")),
      body: Container(
        child: Center(
          child: FijkView(
            player: state.player,
            fsFit: FijkFit.cover,
            // panelBuilder: fijkPanel2Builder(),
            // panelBuilder:simplestUI(state.player, context, Size.infinite, Rect.largest),
            panelBuilder: (
              FijkPlayer player,
              FijkData data,
              BuildContext context,
              Size viewSize,
              Rect texturePos,
            ) {
              /// 使用自定义的布局
              return CustomFijkPanel(
                player: player,
                buildContext: context,
                viewSize: viewSize,
                texturePos: texturePos,
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (state.player.state == FijkState.prepared ||
              state.player.state == FijkState.paused ||
              state.player.state == FijkState.completed) {
            logic.start();
          } else {
            logic.pause();
          }
        },
        child: GetBuilder<Video2fijkplayerLogic>(builder: (logic) {
          return Icon(
            state.player.state == FijkState.prepared ||
                    state.player.state == FijkState.paused ||
                    state.player.state == FijkState.completed
                ? Icons.play_arrow
                : Icons.pause,
          );
        }),
      ),
    );
  }
}

class CustomFijkPanel extends StatefulWidget {
  final FijkPlayer player;
  final BuildContext buildContext;
  final Size viewSize;
  final Rect texturePos;

  const CustomFijkPanel({
    required this.player,
    required this.buildContext,
    required this.viewSize,
    required this.texturePos,
  });

  @override
  _CustomFijkPanelState createState() => _CustomFijkPanelState();
}

class _CustomFijkPanelState extends State<CustomFijkPanel> {
  FijkPlayer get player => widget.player;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    widget.player.addListener(_playerValueChanged);
  }

  void _playerValueChanged() {
    FijkValue value = player.value;

    bool playing = (value.state == FijkState.started);
    if (playing != _playing) {
      setState(() {
        _playing = playing;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Rect rect = Rect.fromLTRB(
        max(0.0, widget.texturePos.left),
        max(0.0, widget.texturePos.top),
        min(widget.viewSize.width, widget.texturePos.right),
        min(widget.viewSize.height, widget.texturePos.bottom));

    return Positioned.fromRect(
      rect: rect,
      child: Container(
        alignment: Alignment.bottomLeft,
        child: IconButton(
          icon: Icon(
            _playing ? Icons.pause : Icons.play_arrow,
            color: Colors.white24,
            size: 60,
          ),
          onPressed: () {
            _playing ? widget.player.pause() : widget.player.start();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.removeListener(_playerValueChanged);
  }
}
