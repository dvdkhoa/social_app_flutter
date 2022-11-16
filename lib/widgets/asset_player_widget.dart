import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'VideoPlayerWidget.dart';

class AssetPlayerWidget extends StatefulWidget {
  AssetPlayerWidget({Key? key, required this.url}) : super(key: key);

  String url;

  @override
  State<AssetPlayerWidget> createState() => _AssetPlayerWidgetState();
}

class _AssetPlayerWidgetState extends State<AssetPlayerWidget> {

  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _videoPlayerController = VideoPlayerController.network(widget.url)
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

