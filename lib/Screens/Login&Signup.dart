import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:palmer/AdminControls/AdminDash.dart';
import 'package:palmer/AdminControls/addFlight.dart';
import 'package:palmer/Cart/CartScreen.dart';
import 'package:palmer/Screens/HomeScreen.dart';
import 'package:palmer/Screens/map.dart';
import 'package:palmer/Services/Hotels/Hotels.dart';
import 'package:palmer/Services/Tickets/Flight.dart';
import 'package:palmer/Screens/Signup.dart';
import 'package:palmer/Screens/WelcomeScreen.dart';
import 'package:palmer/Screens/login_Screen.dart';
import 'package:video_player/video_player.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'distanceCAL.dart';
import 'example.dart';
import 'guideScreen.dart';

class ScreenLoginSignup extends StatefulWidget {
  const ScreenLoginSignup({super.key});

  @override
  State<ScreenLoginSignup> createState() => _ScreenLoginSignupState();
}

class _ScreenLoginSignupState extends State<ScreenLoginSignup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                'images/mainicon.png',
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[400],
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.5,
                      MediaQuery.of(context).size.height * 0.08),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('LOGIN'),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[400],
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.5,
                      MediaQuery.of(context).size.height * 0.08),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text('SIGNUP'),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => _scheduleNotification(),
                child: Text('Practice'))
          ],
        ),
      ),
    );
  }
}

Future<void> _scheduleNotification() async {
  // Define the notification details.
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('01', 'ALERT',
          channelDescription: 'you are in BOUNDARY',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false);
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  // Schedule the notification.
  await FlutterLocalNotificationsPlugin().zonedSchedule(
      0,
      'ALERT',
      'YOU ARE IN THE BOUNDARY',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
}
