import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../Controllers/notificationsController.dart';
import './notificationPage.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  void initState() {
    super.initState();
    notificationsController
        .setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationsController.setOnNotificationClick(onNotificationClick);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await notificationsController.showNotification();
            // await notificationsController.scheduleNotification();
          },
          child: Text('Finish!'),
        ),
      ),
    );
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }

  onNotificationClick(String payload) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NotificationPage().Reward_Popup()),
    );
  }
}
