import 'package:flutter/material.dart';
import '../../consts/variable.dart';

Widget customMainSettingItem({
  void Function()? onPressed,
  required IconData icon,
  required String title,
  bool hasArrowIcon = true,
  required Color thisColor,
}) {
  return InkWell(
    onTap: onPressed,
    child: Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenWidth * .04,
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * .05,
            ),
            child: Icon(
              icon,
              color: thisColor,
            ),
          ),
          Text(
            title,
            style: font.copyWith(color: thisColor, fontSize: 20, height: 1),
          ),
          const Spacer(),
          if (hasArrowIcon)Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * .05,
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                color: thisColor,
              ),
            )
        ],
      ),
    ),
  );
}

Widget customInsideSettingItem({
  void Function()? onPressed,
  IconData? icon,
  required String title,
  required String data,
  required Color thisColor,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: screenWidth * .04,
    ),
    child: InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          if(icon!=null)Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * .05,
            ),
            child: Icon(
              icon,
              color: thisColor,
            ),
          ),
          Text(
            title,
            style: font.copyWith(color: thisColor, fontSize: 22),
          ),
          const Spacer(),
          Text(
            data,
            style: font.copyWith(color: thisColor, fontSize: 18),
          ),
          SizedBox(width: screenWidth * .05,),
          Icon(
            Icons.arrow_forward_ios,
            color: thisColor,
          ),
          SizedBox(width: screenWidth * .05,),
        ],
      ),
    ),
  );
}

Widget customSettingToggleItem({
  void Function(bool)? onPressed,
  required String title,
  required bool on,
  required ThemeData theme,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: screenWidth * .04,
    ),
    child: Row(
      children: [
        Text(
          title,
          style: font.copyWith(color: theme.primaryColorDark, fontSize: 22),
        ),
        const Spacer(),
        Switch(
          value: on,
          onChanged: onPressed,
          activeColor: theme.primaryColor,
          activeTrackColor: Colors.white,
          inactiveTrackColor: Colors.grey,
        )
      ],
    ),
  );
}