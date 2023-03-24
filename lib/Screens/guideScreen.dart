import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palmer/Screens/HomeScreen.dart';
import 'package:video_player/video_player.dart';

import '../addons/chewie_list_item.dart';
import 'Login&Signup.dart';

class guideScreen extends StatefulWidget {
  const guideScreen({super.key});

  @override
  State<guideScreen> createState() => _guideScreenState();
}

class _guideScreenState extends State<guideScreen> {
  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        color: Colors.white,
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHome()));
        },
        icon: Icon(Icons.arrow_back));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        title: Text('GUIDE'),
        leading: BackArrow,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'HAJJ TAKBEER',
                      style: GoogleFonts.rubikBubbles(
                          color: Colors.teal[500], fontSize: 15),
                    ),
                  ),
                ],
              ),
              Container(
                height: 250,
                child: ChewieListItem(
                  videoPlayerController: VideoPlayerController.asset(
                    'images/hajjtakber.mp4',
                  ),
                  looping: true,
                ),
              ),
              Container(
                height: 250,
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
