import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coach/consts/variable.dart';
import 'package:coach/controller/home/home_cubit.dart';
import 'package:coach/controller/home/home_states.dart';
import 'package:coach/view/widgets/button.dart';
import 'package:coach/view/widgets/exercise_card.dart';
import 'package:coach/view/widgets/my_appbar.dart';
import 'package:coach/view/widgets/my_card.dart';
import 'package:get/get.dart';
import 'inside_training.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    HomeCubit cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: !cubit.loading,
            builder: (context) => Scaffold(
                appBar: homeAppBar(
                    theme: theme,
                    user: cubit.user,
                    profileOnTap: () {
                      cubit.changeBottomNavBarIndex(3);
                    }),
                body: ListView(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
                  children: [
                    Text(
                      'التمارين المخصصة لك',
                      textAlign: TextAlign.start,
                      style: font.copyWith(
                          color: theme.primaryColorDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),

                    Row(
                      children: [
                        Image.asset(
                          'assets/gym.png',
                          width: screenWidth * .2,
                        ),
                        Container(
                          width: screenWidth * .7,
                          padding: EdgeInsets.all(screenWidth * .03),
                          decoration: BoxDecoration(
                              color: theme.primaryColor.withOpacity(.1),
                              borderRadius: BorderRadius.circular(25)),
                          child: Text(
                            cubit.todayWorkOutName,
                            textAlign: TextAlign.center,
                            style: font.copyWith(
                                color: theme.primaryColorDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                    if (!cubit.todayIsRest)
                      myCustomCircularProgress(
                          value: cubit.numberOfExerciseDone,
                          goal: cubit.planModel.exercisesPerDay,
                          theme: theme,
                          title: "تمرين",
                          icon: Icons.fitness_center),
                    if (!cubit.todayIsRest)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical:screenWidth * .05),
                        child: usedButton(
                            text: "ابدأ التمرين",
                            context: context,
                            width: screenWidth * .9,
                            onPressed: () {
                              Get.to(InsideTrainingScreen(
                                  list: cubit.todoExercises));
                            }),
                      ),
                    if (!cubit.todayIsRest)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => ExerciseCard(
                          exercise: cubit.todoExercises[index],
                          index: index,
                        ),
                        itemCount: cubit.todoExercises.length,
                      ),
                  ],
                )),
            fallback: (context) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenWidth * .03),
                    child: Row(children: [
                      ShimmerCard(
                        height: screenWidth * .3,
                        width: screenWidth * .3,
                      ),
                      SizedBox(
                        width: screenWidth * .03,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerCard(
                              height: 20,
                              width: screenWidth * .48,
                            ),
                            SizedBox(
                              height: screenWidth * .01,
                            ),
                            ShimmerCard(
                              height: 15,
                              width: screenWidth * .3,
                            ),
                          ]),
                    ]),
                  );
                },
                itemCount: 5,
              );
            });
      }
    );
  }
}
