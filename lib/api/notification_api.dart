import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
      ),
    );
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(android: android);

    await _notifications.initialize(settings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });

    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName =
          await FlutterNativeTimezone.getLocalTimezone(); //getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  // static Future showNotification({
  //   int id = 0,
  //   String? title,
  //   String? body,
  //   String? payload,
  // }) async =>
  //     _notifications.show(id, title, body, await _notificationDetails(),
  //         payload: payload);

  // static tz.TZDateTime _scheduleDaily(Time time) {
  //   final now = tz.TZDateTime.now(tz.UTC);
  //   final scheduledDate = tz.TZDateTime(
  //     tz.UTC,
  //     now.year,
  //     now.month,
  //     now.day,
  //     time.hour,
  //     time.minute,
  //     time.second,
  //   );
  //   return scheduledDate.isBefore(now)
  //       ? scheduledDate.add(const Duration(days: 1))
  //       : scheduledDate;
  // }

  // static Future showScheduledNotification({
  //   int id = 1,
  //   String? title,
  //   String? body,
  //   String? payload,
  //   required DateTime scheduledDate,
  // }) async =>
  //     _notifications.zonedSchedule(
  //       id,
  //       title,
  //       body,
  //       // tz.TZDateTime.from(scheduledDate, tz.UTC),
  //       _scheduleDaily(Time(17, 26, 0)),
  //       await _notificationDetails(),
  //       payload: payload,
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       matchDateTimeComponents: DateTimeComponents.time,
  //     );
  //

  static tz.TZDateTime _nextInstanceOfEightAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      8,
      30,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static Future<void> scheduleDailyTenAMNotification() async {
    await _notifications.zonedSchedule(
        0,
        '👀 story 🧠',
        '今日のストーリーをチャチャっと復習しましょう',
        _nextInstanceOfEightAM(),
        await _notificationDetails(),
        payload: 'iteration.shunta',
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }
}
