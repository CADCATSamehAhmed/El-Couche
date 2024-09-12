import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:dashed_circle/dashed_circle.dart';
import '../../consts/variable.dart';
import 'package:shimmer/shimmer.dart';

Widget myCustomCircularProgress({
  required int value,
  required int goal,
  required ThemeData theme,
  required String title,
  required IconData icon,
}) {
  double progress = value / goal;
  if(progress>1) {progress=1;}
  return Center(
    child: Container(
      width: screenWidth*.6,
      height: screenWidth*.6,
      padding: EdgeInsets.all(screenWidth*.03),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.primaryColor.withOpacity(.2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularPercentIndicator(
            radius: screenWidth*.27,
            lineWidth: 15.0,
            backgroundColor: theme.primaryColor.withOpacity(.3),
            animation: true,
            percent: progress,
            center: DashedCircle(
              color: theme.primaryColor,
              gapSize: 5.0,
              dashes: 20,
              child:Container(
                  width: screenWidth*.4,
                  height: screenWidth*.4,
                  padding: EdgeInsets.all(screenWidth*.04),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        icon,
                        color: theme.primaryColor,
                        size: 30,
                      ),
                      Text(
                        '$value',
                        style: font.copyWith(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColorDark,
                        ),
                      ),
                      Text(
                        title,
                        style: font.copyWith(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  )
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: theme.primaryColor,
          ),
        ],
      ),
    ),
  );
}

class ShimmerCard extends StatelessWidget {
  final double height;
  final double width;
  const ShimmerCard({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child:Container(
        width: width,
        height: height,
        decoration:BoxDecoration(
          color: Colors.white,
          borderRadius:BorderRadius.circular(20)
        ),
      ),
    );
  }
}


