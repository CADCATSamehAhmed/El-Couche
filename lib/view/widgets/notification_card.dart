import 'package:coach/consts/variable.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String body;
  const NotificationCard({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: font.copyWith(color: theme.primaryColorDark,fontSize: 25),),
          Text(body,style: font.copyWith(color: theme.primaryColorDark,fontSize: 18,)),
        ],
      ),
    );
  }
}
