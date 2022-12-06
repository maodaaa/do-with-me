import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';

int createUniqueId(String dateTime) {
  return DateFormat('dd MMMM yyyy HH:mm').parse(dateTime).toLocal().millisecondsSinceEpoch.remainder(100000);
}

Future<void> createReminderNotification(String task, String date, String time, String reminder) async {
  String dateTime = '$date $time';
  DateTime dateFormatted = DateFormat('dd MMMM yyyy').parse(date).toLocal();
  int hour = DateFormat('HH:mm').parse(time).toLocal().hour;
  int minute = DateFormat('HH:mm').parse(time).toLocal().minute;
  int idx = reminder.indexOf(" ");
  List parts = [reminder.substring(0,idx).trim(), reminder.substring(idx+1).trim()];
  if(parts[0] == '1') {
    hour -= int.parse(parts[0]);
  } else {
    minute -= int.parse(parts[0]);
  }
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(dateTime), 
      channelKey: 'basic_channel',
      title: task,
      body: 'You have $reminder task starts',
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Mark Done',
      ),
    ],
    schedule: NotificationCalendar(
      day: dateFormatted.day,
      month: dateFormatted.month,
      year: dateFormatted.year,
      hour: hour,
      minute: minute,
      second: 0,
      millisecond: 0,
    )
  );
}

Future<void> updateReminderNotification(
  String date, String time, String taskNew, String dateNew, String timeNew, String reminder
) async {
  String dateTime = '$date $time';
  DateTime dateFormattedNew = DateFormat('dd MMMM yyyy').parse(dateNew).toLocal();
  int hourNew = DateFormat('HH:mm').parse(timeNew).toLocal().hour;
  int minuteNew = DateFormat('HH:mm').parse(timeNew).toLocal().minute;
  await AwesomeNotifications().cancel(createUniqueId(dateTime));
  String dateTimeNew = '$dateNew $timeNew';
  int idx = reminder.indexOf(" ");
  List parts = [reminder.substring(0,idx).trim(), reminder.substring(idx+1).trim()];
  if(parts[0] == '1') {
    hourNew -= int.parse(parts[0]);
  } else {
    minuteNew -= int.parse(parts[0]);
  }
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(dateTimeNew), 
      channelKey: 'basic_channel',
      title: taskNew,
      body: 'You have $reminder task starts',
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Mark Done'
      ),
    ],
    schedule: NotificationCalendar(
      day: dateFormattedNew.day,
      month: dateFormattedNew.month,
      year: dateFormattedNew.year,
      hour: hourNew,
      minute: minuteNew,
      second: 0,
      millisecond: 0,
    )
  );
}