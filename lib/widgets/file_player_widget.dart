import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'VideoPlayerWidget.dart';

class FilePlayerWidget extends StatefulWidget {
  FilePlayerWidget({Key? key, required this.file}) : super(key: key);

  File file;

  @override
  State<FilePlayerWidget> createState() => _AssetFilePlayerWidgetState();
}

class _AssetFilePlayerWidgetState extends State<FilePlayerWidget> {

  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _videoPlayerController = VideoPlayerController.file(widget.file)
      ..addListener(() { setState(() {});})
      ..setLooping(true)
      ..initialize().then((_) { setState(() {
        // _videoPlayerController.play();
      }); });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidget(controller: _videoPlayerController);
  }
}

