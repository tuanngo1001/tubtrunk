import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'dart:io' show Platform;

class NotificationsController {
  FlutterLocalNotificationsPlugin localNotification;
  NotificationDetails generalNotificationDetails;
  final BehaviorSubject<ReceivedNotification> didReceivedLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();
  var initializationSettings;
  var notifTitle = "";
  var notifMessage = "";

  NotificationsController._() {
    init();
  }

  void init() async {
    localNotification = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      _requestIOSPermission();
    }

    _initializePlatformSpecifics();
    _initNotificationDetails();
  }

  void setNotification(String title, String message) {
    notifTitle = title;
    notifMessage = message;
  }

  void _requestIOSPermission() {
    localNotification.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>().requestPermissions(
      alert: false,
      badge: true,
      sound: true,
    );
  }

  void _initializePlatformSpecifics() {
    var initializationSettingsAndroid = new AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        ReceivedNotification receivedNotification = ReceivedNotification(
            id: id, title: title, body: body, payload: payload);
        didReceivedLocalNotificationSubject.add(receivedNotification);
      },
    );

    initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  }

  void _initNotificationDetails() {
    final Int64List vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    var androidDetails = new AndroidNotificationDetails(
      "Tubtrunk notification",
      "Local Notification",
      "Push Notification",
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: DefaultStyleInformation(true, true),
      vibrationPattern: vibrationPattern,
      enableLights: true,
      ledColor: const Color.fromARGB(255, 0, 0, 255),
      ledOnMs: 1000,
      ledOffMs: 500,
    );
    var iosDetails =
    new IOSNotificationDetails(threadIdentifier: 'tubtrunk_notification');
    generalNotificationDetails = new NotificationDetails(android: androidDetails, iOS: iosDetails);
  }

  void setListenerForLowerVersions(Function onNotificationInLowerVersions) {
    didReceivedLocalNotificationSubject.listen((receivedNotification) {
      onNotificationInLowerVersions(receivedNotification);
    });
  }

  void setOnNotificationClick(Function onNotificationClick) async {
    await localNotification.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  Future showNotification() async {
    await localNotification.show(
      0,
      notifTitle,
      notifMessage,
      generalNotificationDetails,
      payload: '',
    );
  }

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
