// import 'package:better_player/better_player.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class LightVideoPlayer extends StatefulWidget {
//   final String? url;
//   const LightVideoPlayer({Key? key, this.url}) : super(key: key);
//
//   @override
//   _LightVideoPlayerState createState() => _LightVideoPlayerState();
// }
//
// class _LightVideoPlayerState extends State<LightVideoPlayer> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: BetterPlayer.network(widget.url!,
//         betterPlayerConfiguration: BetterPlayerConfiguration(
//           aspectRatio: 1,
//           looping: true,
//           autoPlay: true,
//           fit: BoxFit.contain
//         ),
//         ),
//       ),
//     );
//   }
// }
