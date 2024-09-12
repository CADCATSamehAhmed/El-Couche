import 'package:coach/consts/variable.dart';
import 'package:flutter/material.dart';
import 'package:coach/view/widgets/settings_items.dart';
import '../../../../controller/home/home_cubit.dart';
import '../../../../controller/local_notification_service.dart';
import '../../../widgets/my_appbar.dart';

class WorkoutPreferencesScreen extends StatelessWidget {
  const WorkoutPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    HomeCubit cubit = HomeCubit.get(context);
    return Scaffold(
      appBar: defaultAppBar(theme: theme, title: "المعلومات الرياضية",),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth*.05),
        children: [
          customInsideSettingItem(
              thisColor: theme.primaryColorDark,
              onPressed: (){},
              data: cubit.user.workOutPreference.gender,
              title: "النوع",
          ),
          customInsideSettingItem(
              thisColor: theme.primaryColorDark,
              onPressed: (){},
              data: "${cubit.user.workOutPreference.age}سنة ",
              title: "العمر"
          ),
          customInsideSettingItem(
              thisColor: theme.primaryColorDark,
              onPressed: (){},
              data: "${cubit.user.workOutPreference.height}سم ",
              title: "الطول"
          ),
          customInsideSettingItem(
              thisColor: theme.primaryColorDark,
              onPressed: (){},
              data: "${cubit.user.workOutPreference.weight}كجم ",
              title: "الوزن"
          ),
          customInsideSettingItem(
              thisColor: theme.primaryColorDark,
              onPressed: (){},
              data: "${cubit.user.workOutPreference.workOutDays}ايام ",
              title: "عدد ايام التمرين"
          ),
          customInsideSettingItem(
              thisColor: theme.primaryColorDark,
              onPressed: (){},
              data: "${cubit.planModel.restTimeBetweenSets}ثانية ",
              title: "الراحة بين التمارين"
          ),
          customInsideSettingItem(
              thisColor: theme.primaryColorDark,
              onPressed: (){
                LocalNotificationService.showBasicNotification(id: 2, title: 'title', body: 'body', payload: 'payload');
              },
              data: "الافتراضي",
              title: "صوت التنبية"
          ),
          customSettingToggleItem(
              theme: theme,
              onPressed: (on){
                cubit.changeNotification();
              },
              title: "التذكير بالتمارين",
              on: cubit.notificationOn,
          ),
        ],
      ),
    );
  }
}
