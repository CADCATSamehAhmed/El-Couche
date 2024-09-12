import 'package:flutter/material.dart';
import '../../consts/variable.dart';

Widget customTitleAndSubTitle({
  required String title,
  required String subTitle,
  bool hasWidth = false,
  double customWidth = 1,
  required double height,
}) {
  customWidth=hasWidth?customWidth:screenWidth;
  return Column(
      children: [
        Text(title,
          style: font.copyWith(
            fontSize: 24,
          ),
        ),
        SizedBox(height: screenHeight*.02,width: customWidth,),
        Text(subTitle,
          style: font.copyWith(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: height),
      ],
    );
}

