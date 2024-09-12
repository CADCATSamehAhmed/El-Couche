import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as get_x;
import 'package:coach/view/screens/auth/signup.dart';
import 'package:coach/view/widgets/custom_a_register.dart';
import '../../../consts/variable.dart';
import '../../../controller/registration/reg_cubit.dart';
import '../../../controller/registration/reg_states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController loginPasswordController = TextEditingController();
    TextEditingController loginEmailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    ThemeData theme = Theme.of(context);
    var cubit = RegCubit.get(context);
    return BlocConsumer<RegCubit, RegStates>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          cubit.showLoadingDialog(context);
        } else if (state is LoginSuccessState) {
          Future.delayed(const Duration(seconds: 2)).then((value) => get_x.Get.offAllNamed('home'));
        } else if (state is ErrorWrongPasswordState) {
          get_x.Get.snackbar("wrong-password", "Wrong password provided for that user");
        } else if (state is ErrorUserNotFoundState) {
          get_x.Get.snackbar("user-not-found", "No user found for that email");
        }
      },
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/b2.gif'),fit: BoxFit.fill)
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              toolbarHeight: screenWidth * .3,
              title: Image(
                width: screenWidth * .3,
                image: const AssetImage("assets/gym.png"),
                color: Colors.white70,
                colorBlendMode: BlendMode.dstIn,
                fit: BoxFit.cover,
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * .05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * .05,
                            vertical: screenWidth * .02),
                        decoration: BoxDecoration(
                            color: Colors.transparent.withOpacity(.3),
                            borderRadius: const BorderRadius.all(Radius.circular(15))),
                        child:
                        customARegister(
                          welcome: 'مرحباً بعودتك',
                          hi: 'سجل دخولك الأن لتكمل رحلة لياقتك',
                          context: context,
                          theme: theme,
                          emailController: loginEmailController,
                          passwordController: loginPasswordController,
                          emailOnTap: () {cubit.tabOnFormField(false,true);},
                          passwordOnTap: () {cubit.tabOnFormField(false,false);},
                          emailPrefixIConColor: cubit.emailSelected ? theme.primaryColor : Colors.grey,
                          passwordPrefixIConColor: cubit.passwordSelected ? theme.primaryColor : Colors.grey,
                          passwordSuffix: IconButton(
                            onPressed: () {cubit.changePasswordVisible();},
                            icon: Icon(cubit.obscurePassword ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
                              color: cubit.passwordSelected ? theme.primaryColor : Colors.grey,
                            ),
                          ),
                          obscureText: cubit.obscurePassword,
                          registerButtonTitle: "تسجيل الدخول",
                          submitOnPressed: () async {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                email: loginEmailController.text,
                                password: loginPasswordController.text);
                            }
                          },
                          forgetPassword: TextButton(
                            onPressed: () {get_x.Get.toNamed('forgetPassword');},
                            child: Text("نسيت كلمة المرور ؟",
                              style: font.copyWith(
                                color: theme.primaryColor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        )
                      ),
                      SizedBox(height: screenWidth * .02),
                      InkWell(
                        onTap: () {
                          cubit.loginWithGoogle();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade300, width: .5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: const Image(
                            height: 25,
                            filterQuality: FilterQuality.high,
                            image: AssetImage("assets/G.png"),
                          ),
                        ),
                      ),
                      SizedBox(height: screenWidth * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ليس لديك حساب؟",
                            style: font.copyWith(
                                color: Colors.white, fontSize: 12.0),
                          ),
                          TextButton(
                            onPressed: () {
                              get_x.Get.to(()=>const SignUpScreen(),transition: get_x.Transition.rightToLeftWithFade,duration: const Duration(seconds: 1));
                            },
                            child: Text(
                              "انشئ الأن",
                              style: font.copyWith(
                                  color: theme.primaryColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
    });
  }
}
