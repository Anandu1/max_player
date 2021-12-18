import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final VideoPlayerController? videoPlayerController;
  final bool? loop;
  final double? aspect;
  final String? placeHolder;
  const VideoPlayer({
    Key? key,
    this.videoPlayerController,
    this.loop,
    this.aspect, this.placeHolder
  }) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  ChewieController? chewieController;

  @override
  void initState() {
    chewieController=ChewieController(
        looping: widget.loop!,
        autoPlay: true,
        cupertinoProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          backgroundColor: Colors.red,
          bufferedColor: Colors.red
        ),
        materialProgressColors: ChewieProgressColors(
            playedColor: Colors.red,
            backgroundColor: Colors.grey,
            bufferedColor: Colors.white
        ),
        errorBuilder: (context,errorMessage){
          return Center(
            child: Text(
              errorMessage,style: TextStyle(color: Colors.white),
            ),
          );
        },
        showControls: true,
        // placeholder: Text(widget.placeHolder!),
        // fullScreenByDefault: true,
        aspectRatio: widget.aspect,
        // autoInitialize: true,
     additionalOptions: (context) {
      return <OptionItem>[
        OptionItem(
          onTap: () => debugPrint('My option works!'),
          iconData: Icons.chat,
          title: 'Subtitle',
        ),
        OptionItem(
          onTap: () =>
              debugPrint('Another option working!'),
          iconData: Icons.chat,
          title: 'Another localized title',
        ),
      ];
    },
        subtitle: Subtitles([
          Subtitle(
            index: 0,
            start: Duration.zero,
            end: const Duration(seconds: 10),
            text: 'Hello from subtitles',
          ),
          Subtitle(
            index: 1,
            start: const Duration(seconds: 10),
            end: const Duration(seconds: 20),
            text: 'Whats up? :)',
          ),
        ]),
        subtitleBuilder: (context, subtitle) => Container(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            subtitle,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        videoPlayerController: widget.videoPlayerController!);
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    chewieController!.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller: chewieController!,
      ),
    );
  }
}
class VideoDisplay extends StatefulWidget {
  final String?  videoUrl;
  const VideoDisplay({Key? key, this.videoUrl}) : super(key: key);

  @override
  _VideoDisplayState createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<VideoDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: VideoPlayer(
        loop: true,
        videoPlayerController: VideoPlayerController.network(widget.videoUrl!),
      ),
    );
  }
}
class LocalVideoDisplay extends StatefulWidget {

  final File? file;
  final String? place_Holder;
  const LocalVideoDisplay({Key? key, this.file, this.place_Holder}) : super(key: key);

  @override
  _LocalVideoDisplayState createState() => _LocalVideoDisplayState();
}

class _LocalVideoDisplayState extends State<LocalVideoDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: VideoPlayer(
        loop: true,
        videoPlayerController: VideoPlayerController.file(widget.file!),
        // aspect: 16/9,
        placeHolder: widget.place_Holder,
      ),
    );
  }

}


