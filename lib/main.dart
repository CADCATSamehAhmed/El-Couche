import 'package:coach/consts/cache_helper.dart';
import 'package:coach/controller/home/home_cubit.dart';
import 'package:coach/controller/home/home_states.dart';
import 'package:coach/view/screens/auth/forget_password.dart';
import 'package:coach/view/screens/auth/login.dart';
import 'package:coach/view/screens/auth/set_your_account/set_your_acount.dart';
import 'package:coach/view/screens/auth/signup.dart';
import 'package:coach/view/screens/app_layout.dart';
import 'package:coach/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'consts/themes.dart';
import 'controller/bloc_observer.dart';
import 'controller/local_notification_service.dart';
import 'controller/registration/reg_cubit.dart';
import 'controller/set_account/set_account_cubit.dart';
import 'firebase_options.dart';
import 'consts/variable.dart';
import 'language/translation.dart';

void main() async {
  await LocalNotificationService.init();
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  uid = await CacheHelper.getData(key: 'uid');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  void listenToNotificationStream(){
    LocalNotificationService.streamController.stream.listen((notificationResponse){
        notificationResponse.id;
        notificationResponse.payload;
      }
    );
  }
  @override
  void initState() {
    super.initState();
    listenToNotificationStream();
  }
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()..setup()..getAppMode()),
        BlocProvider(create: (context) => SetAccountCubit()),
        BlocProvider(create: (context) => RegCubit()),
      ],
      child:BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return GetMaterialApp(
            debugShowCheckedModeBanner :false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: HomeCubit.get(context).appMode,
            translations: Translation(),
            locale: Locale(HomeCubit.get(context).language),
            fallbackLocale: const Locale('ar'),
            routes: {
              '/':(context)=>const SplashScreen(),
              'login':(context)=>const LoginScreen(),
              'signup':(context)=>const SignUpScreen(),
              'setup':(context)=>const SetYourAccount(),
              'home':(context)=>const AppLayout(),
              'forgetPassword':(context)=>const ForgetPasswordScreen(),
            },
            );
        }
      )
      );
    }
}
