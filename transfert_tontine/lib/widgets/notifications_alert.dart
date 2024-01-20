import 'package:flutter/material.dart';

class NotificationAlert extends StatefulWidget {
  const NotificationAlert({super.key});

  @override
  State<NotificationAlert> createState() => _NotificationAlertState();
}

class _NotificationAlertState extends State<NotificationAlert> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 40.0,
      icon: const Icon(
        Icons.notifications,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
