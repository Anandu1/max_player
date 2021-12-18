import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class LocalVideos extends StatefulWidget {
  final String?  videoUrl;
  const LocalVideos({Key? key, this.videoUrl}) : super(key: key);

  @override
  _LocalVideosState createState() => _LocalVideosState();
}

class _LocalVideosState extends State<LocalVideos> {
  File? videoFile;
  VideoPlayerController? videoPlayerController;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }
  // @override
  // void dispose() {
  //   videoPlayerController!.dispose();
  //   // TODO: implement dispose
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body:
        Column(
          children: [
            // videoFile == null
            //     ?
            GestureDetector(
              onTap: (){
                setState(() {
                  pickVideo();
                });
              },
              child: Column(
                children: [
                  Icon(Icons.video_library, size: MediaQuery.of(context).size.height * 0.3),
                ],
              ),
            )
                // :
            // GestureDetector(
            //   child: VideoPlayer(
            //     videoPlayerController!
            //   ),
            // )
          ],
        )

    );
  }
  pickVideo() async {
    final video =
    await ImagePicker.platform.pickVideo(source: ImageSource.gallery);
    videoFile = File(video!.path);
    videoPlayerController = VideoPlayerController.file(videoFile!)
      ..initialize().then((_) {
        setState(() {
          videoPlayerController!.play();
        });
      });
  }
}