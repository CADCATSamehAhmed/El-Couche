import 'package:cached_network_image/cached_network_image.dart';
import 'package:coach/view/screens/home_bodies/settings/workout_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coach/view/widgets/button.dart';
import 'package:coach/view/widgets/settings_items.dart';
import '../../../../consts/variable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../controller/functions/string_functions.dart';
import '../../../../controller/home/home_cubit.dart';
import '../../../../controller/home/home_states.dart';
import '../../../widgets/my_appbar.dart';
import 'profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    HomeCubit cubit = HomeCubit.get(context);
    return Scaffold(
      appBar: myAppBar(context: context, title: "اعدادات",),
      body: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
          return ListView(
            children: [
              customMainSettingItem(
                  thisColor: theme.primaryColorDark,
                  onPressed: (){
                    Get.to(()=>const WorkoutPreferencesScreen());
                  },
                  icon: Icons.fitness_center,
                  title: "المعلومات الرياضية"
              ),
              customMainSettingItem(
                  thisColor: theme.primaryColorDark,
                  onPressed: (){
                    Get.to(()=>const ProfileScreen());
                  },
                  icon: Icons.person_outline,
                  title: "المعلومات الشخصية"
              ),
              customInsideSettingItem(
                title: "المظهر",
                icon: Icons.visibility_outlined,
                data: getAppModeS(cubit.mode),
                thisColor: theme.primaryColorDark,
                onPressed: () {
                  Get.bottomSheet(
                    backgroundColor: theme.primaryColorLight,
                    BlocConsumer<HomeCubit, HomeStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Container(
                            height: screenHeight*.4,
                            padding: EdgeInsets.symmetric(vertical: screenHeight*0.025),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "اختر مظهر التطبيق",
                                  style: font.copyWith(
                                      color: theme.primaryColorDark, fontSize: 20),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical:screenHeight*0.025,),
                                  height: 1,
                                  width: screenWidth * .9,
                                  color: theme.primaryColorDark,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 3,
                                  itemBuilder: (BuildContext context, int index) {
                                    return RadioListTile(
                                      value: getAppModeS(index),
                                      groupValue: getAppModeS(cubit.mode),
                                      onChanged: (value){
                                        // Get.back();
                                        cubit.changeAppMode(index);
                                      },
                                      title: Text(getAppModeS(index),style: font.copyWith(color: theme.primaryColorDark),),
                                      activeColor:theme.primaryColor,
                                      fillColor:WidgetStateProperty.all(theme.primaryColorDark),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                    ),
                  );
                },
              ),
              customInsideSettingItem(
                title: "لغة التطبيق",
                icon: CupertinoIcons.globe,
                data: getAppLanguageS(cubit.language),
                thisColor: theme.primaryColorDark,
                onPressed: () {
                  Get.bottomSheet(
                    backgroundColor: theme.primaryColorLight,
                    BlocConsumer<HomeCubit, HomeStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Container(
                            height: screenHeight*.4,
                            padding: EdgeInsets.symmetric(vertical: screenHeight*0.025),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))
                            ),
                            child: ListView(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
                              children: [
                                Text(
                                  "لغة التطبيق",
                                  style: font.copyWith(
                                      color: theme.primaryColorDark, fontSize: 20),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical:screenHeight*0.025,),
                                  height: 1,
                                  width: screenWidth * .9,
                                  color: theme.primaryColorDark,
                                ),
                                InkWell(
                                  onTap: (){
                                    cubit.changeAppLanguage(cubit.language);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(screenWidth*.05),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: cubit.isArabic?theme.primaryColor:Colors.grey,width: .5),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Row(
                                      children: [
                                        Image(
                                          fit: BoxFit.cover,width: screenWidth*.2,
                                          image: const CachedNetworkImageProvider('https://th.bing.com/th/id/OIP.4ve4zACsz1LZOlMcCUHGBAHaE8?rs=1&pid=ImgDetMain'),
                                        ),
                                        SizedBox(width: screenWidth*.05,),
                                        Text('العربية',style: font.copyWith(color: theme.primaryColorDark),),
                                        const Spacer(),
                                        if(cubit.isArabic)Icon(CupertinoIcons.checkmark,color: theme.primaryColor,)
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    cubit.changeAppLanguage(cubit.language);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(screenWidth*.05),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: !cubit.isArabic?theme.primaryColor:Colors.grey,width: .5),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Row(
                                      children: [
                                        Image(
                                          fit: BoxFit.cover,width: screenWidth*.2,
                                          image: const CachedNetworkImageProvider('https://th.bing.com/th/id/R.6b1660591bbb23cc40b787849a10a0b7?rik=tYFqvQkV1SvGRg&riu=http%3a%2f%2fimages.all-free-download.com%2fimages%2fgraphiclarge%2fbritish_flag_clip_art_14068.jpg&ehk=y3BjohgkdOj0m0j6Wr9XAMRiqQE8H4GC7lG%2bWpl6kvc%3d&risl=&pid=ImgRaw&r=0'),
                                        ),
                                        SizedBox(width: screenWidth*.05,),
                                        Text('الانجليزية',style: font.copyWith(color: theme.primaryColorDark),),
                                        const Spacer(),
                                        if(!cubit.isArabic)Icon(CupertinoIcons.checkmark,color: theme.primaryColor,)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                    ),
                  );
                },
              ),
              customMainSettingItem(
                  thisColor: theme.primaryColorDark,
                  onPressed: (){
                    // Get.to(()=>const ProfileScreen());
                  },
                  icon: Icons.description_outlined,
                  title: "المساعدة والدعم"
              ),
              customMainSettingItem(
                icon: Icons.logout_rounded,
                title: "تسجيل الخروج",
                hasArrowIcon: false,
                thisColor: Colors.red,
                onPressed: () {
                  Get.bottomSheet(
                    Container(
                      height: screenHeight*.27,
                      padding: EdgeInsets.symmetric(vertical: screenHeight*0.025),
                      decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))
                      ),
                      child: Column(
                        children: [
                          Text(
                            "تسجبل الخروج",
                            style: font.copyWith(
                                color: Colors.red, fontSize: 20),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical:screenHeight*0.025,),
                            height: 1,
                            width: screenWidth * .9,
                            color: Colors.grey,
                          ),
                          Text(
                            "هل انت متأكد انك تريد تسجيل الخروج",
                            style: font.copyWith(fontSize: 18),
                          ),
                          SizedBox(height: screenHeight*0.02,),
                          Row(
                            mainAxisAlignment:MainAxisAlignment.center,
                            children: [
                              usedButton(
                                  text: "الغاء",
                                  textColor: theme.primaryColor,
                                  paddingSize:10,
                                  context: context,
                                  onPressed: () {
                                    Get.back();
                                  }),
                              BlocConsumer<HomeCubit, HomeStates>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    return usedButton(
                                        text: "نعم,سجل الخروج",
                                        paddingSize:10,
                                        context: context,
                                        width: screenWidth*.5,
                                        onPressed: () {
                                          cubit.logOut();
                                        }
                                    );
                                  }
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }
      ),
    );
  }
}
