import 'package:coach/view/screens/home_bodies/notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../consts/variable.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../model/user_model.dart';

PreferredSizeWidget homeAppBar({
  required ThemeData theme,
  required UserModel user,
  required void Function()? profileOnTap,
}) {
  int hour=DateTime.now().hour;
  String hi ='';
  if(hour>=0 && hour <12){
    hi =userHiMessage[0];
  } else{
    hi =userHiMessage[1];
  }
  return AppBar(
      backgroundColor:theme.scaffoldBackgroundColor,
      scrolledUnderElevation: 0,
      toolbarHeight: screenHeight*.1,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(hi,style: font.copyWith(color:theme.primaryColorDark,fontSize: 20),),
              const Image(image: AssetImage('assets/hi.png'),fit: BoxFit.cover,width: 25,),
            ],
          ),
          Text(user.fullName,style: font.copyWith(color:theme.primaryColorDark,fontSize: 25),),
        ],
      ),
      centerTitle: true,
      actions: [
        InkWell(
          onTap: (){
            Get.to(()=>const NotificationsScreen());
          },
          child: Container(
            padding: EdgeInsets.all(screenWidth*.03,),
            margin: EdgeInsets.symmetric(vertical:screenWidth*.02,),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              border: Border.all(color: Colors.grey.shade500,width: .5),
            ),
            child: Icon(Icons.notifications,color: theme.primaryColorDark.withOpacity(.5),size: 35,)
          ),
        ),
        InkWell(
          onTap: profileOnTap,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal:screenWidth*.05,vertical:screenWidth*.02,),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              border: Border.all(color: Colors.grey.shade500,width: .5),
            ),
            child: Container(
              height: 60,
              width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  image: DecorationImage(image: NetworkImage(user.image),fit: BoxFit.cover)
                ),
            ),
          ),
        )
      ]
  );
}

PreferredSizeWidget myAppBar({
  required BuildContext context,
  required String title,
  List<Widget>? actions,
}) {
  return
    AppBar(
    toolbarHeight: screenHeight*.09,
    leadingWidth: screenWidth*.25,
    leading: Padding(
      padding: EdgeInsets.all(screenWidth*.03),
      child: const Image(image:AssetImage('assets/gym.png'),fit:BoxFit.cover),
    ),
    title: Text(title,style: font.copyWith(color:Theme.of(context).primaryColor,fontSize: 30),),
    centerTitle: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    actions: actions
  );
}

PreferredSizeWidget trainingAppBar({
  required ThemeData theme,
  required double value,
}) {
  return
    AppBar(
      toolbarHeight: screenHeight*.09,
      leadingWidth: screenWidth*.15,
      leading: IconButton(onPressed: (){
        Get.back();
      }, icon: Icon(CupertinoIcons.xmark,size: screenWidth*.09,color: theme.primaryColorDark)),
      title: LinearPercentIndicator(
        width: screenWidth*.65,
        lineHeight: screenHeight*.03,
        percent: value,
        backgroundColor: Colors.grey.withOpacity(0.5),
        progressColor: theme.primaryColor,
        barRadius: const Radius.circular(11),
      ),
      centerTitle: true,
      backgroundColor: theme.scaffoldBackgroundColor,
  );
}

PreferredSizeWidget defaultAppBar({
  required ThemeData theme,
  required String title,
}) {
  return AppBar(
    backgroundColor: theme.scaffoldBackgroundColor,
    toolbarHeight: 70.0,
    iconTheme: IconThemeData(color: theme.primaryColorDark,size: 35),
    titleTextStyle:font.copyWith(fontSize: 25.0,color: theme.primaryColorDark),
    title: Text(title.tr),
    centerTitle: true,
  );
}