// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:max_player/services/video_player.dart';
//
// class VideosHome extends StatefulWidget {
//   const VideosHome({Key? key}) : super(key: key);
//
//   @override
//   _VideosHomeState createState() => _VideosHomeState();
// }
//
// class _VideosHomeState extends State<VideosHome> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Icon()
//           ],
//         ),
//       ),
//     );
//   }
//   Widget uploadVideo() {
//     double _width = MediaQuery.of(context).size.width;
//     double _height = MediaQuery.of(context).size.height;
//     return Padding(
//         padding:
//         const EdgeInsets.only(top: 5, right: 8.0, left: 8, bottom: 8),
//         child:
//         videoFile == null
//             ? GestureDetector(
//           onTap: (){
//             setState(() {
//               pickVideo();
//             });
//           },
//           child: Column(
//             children: [
//               Icon(Icons.video_library, size: _width * 0.3),
//             ],
//           ),
//         )
//             :
//         GestureDetector(
//
//           child: VideoPlayer(
//               videoPlayerController:
//               VideoPlayerController.file(videoFile!)
//           ),
//         ));
//
//     //
//   }
// }
