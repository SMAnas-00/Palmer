import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../addons/chewie_list_item.dart';

class guideScreen extends StatefulWidget {
  const guideScreen({super.key});

  @override
  State<guideScreen> createState() => _guideScreenState();
}

class _guideScreenState extends State<guideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUIDE'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                // padding: EdgeInsets.fromLTRB(50, 5, 10, 5),
                color: Colors.teal,
                child: ChewieListItem(
                  videoPlayerController: VideoPlayerController.asset(
                    'images/hajjvideo.mp4',
                  ),
                  looping: true,
                ),
              ),
              Container(
                child: ChewieListItem(
                  videoPlayerController: VideoPlayerController.asset(
                    'images/hajjvideo.mp4',
                  ),
                  looping: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
