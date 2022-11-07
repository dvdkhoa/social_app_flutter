import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {

  VideoPlayerController controller;

  VideoPlayerWidget({Key? key, required this.controller})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
          heightFactor: 1.2,
            child: controller != null && controller.value.isInitialized
                ? AspectRatio(child: buildVideo(), aspectRatio: controller.value.aspectRatio )
                : CircularProgressIndicator(),
        );
  }


  Widget buildVideo() => Stack(children: [
    buildVideoPlayer(),
    Positioned.fill(child: BasicOverlayWidget(controller: controller),)

  ]);

  Widget buildVideoPlayer() => VideoPlayer(controller);
}

class BasicOverlayWidget extends StatelessWidget{
  VideoPlayerController controller;

  BasicOverlayWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => controller.value.isPlaying ? controller.pause() : controller.play(),
      child: Stack(
        children: [
          buildPlay(),
          Positioned(child: buildIndicator(),
          left: 0,
          right: 0,
          bottom: 0,)
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return VideoProgressIndicator(controller, allowScrubbing: true);
  }

  Widget buildPlay() => controller.value.isPlaying
                          ? Container()
                          : Container(child: Icon(Icons.play_arrow, color: Colors.white, size: 50), alignment: Alignment.center, color: Colors.black26,);
}
