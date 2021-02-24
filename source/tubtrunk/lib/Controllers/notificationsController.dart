import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
import 'dart:io' show Platform;

class NotificationsController {
  FlutterLocalNotificationsPlugin localNotification;
  final BehaviorSubject<ReceivedNotification>
      didReceivedLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();
  var initializationSettings;

  NotificationsController._() {
    init();
  }

  init() async {
    localNotification = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      _requestIOSPermission();
    }
    initializePlatformSpecifics();
  }

  initializePlatformSpecifics() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceivedNotification receivedNotification = ReceivedNotification(
              id: id, title: title, body: body, payload: payload);
          didReceivedLocalNotificationSubject.add(receivedNotification);
        });

    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  }

  _requestIOSPermission() {
    localNotification
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(
          alert: false,
          badge: true,
          sound: true,
        );
  }

  setListenerForLowerVersions(Function onNotificationInLowerVersions) {
    didReceivedLocalNotificationSubject.listen((receivedNotification) {
      onNotificationInLowerVersions(receivedNotification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await localNotification.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  Future showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
      "Timer",
      "Local Notification",
      "Timer done",
      importance: Importance.high,
      priority: Priority.high,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosDetails = new IOSNotificationDetails(threadIdentifier: 'timer_done');
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotification.show(
      0,
      "Time's Up!!!",
      "Your focus period is over, take a rest!",
      generalNotificationDetails,
      payload: 'Test Payload',
    );
  }

  // Future scheduleNotification() async {
  //   tz.initializeTimeZones();
  //   String timeZoneName = 'CST';
  //   tz.setLocalLocation(tz.getLocation(timeZoneName));
  //   var scheduleNotificationDateTime =
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));
  //   var androidDetails = new AndroidNotificationDetails(
  //     "Timer End",
  //     "Local Notification 2",
  //     "Timer done!",
  //     // sound: RawResourceAndroidNotificationSound(''),
  //     importance: Importance.high,
  //     priority: Priority.high,
  //     timeoutAfter: 5000,
  //     styleInformation: DefaultStyleInformation(true, true),
  //   );
  //   var iosDetails = new IOSNotificationDetails(
  //     // sound: '.aiff',
  //     threadIdentifier: 'timer_done',
  //   );
  //   var generalNotificationDetails =
  //       new NotificationDetails(android: androidDetails, iOS: iosDetails);
  //   await localNotification.zonedSchedule(
  //     0,
  //     "Time's Up!!!",
  //     "Your focus period is over, take a rest!",
  //     scheduleNotificationDateTime,
  //     generalNotificationDetails,
  //     payload: 'Payload',
  //   );
  // }

  Future<void> cancelNotification() async {
    await localNotification.cancel(0);
  }

  Future<void> cancelAllNotification() async {
    await localNotification.cancelAll();
  }
}

NotificationsController notificationsController = NotificationsController._();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}
