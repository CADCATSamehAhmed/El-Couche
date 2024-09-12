import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../consts/variable.dart';
import '../../../../controller/registration/reg_cubit.dart';
import '../../../../controller/registration/reg_states.dart';

class CustomLoading extends StatefulWidget {
  const CustomLoading({super.key});

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading> {
  bool success = false;
  bool error = false;
  @override
  Widget build(BuildContext context) {
    var theme  = Theme.of(context);
    return BlocConsumer<RegCubit, RegStates>(
        listener: (context, state) {
          if(state is SignupSuccessState || state is LoginSuccessState || state is RestPasswordSuccessState){
            setState((){
              success = true;
            });
            Future.delayed(const Duration(seconds:1)).then((value) => Get.back());
          }
          else if(state is ErrorWeakPasswordState 
              || state is SignupErrorState
              || state is CreateAccountErrorState
              || state is LoginErrorState 
              || state is RestPasswordErrorState 
              || state is ErrorEmailAlreadyInUseState 
              || state is ErrorWrongPasswordState 
              || state is ErrorUserNotFoundState 
              || state is RestPasswordErrorState
              || state is ErrorInvalidEmailState
          ){
            setState((){
              error = true;
            });
            Future.delayed(const Duration(seconds:1)).then((value) => Get.back());
          }
        },
        builder: (context, state) {
          return Container(
            color: Colors.transparent,
            child: Center(
              child: Container(
                height: screenWidth*.3,
                width: screenWidth*.3,
                padding: EdgeInsets.all(screenWidth*.1),
                decoration: BoxDecoration(
                  color: theme.primaryColorLight,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: custom(success, error),
              ),
            ),
          );
      }
    );
  }
  Widget custom(bool success,bool error){
    if(success){
      return const Icon(CupertinoIcons.checkmark,color: Colors.green,);
    }if(error){
      return const Icon(CupertinoIcons.xmark,color: Colors.red,);
    } else{
      return const CircularProgressIndicator(color: Colors.orange);
    }
  }
}