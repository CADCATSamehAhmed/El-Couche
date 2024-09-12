import 'package:coach/model/exercise_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:coach/consts/variable.dart';
import 'package:coach/controller/home/home_cubit.dart';
import 'package:coach/controller/home/home_states.dart';
import 'package:coach/view/widgets/button.dart';
import 'package:coach/view/widgets/my_appbar.dart';

class InsideTrainingScreen extends StatelessWidget {
  final List<ExerciseModel> list;
  const InsideTrainingScreen({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context);
    HomeCubit cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar:trainingAppBar(theme: theme, value: cubit.currentExercise/list.length),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal:screenWidth*.05,vertical: screenHeight*.025),
            child: Column(
              children: [
                //title
                Text(
                  list[cubit.currentExercise].title,
                  style: font.copyWith(
                    color: theme.primaryColorDark,
                    fontSize:23,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight*.015,),
                //image
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image(
                    height: screenHeight*.4,
                    image: NetworkImage(
                      "$serverPath${list[cubit.currentExercise].gifImage}",
                    ),
                  ),
                ),
                SizedBox(height: screenHeight*.015,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'التكرار',
                          style: font.copyWith(
                            color: theme.primaryColorDark.withOpacity(.7),
                            fontSize:20,
                          ),
                        ),
                        Text(
                          '${cubit.planModel.setsNumber} مجموعات',
                          style: font.copyWith(
                            color: theme.primaryColorDark,
                            fontSize:23,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth*.05,height: screenHeight*.1,),
                    Column(
                      children: [
                        Text(
                          'العدات',
                          style: font.copyWith(
                            color: theme.primaryColorDark.withOpacity(.7),
                            fontSize:20,
                          ),
                        ),
                        Text(
                          '${cubit.planModel.repsNumber} عدة',
                          style: font.copyWith(
                            color: theme.primaryColorDark,
                            fontSize:23,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight*.03,),
                customButton(
                  text: 'تم', color: theme.primaryColor, context: context,
                  hasIconAfter: true,
                  iconAfter: CupertinoIcons.check_mark,
                  width: screenWidth*.9,
                  onPressed: (){
                    cubit.increaseTodayExercisesDone(list[cubit.currentExercise]);
                    if(cubit.numberOfExerciseDone==cubit.planModel.exercisesPerDay){
                      Get.off(()=>const WorkoutCompleteScreen());
                    }
                    cubit.startTimer();
                    Get.off(()=> RestScreen(list: list,));
                  }
                ),
              ],
            ),
          ),
          bottomSheet:Padding(
            padding: EdgeInsets.symmetric(horizontal:screenWidth*.05,vertical: screenHeight*.025),
            child: Row(
              children: [
                customButton(
                    text: 'السابق', color: theme.primaryColor.withOpacity(.1), context: context,
                    hasIconBefore: true,
                    iconBefore: CupertinoIcons.forward_end,textColor:theme.primaryColor,
                    onPressed: (){
                      cubit.backToPreviousExercise();
                    }
                ),
                SizedBox(width: screenWidth*.06,),
                customButton(
                    text: 'تخطي', color: theme.primaryColor.withOpacity(.1), context: context,
                    hasIconAfter: true,
                    iconAfter: CupertinoIcons.backward_end,textColor:theme.primaryColor,
                    onPressed: (){
                      cubit.goToNextExercise();
                    }
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}

class RestScreen extends StatelessWidget {
  final List<ExerciseModel> list;
  const RestScreen({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context);
    HomeCubit cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){
          if(cubit.timer==0){
            cubit.goToNextExercise();
            Get.off(()=> InsideTrainingScreen(list: list,));
          }
        },
        builder: (context,state){
          return Scaffold(
            backgroundColor: theme.primaryColor,
            appBar:AppBar(
              toolbarHeight: screenHeight*.1,
              leading: IconButton(onPressed: (){
                Get.back();
              }, icon: const Icon(CupertinoIcons.xmark)),
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal:screenWidth*.05,vertical: screenHeight*.015),
              child: Column(
                children: [
                  Text(
                    '${cubit.currentExercise+2}/${list.length} التالي',
                    style: font.copyWith(
                      color: Colors.white,
                      fontSize:18,
                    ),
                  ),
                  SizedBox(height: screenHeight*.015,),
                  Text(
                    list[cubit.currentExercise+1].title,
                    style: font.copyWith(
                      color: Colors.white,
                      fontSize:20,
                    ),
                  ),
                  SizedBox(height: screenHeight*.03,),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image(
                      height: screenHeight*.4,
                      image: NetworkImage(
                          "$serverPath${list[cubit.currentExercise+1].gifImage}"
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight*.03,),
                  Text(
                    'استراجة',
                    style: font.copyWith(
                      color: Colors.white,
                      fontSize:18,
                    ),
                  ),
                  SizedBox(height: screenHeight*.015,),
                  Text(
                    formatSecondsToTime(cubit.timer),
                    style: font.copyWith(
                      color: Colors.white,
                      fontSize:30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: screenHeight*.03,),
                  Row(
                    children: [
                      customButton(
                          text: '+ 10s',
                          color: Colors.white,
                          textColor:theme.primaryColor,
                          context: context,
                          onPressed: (){
                            cubit.restTimerPlus10();
                          }
                      ),
                      SizedBox(width: screenWidth*.05,),
                      customButton(
                          text: 'تخطي',
                          color: Colors.white,
                          context: context,
                          hasIconAfter: true,
                          iconAfter: CupertinoIcons.backward_end,
                          textColor:theme.primaryColor,
                          onPressed: (){
                            cubit.stopTimer();
                            cubit.goToNextExercise();
                            Get.off(()=> InsideTrainingScreen(list: list,));
                          }
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}

class WorkoutCompleteScreen extends StatelessWidget {
  const WorkoutCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:screenWidth*.05,vertical: screenHeight*.015),
        child: Column(
          children: [
            Image.asset('assets/winner.png',fit: BoxFit.cover,height: screenHeight*.45),
            Text('Congratulations!',style: font.copyWith(fontSize: 22,color:theme.primaryColorDark),),
            Text('you have completed the workout!',style: font.copyWith(fontSize: 16,color:theme.primaryColorDark.withOpacity(.5)),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Icon(Icons.run_circle_outlined,color: theme.primaryColorDark,),
                    Text('7',style: font.copyWith(fontSize: 18,color:theme.primaryColorDark),),
                    Text('workouts',style: font.copyWith(fontSize: 16,color:theme.primaryColorDark.withOpacity(.5)),),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.access_time,color: theme.primaryColorDark,),
                    Text('20',style: font.copyWith(fontSize: 18,color:theme.primaryColorDark),),
                    Text('minutes',style: font.copyWith(fontSize: 16,color:theme.primaryColorDark.withOpacity(.5)),),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.local_fire_department_outlined,color: theme.primaryColorDark,),
                    Text('250',style: font.copyWith(fontSize: 18,color:theme.primaryColorDark),),
                    Text('kcal',style: font.copyWith(fontSize: 16,color:theme.primaryColorDark.withOpacity(.5)),),
                  ],
                ),
              ],
            ),
            usedButton(
              onPressed: (){Get.back();},
              text: "Go to HomePage",
              context: context
            )
          ],
        ),
      ),
    );
  }
}

String formatSecondsToTime(int totalSeconds) {
  int minutes = totalSeconds ~/ 60;  // Calculate minutes
  int seconds = totalSeconds % 60;   // Calculate remaining seconds
  // Format the minutes and seconds to always show two digits
  String formattedMinutes = minutes.toString().padLeft(2, '0');
  String formattedSeconds = seconds.toString().padLeft(2, '0');
  return "$formattedMinutes:$formattedSeconds";
}