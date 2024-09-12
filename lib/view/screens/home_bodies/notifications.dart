import 'package:coach/view/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import '../../widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(title: 'الاشعارات', theme: Theme.of(context)),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index)=>
          const NotificationCard(title: '', body: '')
      ),
    );
  }
}
