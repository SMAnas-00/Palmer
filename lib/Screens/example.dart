import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notify extends StatelessWidget {
  Future<void> _scheduleNotification() async {
    // Define the notification details.
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('01', 'ALERT',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Schedule the notification.
    await FlutterLocalNotificationsPlugin().zonedSchedule(
        0,
        'Title',
        'Message',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Notification Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Schedule Notification'),
          onPressed: _scheduleNotification,
        ),
      ),
    );
  }
}
