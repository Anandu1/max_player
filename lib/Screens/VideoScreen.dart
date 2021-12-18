import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:max_player/services/video_player.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  TextEditingController textEditingController= TextEditingController();
  File? videoFile;
  VideoPlayerController? videoPlayerController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Max Player",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            link(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                    return VideoDisplay(videoUrl:
                    textEditingController.text);
                  }));
                },
                child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle
                  ),
                  child: Icon(Icons.ac_unit_outlined,color: Colors.white,),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                 pickVideo();
                },
                child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    shape: BoxShape.circle
                  ),
                  child: Icon(Icons.ac_unit_outlined,color: Colors.white,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget link(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        child: TextField(
          textAlign: TextAlign.center,
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: "Enter Video Link",
            border: OutlineInputBorder(
            )
          ),
        ),
      ),
    );
  }
  pickVideo() async {
    final video =
    await ImagePicker.platform.pickVideo(source: ImageSource.gallery);
   setState(() {
     videoFile = File(video!.path);
   });
    Navigator.push(context,
        MaterialPageRoute(builder: (context){
          return LocalVideoDisplay(file:
          videoFile);
        }));
    // videoPlayerController = VideoPlayerController.file(videoFile!)
    //   ..initialize().then((_) {
    //     setState(() {
    //       videoPlayerController!.play();
    //     });
    //   });
  }
}
