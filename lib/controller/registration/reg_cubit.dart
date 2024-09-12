import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach/controller/local_notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../consts/cache_helper.dart';
import '../../view/screens/auth/set_your_account/loading.dart';
import 'reg_states.dart';

class RegCubit extends Cubit<RegStates> {
  RegCubit() : super(RegInitialState());
  static RegCubit get(context) => BlocProvider.of(context);

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  bool emailSelected = false;
  bool passwordSelected = false;
  bool nameSelected = false;
  bool phoneSelected = false;
  bool obscurePassword = true;

  void tabOnFormField(bool p,bool b) {
    nameSelected = (p && b);
    phoneSelected = (p && !b);
    emailSelected = (!p && b);
    passwordSelected= (!p && !b);
    emit(TabOnFormFieldState());
  }

  void changePasswordVisible() {
    obscurePassword = !obscurePassword;
    emit(ChangePasswordVisibleState());
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(SignupLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      userCreate(email: email,uid: value.user!.uid,name: name,phone: phone);
    }).catchError((error) {
      if(error is FirebaseAuthException){
        if (error.code == 'weak-password') {
          emit(ErrorWeakPasswordState());
        } else if (error.code == 'email-already-in-use') {
          emit(ErrorEmailAlreadyInUseState());
        }
      }
      emit(SignupErrorState());
    });
  }

  Future userCreate({
    required String email,
    required String uid,
    String? name,
    String? phone,
    String? photo,
  }) async{
    emit(CreateAccountLoadingState());
    // final imageName = await uploadImage(imageFile);
    users.doc(uid).set({
      'uid': uid,
      'fullName': name,
      'email': email,
      'phone': phone??'dummy',
      'image': photo??'https://firebasestorage.googleapis.com/v0/b/echo-verse-de5dc.appspot.com/o/actor.png?alt=media&token=89635746-c9b3-417a-8e51-05c7203a565c',
    },SetOptions(merge: true)).then((value){
      CacheHelper.saveData(key: 'uid',value: uid);
      //daily training notifications 0
      LocalNotificationService.showDailyRepeatedNotification(id: 0, title: 'الكوتش', body: 'حان وقت التدريت', payload: 'حان وقت التدريت');
      emit(CreateAccountSuccessState());
      emit(SignupSuccessState());
    }).catchError((error){
      emit(CreateAccountErrorState());
    });
  }

  Future signUpWithGoogle() async {
    emit(CreateAccountLoadingState());
    // Trigger the authentication flow
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if(googleUser == null){
        emit(SignupErrorState());
        return ;
      }
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      userCreate(email: googleUser.email,uid: credential.idToken!,name: googleUser.displayName,photo: googleUser.photoUrl);
    }catch (e){
      emit(SignupErrorState());
    }
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      CacheHelper.saveData(key: 'uid',value: userCredential.user!.uid);
      CacheHelper.saveData(key: 'startDate',value: DateTime.now().weekday);
      LocalNotificationService.showDailyRepeatedNotification(id: 0, title: 'الكوتش', body: 'حان وقت التدريت', payload: 'حان وقت التدريت');
      emit(LoginSuccessState());
    }on FirebaseAuthException catch (error){
      if (error.code == 'wrong-password') {
        emit(ErrorWrongPasswordState());
      } else if (error.code == 'user-not-found') {
        emit(ErrorUserNotFoundState());
      } else{
        emit(LoginErrorState(error.toString()));
      }
    }
  }

  Future<void> forgetPassword({
    required String email,
  }) async {
    emit(RestPasswordLoadingState());
    await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
    ).then((value)
    {
      emit(RestPasswordSuccessState());
    }).catchError((error) {
      if(error is FirebaseAuthException){
        if (error.code == 'auth/invalid-email') {
          emit(ErrorInvalidEmailState());
        }else if (error.code == 'auth/user-not-found') {
          emit(ErrorUserNotFoundState());
        }
      }
      emit(RestPasswordErrorState());
    });
  }

  Future loginWithGoogle() async {
    emit(LoginLoadingState());
    // Trigger the authentication flow
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if(googleUser == null){
        emit(LoginErrorState("googleUser == null"));
        return ;
      }
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      CacheHelper.saveData(key: 'uid',value: credential.idToken);
      CacheHelper.saveData(key: 'startDate',value: DateTime.now().weekday);
      LocalNotificationService.showDailyRepeatedNotification(id: 0, title: 'الكوتش', body: 'حان وقت التدريت', payload: 'حان وقت التدريت');
      emit(LoginSuccessState());
    }catch (e){
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> showLoadingDialog(BuildContext context) async {
    await showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomLoading();
      });
  }

}
