import 'dart:async';

import 'package:coach/consts/cache_helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService{
  //variables initialize
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin= FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController= StreamController();
  static onTap (NotificationResponse notificationResponse){
    streamController.add(notificationResponse);
  }

  //initialise
  static Future init()async{
    InitializationSettings settings=const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/launcher_icon"),
      iOS: DarwinInitializationSettings()
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse:onTap,
      onDidReceiveBackgroundNotificationResponse:onTap,
    );
  }

  //basic notification
  static void showBasicNotification({
    required int id, required String title, required String body, required String payload
  }) async {
    NotificationDetails details =const NotificationDetails(
        android: AndroidNotificationDetails(
          'id 0',
          'basic notification',
          importance: Importance.max,
          priority: Priority.high,
      )
    );
    await flutterLocalNotificationsPlugin.show(id, title,body,details,payload: payload);
  }
  //repeated notification
  static void showRepeatedNotification({
    required int id, required String title, required String body, required RepeatInterval repeatInterval, required String payload
  }) async {
    NotificationDetails details =const NotificationDetails(
        android: AndroidNotificationDetails(
            'id 1',
            'repeated notification',
            importance: Importance.max,
            priority: Priority.high
        )
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
        id,
        title,
        body,
        repeatInterval,
        details,
        payload: payload
    );
  }
  //daily repeated notification
  static void showDailyRepeatedNotification({
    required int id, required String title, required String body, required String payload
  }) async {
    NotificationDetails details =const NotificationDetails(
        android: AndroidNotificationDetails(
            'id 4',
            'daily repeated notification',
            importance: Importance.max,
            priority: Priority.high
        )
    );
    await flutterLocalNotificationsPlugin.periodicallyShowWithDuration(
        id,
        title,
        body,
        const Duration(days: 1),
        details,
        payload: payload
    );
    CacheHelper.putBoolean(key: 'DailyRepeated', value: true);
  }
  //schedule notification
  static void showScheduleNotification(int id, String title, String body, String payload,{
    required int year, required int month, required int day, required int hour, required int minute
  }) async {
    NotificationDetails details =const NotificationDetails(
        android: AndroidNotificationDetails(
            'id 2',
            'schedule notification',
            importance: Importance.max,
            priority: Priority.high
        )
    );
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        payload: payload,
        tz.TZDateTime(
          tz.local,
          year,
          month,
          day,
          hour,
          minute
        ),
        details,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
    );
  }
  //cancel notification
  static void cancelNotification(int id)async{
    await flutterLocalNotificationsPlugin.cancel(id);
  }
  //cancel all notifications
  static void cancelAllNotification()async{
    await flutterLocalNotificationsPlugin.cancelAll();
  }

}