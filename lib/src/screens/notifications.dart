import 'package:flutter/material.dart';
import 'package:m_e/services/notification_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool isMorningReminderEnabled = false;
  bool isEveningReminderEnabled = false;
  TimeOfDay morningTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay eveningTime = const TimeOfDay(hour: 20, minute: 0);

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _scheduleMorningNotification() async {
    if (isMorningReminderEnabled) {
      await NotificationService.scheduleNotification(
        id: 1,
        title: 'M&E',
        body: 'Morning Devotional Reminder',
        time: morningTime,
      );
    } else {
      await NotificationService.showNotification(
        id: 1,
        title: 'M&E',
        body: 'Morning notifications have been turned off.',
      );
    }
  }

  Future<void> _scheduleEveningNotification() async {
    if (isEveningReminderEnabled) {
      await NotificationService.scheduleNotification(
        id: 2,
        title: 'M&E',
        body: 'Evening Devotional Reminder',
        time: eveningTime,
      );
    } else {
      await NotificationService.showNotification(
        id: 2,
        title: 'M&E',
        body: 'Evening notifications have been turned off.',
      );
    }
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isMorningReminderEnabled =
          prefs.getBool('isMorningReminderEnabled') ?? false;
      isEveningReminderEnabled =
          prefs.getBool('isEveningReminderEnabled') ?? false;

      final morningHour = prefs.getInt('morningHour') ?? 8;
      final morningMinute = prefs.getInt('morningMinute') ?? 0;
      morningTime = TimeOfDay(hour: morningHour, minute: morningMinute);

      final eveningHour = prefs.getInt('eveningHour') ?? 20;
      final eveningMinute = prefs.getInt('eveningMinute') ?? 0;
      eveningTime = TimeOfDay(hour: eveningHour, minute: eveningMinute);
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isMorningReminderEnabled', isMorningReminderEnabled);
    await prefs.setBool('isEveningReminderEnabled', isEveningReminderEnabled);

    await prefs.setInt('morningHour', morningTime.hour);
    await prefs.setInt('morningMinute', morningTime.minute);

    await prefs.setInt('eveningHour', eveningTime.hour);
    await prefs.setInt('eveningMinute', eveningTime.minute);
  }

  Future<void> _selectTime(BuildContext context, bool isMorning) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isMorning ? morningTime : eveningTime,
    );
    if (picked != null) {
      setState(() {
        if (isMorning) {
          morningTime = picked;
          _scheduleMorningNotification();
        } else {
          eveningTime = picked;
          _scheduleEveningNotification();
        }
      });
      _saveSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isAm = now.hour < 12;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: isAm
            ? const Color.fromARGB(255, 103, 189, 178)
            : const Color.fromARGB(255, 55, 30, 83),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Morning Reminder',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch(
                  value: isMorningReminderEnabled,
                  onChanged: (value) {
                    setState(() {
                      isMorningReminderEnabled = value;
                    });
                    _saveSettings();
                    _scheduleMorningNotification();
                  },
                ),
                TextButton(
                  onPressed: isMorningReminderEnabled
                      ? () => _selectTime(context, true)
                      : null,
                  child: Text(
                    'Set Time: ${morningTime.format(context)}',
                    style: TextStyle(
                      color:
                          isMorningReminderEnabled ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Evening Reminder',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch(
                  value: isEveningReminderEnabled,
                  onChanged: (value) {
                    setState(() {
                      isEveningReminderEnabled = value;
                    });
                    _saveSettings();
                    _scheduleEveningNotification();
                  },
                ),
                TextButton(
                  onPressed: isEveningReminderEnabled
                      ? () => _selectTime(context, false)
                      : null,
                  child: Text(
                    'Set Time: ${eveningTime.format(context)}',
                    style: TextStyle(
                      color:
                          isEveningReminderEnabled ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
