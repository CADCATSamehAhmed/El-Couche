import 'package:coach/controller/functions/get_today_exercise.dart';
import 'package:coach/controller/local_notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:coach/consts/cache_helper.dart';
import 'package:coach/model/exercise_model.dart';
import 'package:coach/model/plan_model.dart';
import 'package:coach/model/user_model.dart';
import 'package:coach/view/screens/home_bodies/training/training.dart';
import 'package:coach/view/screens/home_bodies/discovery/discovery.dart';
import 'package:coach/view/screens/home_bodies/settings/settings.dart';
import '../../consts/variable.dart';
import '../../view/screens/home_bodies/training/inside_training.dart';
import '../functions/string_functions.dart';
import 'home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'dart:io';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  late bool loading;
  late UserModel user;
  String? profileName;
  String? profilePhone;
  late PlanModel planModel;
  List<ExerciseModel> todoExercises = [];
  int currentExercise = CacheHelper.getData(key: 'currentExercise')??0;
  String todayWorkOutName = "rest";
  bool todayIsRest = false;
  int numberOfExerciseDone = CacheHelper.getData(key: 'numberOfExerciseDone')??0;
  File? profileImage;
  PlatformFile? file;
  int mode = 0;
  bool isArabic = CacheHelper.getData(key: 'language')??true;
  String language = CacheHelper.getData(key: 'language')??'ar';
  ThemeMode appMode = ThemeMode.system;
  bool notificationOn = CacheHelper.getData(key:'notifications')??true;
  List<String> doneExercisesIds=CacheHelper.getData(key: 'doneExercisesIds')??[];
  late int timer;
  Timer? _internalTimer;
  List<Widget> bodyScreens = [
    const TrainingScreen(),
    const DiscoveryScreen(),
    const SettingsScreen(),
  ];

  void changeBottomNavBarIndex(int index) {
    currentIndex = index;
    HapticFeedback.lightImpact();
    emit(HomeChangeNavBarIndexState());
  }

  Future<void> getUser() async {
    emit(GetUserLoadingState());
    String uid = await CacheHelper.getData(key:'uid');
    try {
      DocumentSnapshot<Map<String, dynamic>> model = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      user = UserModel.fromJson(model.data());
      emit(GetUserSuccessState());
    } catch (e) {
      emit(GetUserErrorState(e.toString()));
    }
  }

  Future<int> getDay() async{
    int startDay = user.workOutPreference.startDay;
    int today = DateTime.now().weekday;
    int currentDay;
    if(today>=startDay){
      currentDay = today-startDay;
    }else{
      today=today+7;
      currentDay = today-startDay;
    }
    int d = await CacheHelper.getData(key: 'currentDay')??startDay;
    if( d != currentDay){
      await CacheHelper.removeData(key: 'numberOfExerciseDone');
      await CacheHelper.removeData(key: 'doneExercisesIds');
      await CacheHelper.removeData(key: 'currentExercise');
    }
    await CacheHelper.saveData(key: 'currentDay', value: currentDay);
    return currentDay;
  }

  Future<void> setup()async{
    loading=true;
    await getUser();
    await getTodayExercises(uid!);
  }

  Future<void> getTodayExercises(String uid) async{
    emit(GetTodayExercisesLoadingState());
    try{
      int d = await getDay();
      DocumentSnapshot<Map<String, dynamic>> model = await FirebaseFirestore.instance.collection('users_custom').doc(uid).get();
      planModel = PlanModel.fromJson(model.data());
      todayWorkOutName = getTodayExerciseName(planModel.workoutDays[d]);
      if(planModel.workoutDays[d]!='rest'){
        todoExercises=getExerciseName(planModel.workoutDays[d]);
        timer = planModel.restTimeBetweenSets;
      }
      else{
        todayIsRest =true;
      }
      loading=false;
      emit(GetTodayExercisesSuccessState());
    } catch (e) {
      if (kDebugMode) {
        print("Error from getTodayExercises$e");
      }
      emit(GetTodayExercisesErrorState(e.toString()));
    }
  }

  void goToNextExercise() {
    if(numberOfExerciseDone==planModel.exercisesPerDay){
      Get.off(()=>const WorkoutCompleteScreen());
    }
    else{
      currentExercise++;
      CacheHelper.saveData(key: 'currentExercise', value: currentExercise);
    }
    emit(GoToNextExerciseState());
  }

  void backToPreviousExercise() {
    currentExercise--;
    CacheHelper.saveData(key: 'currentExercise', value: currentExercise);
    emit(BackToPreviousExerciseState());
  }

  Future<void> increaseTodayExercisesDone(ExerciseModel exercise) async {
    numberOfExerciseDone ++;
    todoExercises.remove(exercise);
    doneExercisesIds.add(exercise.id.toString());
    await CacheHelper.saveList(key: 'doneExercisesIds', value: doneExercisesIds);
    await CacheHelper.saveData(key: 'numberOfExerciseDone', value: numberOfExerciseDone);
    emit(IncreaseTodayExercisesDoneState());
  }

  void startTimer() {
    // Cancel any existing timer
    _internalTimer?.cancel();
    _internalTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (this.timer > 0) {
        this.timer--;
        emit(TimerState(remainingTime: this.timer)); // Emit the current timer state
      } else {
        stopTimer();
        // Emit 0 when the timer stops
      }
    });
  }

  void stopTimer() {
    _internalTimer?.cancel();
    emit(TimerState(remainingTime: 0)); // Reset timer state to 0
  }

  void restTimerPlus10() {
    timer = timer+10;
    startTimer();
  }

  Future<void> pickImage() async {
    profileImage = null;
    file = null;
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg',]
    );
    file = result?.files.first;
    if (result != null) {
      profileImage = File(result.files.single.path!);
      emit(PickImageSuccessState());
    } else {
      emit(PickImageErrorState());
    }
  }

  Future updateImage(PlatformFile image) async {
    try{
      loading=true;
      emit(UpdateImageLoadingState());
      String uid = CacheHelper.getData(key: 'uid');
      // Delete the file
      final desertRef = FirebaseStorage.instance.ref().child("profileImages/($uid)");
      try{
        await desertRef.delete();
        // Delete complete
      }catch(e){
        if (kDebugMode) {
          print('noImage');
        }
      }
      UploadTask? uploadTask;
      final file = File(image.path!);
      final ref = FirebaseStorage.instance.ref().child('profileImages/($uid)/${image.name}');
      uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      FirebaseFirestore.instance.collection('users').doc(uid).set({
        'image': urlDownload,
      }, SetOptions(merge: true));
      CacheHelper.saveData(key: 'uid', value: uid);
      emit(UpdateImageSuccessState());
    }catch (e){
      emit(UpdateImageErrorState(e.toString()));
    }
    loading=false;
  }

  Future<void> changeUserData(bool isName,dynamic data) async{
    if(isName){
      profileName = data;
    }
    else {
      profilePhone = data;
    }
    emit(ChangeUserDataLoadingState());
  }

  Future<void> updateUserData(String key,dynamic data) async{
    loading=true;
    emit(UpdateUserDataLoadingState());
    if(key == 'fullName'){
      user.fullName = data;
    }
    else{
      user.phone = data;
    }
    try{
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        key:data
      }, SetOptions(merge: true));
      profileName=null;
      profilePhone=null;
      emit(UpdateUserDataSuccessState());
    }on FirebaseException catch (e){
      emit(UpdateUserDataErrorState(e.toString()));
    }
    loading=false;
  }

  Future<void> logOut() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    CacheHelper.removeData(key: 'uid');
    uid = null;
    currentIndex=0;
    LocalNotificationService.cancelAllNotification();
    Get.offAllNamed('login');
  }

  // Settings (Theme and language)
  // Change language by default arabic
  void changeAppLanguage(String lang) {
    language = lang;
    switch(lang){
      case 'ar':
        isArabic =true;
      case 'en':
        isArabic =false;
    }
    Get.updateLocale(Locale(lang));
    CacheHelper.saveData(key: 'language', value: lang);
    emit(AppChangeLanguageState());
  }

  // Change application mode state
  void getAppMode() {
    mode = CacheHelper.getData(key: 'mode')??0;
    if(mode == 0) {
      appMode = ThemeMode.system;
    }else if(mode == 1) {
      appMode = ThemeMode.light;
    }else if(mode == 1) {
      appMode = ThemeMode.dark;
    }else{
      appMode = ThemeMode.light;
    }
  }

  Future<void> changeAppMode(int index) async {
    mode=index;
    if(index == 0) {
      appMode=ThemeMode.system;
    }else if(index == 1) {
      appMode=ThemeMode.light;
    }else{
      appMode=ThemeMode.dark;
    }
    await CacheHelper.saveData(key: 'mode', value: mode);
    emit(AppChangModeState());
  }

  Future<void> changeNotification()async{
    notificationOn = !notificationOn;
    if(notificationOn){
      LocalNotificationService.showDailyRepeatedNotification(id: 0, title: 'title', body: 'body', payload: 'payload');
    }
    else {
      LocalNotificationService.cancelAllNotification();
    }
    await CacheHelper.saveData(key:'notifications', value: notificationOn);
    emit(AppToggleNotificationsState());
  }
}
