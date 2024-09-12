import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../consts/cache_helper.dart';
import '../../model/plan_model.dart';
import '../../model/user_model.dart';
import '../functions/make_custom_gym_plan.dart';
import 'set_account_state.dart';

class SetAccountCubit extends Cubit<SetAccountStates> {
  SetAccountCubit() : super(InitialState());

  static SetAccountCubit get(context) => BlocProvider.of(context);

  int questionNumber = 1;
  String? gender;
  int age = 25;
  int height = 170;
  int weight = 50;
  int fitnessLevel = -1;
  int exerciseHours = 1;
  int workOutGoal = -1;
  int pushUpLevel = -1;
  int trainDays = 4;
  double makingPlanProcess = 0;

  void questionNumberPlusOne() {
    questionNumber++;
    emit(PlusState());
  }

  void questionNumberMinesOne() {
    questionNumber--;
    emit(MinesState());
  }

  void chooseGender(String g) {
    gender = g;
    emit(ChooseItemState());
  }

  void chooseAge(int a) {
    age = a;
    emit(ChooseItemState());
  }

  void chooseHeight(int h) {
    height = h;
    emit(ChooseItemState());
  }

  void chooseWeight(int w) {
    weight = w;
    emit(ChooseItemState());
  }

  void chooseFitnessLevel(int a) {
    fitnessLevel = a;
    emit(ChooseItemState());
  }

  void chooseExerciseHours(int e) {
    exerciseHours = e;
    emit(ChooseItemState());
  }

  void chooseWorkOutGoal(int wg) {
    workOutGoal = wg;
    emit(ChooseItemState());
  }

  void choosePushUpLevel(int pl) {
    pushUpLevel = pl;
    emit(ChooseItemState());
  }

  void chooseTrainDays(int td) {
    trainDays = td;
    emit(ChooseItemState());
  }

  Future<void> customGenerator({
    required String gender,
    required int height,
    required int weight,
    required int age,
    required int workOutGoal, //0=lose Weight,1=build muscle,2=stay fit
    required int workoutDays,
  }) async {
    emit(CustomGeneratorLoadingState());
    try {
      PlanModel customPlan = await makeCustomGymPlan(workOutGoal: workOutGoal, workoutDays: workoutDays);
      makingPlanProcess = 0.25;
      emit(ProcessingState());
      await Future.delayed(const Duration(milliseconds: 250));
      makingPlanProcess = 0.5;
      emit(ProcessingState());
      await addWorkOutPreference(
        workOutPreference: WorkOutPreference(
        gender: gender,
        startDay: DateTime.daysPerWeek,
        age: age,
        height: height,
        weight: weight,
        workOutDays: workoutDays,
        trainingRest: 10,
      ));
      await Future.delayed(const Duration(milliseconds: 250));
      makingPlanProcess = 0.75;
      emit(ProcessingState());
      await addCustomData(customPlan: customPlan);
      await Future.delayed(const Duration(milliseconds: 250));
      makingPlanProcess = 1;
      emit(ProcessingState());
      emit(CustomGeneratorSuccessState());
    } catch (error) {
      emit(CustomGeneratorErrorState());
    }
  }

  Future<void> addWorkOutPreference({
    required WorkOutPreference workOutPreference,
  }) async {
    String uid = CacheHelper.getData(key: 'uid');
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'workOutPreference': workOutPreference.toMap(),
    }, SetOptions(merge: true)).then((value) {
      if (kDebugMode) {
        print("add workOut preference success");
      }
    }).catchError((error) {
      if (kDebugMode) {
        print("add workOut preference error:${error.toString()}");
      }
    });
  }

  Future<void> addCustomData({
    required PlanModel customPlan,
  }) async {
    String uid = CacheHelper.getData(key: 'uid');
    FirebaseFirestore.instance.collection('users_custom').doc(uid).set(
      customPlan.toMap(), SetOptions(merge: true)).then((value) {
      if (kDebugMode) {
        print("add custom data success");
      }
    }).catchError((error) {
      if (kDebugMode) {
        print("add custom data error:${error.toString()}");
      }
    });
  }
}
