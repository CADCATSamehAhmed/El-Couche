import 'package:flutter/material.dart';
import '../../consts/variable.dart';

Widget usedButton({
  void Function()? onPressed,
  required String text,
  required BuildContext context,
  double paddingSize = 15.0,
  double radius = 25.0,
  double width = 1,
  bool atEnd = false,
  Color textColor = Colors.white,
}) {
  width=(width==1)?screenWidth*.4:width;
  return InkWell(
  onTap: onPressed,
  child: Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: paddingSize,vertical: paddingSize/2),
    decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: Colors.white)],
        gradient: LinearGradient(
            colors: [
              Colors.orange.shade300,
              Colors.orange.shade900,]
        ),
        borderRadius: BorderRadius.circular(radius)
    ),
    child: Row(
      mainAxisAlignment:
      atEnd ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: font.copyWith(
            color: textColor,
            fontSize: 18.0,
          ),
        ),
      ],
    ),
  ),
);
}
Widget customButton({
  void Function()? onPressed,
  required String text,
  required Color color,
  required BuildContext context,
  bool hasIconBefore=false,
  bool hasIconAfter=false,
  IconData? iconBefore,
  IconData? iconAfter,
  double paddingSize = 15.0,
  double radius = 25.0,
  double width = 1,
  Color textColor = Colors.white,
}) {
  width=(width==1)?screenWidth*.42:width;
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: width,
      height: screenHeight*.07,
      padding: EdgeInsets.symmetric(horizontal: paddingSize,vertical: paddingSize/2),
      decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Colors.white)],
          color: color,
          borderRadius: BorderRadius.circular(radius)
      ),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          if(hasIconBefore)Icon(iconBefore,color: textColor,),
          SizedBox(width: screenWidth*.05,),
          Text(
            text,
            style: font.copyWith(
              color: textColor,
              fontSize: 18.0,
            ),
          ),
          SizedBox(width: screenWidth*.05,),
          if(hasIconAfter)Icon(iconAfter,color: textColor,)
        ],
      ),
    ),
  );
}

Widget customBottomSheet({
  required void Function() continueFun,
  required void Function() backFun,
  required BuildContext context,
}) {
  ThemeData theme = Theme.of(context);
  return Container(
    padding: EdgeInsets.symmetric(vertical: screenWidth*.05),
    color: theme.scaffoldBackgroundColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        usedButton(onPressed: backFun, text: "السابق", context: context),
        usedButton(onPressed: continueFun, text: "التالي", context: context),
      ],
    ),
  );
}

