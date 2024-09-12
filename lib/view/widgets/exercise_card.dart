import 'package:flutter/material.dart';
import 'package:coach/model/exercise_model.dart';
import 'package:get/get.dart';
import '../../consts/variable.dart';
import '../screens/home_bodies/discovery/inside_workout_list.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ExerciseCard extends StatelessWidget {
  final ExerciseModel exercise;
  final int index;
  const ExerciseCard({super.key, required this.exercise, required this.index});

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth*.02),
      child: Row(
        children:[
          Icon(Icons.scatter_plot,size: screenWidth*.06,color: theme.primaryColorDark,),
          SizedBox(width: screenWidth*.03,),
          Image(
            height: screenWidth*.3,
            width: screenWidth*.3,
            image:CachedNetworkImageProvider("$serverPath${exercise.gifImage}"),
            fit: BoxFit.cover
          ),
          SizedBox(width: screenWidth*.03,),
          SizedBox(
            width: screenWidth*.48,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(
                 exercise.title,
                  style:font.copyWith(
                    color:theme.primaryColorDark,
                    fontSize: 20,
                  )
                ),
                Text(
                    exercise.exerciseRep.toString(),
                    style:font.copyWith(
                      color:theme.primaryColorDark,
                      fontSize: 14,
                    )
                ),
              ]
            ),
          ),
        ]
      ),
    );
  }
}

class CollectionExerciseCard extends StatelessWidget {
  final WorkOutListModel workout;
  const CollectionExerciseCard({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth*.02),
      child: InkWell(
        onTap: (){
          Get.to( InsideWorkOutScreen(model: workout, list: workout.list,));
        },
        child: Row(
            children:[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                Image(
                  height: screenWidth*.25,
                  width: screenWidth*.25,
                  image:CachedNetworkImageProvider(workout.image),
                  fit: BoxFit.cover
                ),
              ),
              SizedBox(width: screenWidth*.03,),
              SizedBox(
                width: screenWidth*.53,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(
                          workout.title,
                          style:font.copyWith(
                            color:theme.primaryColorDark,
                            fontSize: 20,
                          )
                      ),
                      Text(
                          workout.level,
                          style:font.copyWith(
                            color:theme.primaryColorDark.withOpacity(.7),
                            fontSize: 14,
                          )
                      ),
                    ]
                ),
              ),
              const Spacer(),
              Icon(Icons.arrow_forward_ios,size: screenWidth*.06,color: theme.primaryColorDark,),
            ]
        ),
      ),
    );
  }
}

class WorkOutCard extends StatelessWidget {
  final WorkOutListModel workout;
  const WorkOutCard({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth*.02),
      child: InkWell(
        onTap: (){
          Get.to(InsideWorkOutScreen(model: workout, list: workout.list,));
        },
        child: Container(
          height:  screenHeight*.2,
          width: screenWidth*.9,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(workout.image)
            ),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(
                  workout.title,
                  style:font.copyWith(
                    color:theme.primaryColorLight,
                    fontSize: 23,
                    fontWeight: FontWeight.bold
                  )
                ),
              ]
          ),
        ),
      ),
    );
  }
}

class BodyCard extends StatelessWidget {
  final String image;
  final String title;
  final List list;
  const BodyCard({super.key, required this.image, required this.title, required this.list,});

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth*.02),
      child: InkWell(
        onTap: (){
          // Get.to(InsideWorkOutScreen(model: workout, list: workout.list,));
        },
        child: Container(
          height: screenWidth*.4,
          width: screenWidth*.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(image)
            ),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
              mainAxisAlignment:MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(
                  title,
                  style:font.copyWith(
                    color:theme.primaryColorLight,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  )
                ),
              ]
          ),
        ),
      ),
    );
  }
}