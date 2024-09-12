import 'package:get/get.dart';
import 'package:coach/consts/variable.dart';
import 'package:coach/controller/set_account/set_account_cubit.dart';
import 'package:coach/controller/set_account/set_account_state.dart';
import 'package:coach/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coach/view/widgets/custom_text.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SetYourAccount extends StatelessWidget {
  const SetYourAccount({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetAccountCubit, SetAccountStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SetAccountCubit cubit = SetAccountCubit.get(context);
        return Scaffold(
          appBar:PreferredSize(preferredSize: Size(screenWidth, screenHeight*.05),child: SizedBox(height: screenHeight*.05,)),
          body: accountQuestions[cubit.questionNumber-1],
        );
      }
    );
  }
}

List<Widget> accountQuestions = [
  const ChooseGender(),
  const ChooseAge(),
  const ChooseWeight(),
  const ChooseHeight(),
  const ChooseWorkOutGoal(),
  const ChooseTrainingDays(),
  const CustomisingPlan(),
];

class ChooseGender extends StatelessWidget {
  const ChooseGender({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetAccountCubit, SetAccountStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SetAccountCubit cubit = SetAccountCubit.get(context);
          ThemeData theme = Theme.of(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  customTitleAndSubTitle(
                      title: 'اختار نوعك',
                      subTitle: 'ساعدنا عشان نفهمك بشكل افضل',
                      height: screenHeight*.02),
                  Wrap(
                    spacing: screenWidth*.05,
                    children: List.generate(2, (index) =>
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                cubit.chooseGender(genders[index]);
                              },
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children:[
                                  ClipOval(
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      height: cubit.gender==genders[index]?screenWidth*.15:screenWidth*.12,
                                      width: cubit.gender==genders[index]?screenWidth*.45:screenWidth*.42,
                                      decoration: BoxDecoration(
                                        color: cubit.gender==genders[index]?theme.primaryColor:Colors.grey.shade200,
                                      ),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: cubit.gender==genders[index]?screenHeight*.6:screenHeight*.5,
                                      width: cubit.gender==genders[index]?screenWidth*.44:screenWidth*.34,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/set_account/${images[index]}.png"),
                                          fit: BoxFit.cover
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(genders[index], style: const TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w600),)
                          ],
                        )
                    ),
                  ),
                  SizedBox(height: screenHeight*.02),
                ],
              ),
            ),
            bottomSheet: Container(
              padding: EdgeInsets.symmetric(vertical: screenWidth*.05),
              color: theme.scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  usedButton(onPressed: (){
                    if(cubit.gender!=null){
                      cubit.questionNumberPlusOne();
                    }
                  }, text: "تابع", context: context),
                ],
              ),
            ),
          );
        }
    );
  }
}

class ChooseAge extends StatelessWidget {
  const ChooseAge({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetAccountCubit, SetAccountStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SetAccountCubit cubit = SetAccountCubit.get(context);
          ThemeData theme = Theme.of(context);
          return Scaffold(
            body: Column(
              children: [
                customTitleAndSubTitle(
                    title: 'أدخل عمرك',
                    subTitle: 'عمرك سيساعدنا فى تصميم جدول تدريب مناسب لك',
                    height: screenHeight*.03),
                SizedBox(
                  height: screenHeight*.66,
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    diameterRatio: 1.5,
                    physics: const BouncingScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      cubit.chooseAge(index+15);
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${index + 15}',
                                style: font.copyWith(
                                  fontSize: cubit.age == index+15
                                      ? 30
                                      : 25,
                                  color: cubit.age == index+15
                                      ? theme.primaryColor
                                      : Colors.black,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 12),
                                alignment: Alignment.bottomCenter,
                                child: cubit.age == index+15
                                ?Text(
                                  '    عام',
                                  style: font.copyWith(
                                    fontSize:12,
                                    color:Colors.black,
                                  ),
                                )
                                :Text(
                                  '         ',
                                  style: font.copyWith(
                                    fontSize:12,
                                    color:Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: 40 - 15 + 1,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight*.03),
              ],
            ),
            bottomSheet: customBottomSheet(
                continueFun: (){cubit.questionNumberPlusOne();},
                backFun: (){cubit.questionNumberMinesOne();},
                context: context
            ),
          );
        }
    );
  }
}

class ChooseWeight extends StatelessWidget {
  const ChooseWeight({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetAccountCubit, SetAccountStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SetAccountCubit cubit = SetAccountCubit.get(context);
          ThemeData theme = Theme.of(context);
          return Scaffold(
            body: Column(
              children: [
                customTitleAndSubTitle(
                    title: 'أدخل وزنك',
                    subTitle: 'من فضلك ادخل وزنك بالكيلوجرامات',
                    height: screenHeight*.04
                ),
                SizedBox(height: screenHeight*.04),
                SizedBox(
                  height: screenHeight*.66,
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    diameterRatio: 1.5,
                    physics: const BouncingScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      cubit.chooseWeight(index+30);
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${index + 30}',
                                style: font.copyWith(
                                  fontSize: cubit.weight == index+30
                                      ? 30
                                      : 25,
                                  color: cubit.weight == index+30
                                      ? theme.primaryColor
                                      : Colors.black,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 12),
                                alignment: Alignment.bottomCenter,
                                child: cubit.weight == index+30
                                    ?Text(
                                  '    كجم',
                                  style: font.copyWith(
                                    fontSize:12,
                                    color:Colors.black,
                                  ),
                                )
                                    :Text(
                                  '         ',
                                  style: font.copyWith(
                                    fontSize:12,
                                    color:Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: 200 - 30 + 1,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight*.04),
              ],
            ),
            bottomSheet: customBottomSheet(
                continueFun: (){cubit.questionNumberPlusOne();},
                backFun: (){cubit.questionNumberMinesOne();},
                context: context
            ),
          );
        }
    );
  }
}

class ChooseHeight extends StatelessWidget {
  const ChooseHeight({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetAccountCubit, SetAccountStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SetAccountCubit cubit = SetAccountCubit.get(context);
          ThemeData theme = Theme.of(context);
          return Scaffold(
            body: Column(
              children: [
                customTitleAndSubTitle(
                    title: 'أدخل طولك',
                    subTitle: 'من فضلك ادخل طولك بالسنتيمترات',
                    height: screenHeight*.03
                ),
                SizedBox(
                  height: screenHeight*.66,
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    diameterRatio: 1.5,
                    physics: const BouncingScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      cubit.chooseHeight(index+100);
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${index + 100}',
                                style: font.copyWith(
                                  fontSize: cubit.height == index+100
                                      ? 30
                                      : 25,
                                  color: cubit.height == index+100
                                      ? theme.primaryColor
                                      : Colors.black,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 12),
                                alignment: Alignment.bottomCenter,
                                child: cubit.height == index+100
                                    ?Text(
                                  '    سم',
                                  style: font.copyWith(
                                    fontSize:12,
                                    color:Colors.black,
                                  ),
                                )
                                    :Text(
                                  '         ',
                                  style: font.copyWith(
                                    fontSize:12,
                                    color:Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: 250 - 100 + 1,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight*.03),
              ],
            ),
            bottomSheet: customBottomSheet(
                continueFun: (){cubit.questionNumberPlusOne();},
                backFun: (){cubit.questionNumberMinesOne();},
                context: context
            ),
          );
        }
    );
  }
}

class ChooseWorkOutGoal extends StatelessWidget {
  const ChooseWorkOutGoal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetAccountCubit, SetAccountStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SetAccountCubit cubit = SetAccountCubit.get(context);
          ThemeData theme = Theme.of(context);
          return Scaffold(
            body: Column(
              children: [
                customTitleAndSubTitle(
                  title: 'اختار هدفك من التمرين',
                  subTitle: 'ماهو هدف اللياقة البدنية الأساسي الخاص بك؟ سنقوم بوضع خطة لمساعدتك على تحقيق ذالك.',
                  height: screenHeight*.2
                ),
                Wrap(
                  direction: Axis.vertical,
                  spacing: 11,
                  children: List.generate(workOutGoals.length, (index) =>
                      InkWell(
                        onTap:(){
                          cubit.chooseWorkOutGoal(index);
                        },
                        child:AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: screenHeight*0.1,
                          width: screenWidth*.9,
                          padding: EdgeInsets.symmetric(horizontal:screenWidth*.03,vertical: screenHeight*.01),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: cubit.workOutGoal==index
                                      ?theme.primaryColor
                                      :Colors.grey,
                                  blurRadius: 6,spreadRadius: 0.5
                              ),
                              const BoxShadow(color: Colors.white,blurRadius: 6,spreadRadius: 1),
                            ],
                            color: cubit.workOutGoal==index
                                ?theme.primaryColor
                                :Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(7)),
                          ),
                          child: Center(
                            child: Text(
                              workOutGoals[index],
                              style: font.copyWith(
                                color: cubit.workOutGoal==index
                                    ?Colors.white
                                    :Colors.black,
                                fontSize: cubit.workOutGoal==index
                                    ?22
                                    :18,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ),
                ),
              ],
            ),
            bottomSheet: customBottomSheet(
                continueFun: (){cubit.questionNumberPlusOne();},
                backFun: (){cubit.questionNumberMinesOne();},
                context: context
            ),
          );
        }
    );
  }
}

class ChooseTrainingDays extends StatelessWidget {
  const ChooseTrainingDays({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetAccountCubit, SetAccountStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SetAccountCubit cubit = SetAccountCubit.get(context);
          ThemeData theme = Theme.of(context);
          return Scaffold(
            body: Column(
              children: [
                customTitleAndSubTitle(
                    title: 'حدد خطة التمرين الأسبوعية الخاصة بك',
                    subTitle: 'كم مرة تخطط للتمرين بالأسبوع؟ سنقوم بإنشاء جدول زمني لك',
                    height: screenHeight*.2
                ),
                SizedBox(
                  height: screenHeight*.66,
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    diameterRatio: 1.5,
                    physics: const BouncingScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      cubit.chooseTrainDays(index+1);
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${index + 1}',
                                style: font.copyWith(
                                  fontSize: cubit.trainDays == index+1
                                      ? 30
                                      : 25,
                                  color: cubit.trainDays == index+1
                                      ? theme.primaryColor
                                      : Colors.black,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 12),
                                alignment: Alignment.bottomCenter,
                                child: cubit.trainDays == index+1
                                    ?Text(
                                  '    يوم',
                                  style: font.copyWith(
                                    fontSize:12,
                                    color:Colors.black,
                                  ),
                                )
                                    :Text(
                                  '         ',
                                  style: font.copyWith(
                                    fontSize:12,
                                    color:Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: 7,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight*.03),
              ],
            ),
            bottomSheet: customBottomSheet(
                continueFun: (){
                  cubit.customGenerator(
                      gender: cubit.gender!,
                      height: cubit.height,
                      weight: cubit.weight,
                      age: cubit.age,
                      workOutGoal: cubit.workOutGoal,
                      workoutDays: cubit.trainDays,
                  );
                  cubit.questionNumberPlusOne();
                  },
                backFun: (){cubit.questionNumberMinesOne();},
                context: context
            ),
          );
        }
    );
  }
}

class CustomisingPlan extends StatelessWidget {
  const CustomisingPlan({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocConsumer<SetAccountCubit, SetAccountStates>(
        listener: (context, state) {
          if (state is CustomGeneratorSuccessState) {
             Get.offAllNamed('home');
          }
        },
        builder: (context, state) {
          var cubit = SetAccountCubit.get(context);
          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: Padding(
              padding: EdgeInsets.all(screenWidth * .15),
              child: Column(
                children: [
                  customTitleAndSubTitle(
                      title: 'جاري انشاء خطة تمرين مخصصة لك',
                      subTitle: 'انتظر من فضلك ...',
                      height: 40.0
                  ),
                  CircularPercentIndicator(
                    radius: screenWidth*.25,
                    lineWidth: 11.0,
                    backgroundColor:Colors.grey.withOpacity(.3),
                    animation: true,
                    percent: cubit.makingPlanProcess,
                    center: Text(
                      "${cubit.makingPlanProcess*100}%",
                      style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: theme.primaryColor,
                  ),
                  SizedBox(height: screenWidth * .05,),
                  Text("سيستغرق هذا لحظة واحدة فقط.استعد لتغير رحلة اللياقة الخاصة لك!",
                      style: font.copyWith(
                        fontSize: 14,
                      ),
                  ),
                ]
              ),
            ),
          );
        });
  }
}