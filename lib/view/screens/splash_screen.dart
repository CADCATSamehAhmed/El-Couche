import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../consts/variable.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if(uid != null){
        Get.offAllNamed('home');
      } else{
        Get.offAllNamed('login');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return  Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration:const BoxDecoration(
          image:  DecorationImage(
            image: AssetImage("assets/fitness.jpg"),
            fit: BoxFit.cover
          ),
        ),
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(.9)
          ),
          child: Column(
            children:[
              SizedBox(height: screenHeight*.3,),
              Image(
                width: screenWidth*.5,
                image: const AssetImage("assets/gym.png"),
                color: Colors.white,
                fit: BoxFit.cover,
              ),
              SizedBox(height: screenHeight*.02,),
              Text(
                "الكوتش",
                style: font.copyWith(
                    color: Colors.white,
                    fontSize:27,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight*.18,),
              const SpinKitRing(
                color: Colors.white,
                size: 60.0,
              )
            ]
          ),
        ),
      ),
    );
  }
}
