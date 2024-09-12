import 'package:coach/controller/registration/reg_cubit.dart';
import 'package:coach/controller/registration/reg_states.dart';
import 'package:coach/view/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as get_x;
import '../../../consts/variable.dart';
import '../../widgets/form_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    ThemeData theme = Theme.of(context);
    var cubit = RegCubit.get(context);
    return BlocConsumer<RegCubit, RegStates>(
        listener: (context, state) {
          if (state is SignupLoadingState) {
            cubit.showLoadingDialog(context);
          }
          else if (state is SignupSuccessState) {
            Future.delayed(const Duration(seconds: 2)).then((value) =>
                get_x.Get.toNamed('setup'));
          }
          else if (state is ErrorWeakPasswordState) {
            get_x.Get.snackbar(
                "weak-password", "The password provided is too weak");
          }
          else if (state is ErrorEmailAlreadyInUseState) {
            get_x.Get.snackbar("email-already-in-use",
                "The account already exists for that email");
          }
        },
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/b2.gif'), fit: BoxFit.fill)
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                toolbarHeight: screenWidth * .3,
                backgroundColor: Colors.transparent,
                leading: const Text(''),
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
                              borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            children: [
                              Text(
                                'أنشئ حسابك',
                                style: font.copyWith(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: theme.primaryColor),
                              ),
                              SizedBox(height: screenWidth * .02),
                              customFormField(
                                context: context,
                                controller: nameController,
                                type: TextInputType.name,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'من فضلك ادخل اسمك';
                                  }
                                  return null;
                                },
                                label: 'الاسم',
                                onTap: () {
                                  cubit.tabOnFormField(true,true);
                                },
                                prefix: Icon(
                                    Icons.person_3, color:cubit.nameSelected
                                    ? theme.primaryColor
                                    : Colors.grey),
                              ),
                              SizedBox(height: screenWidth * .02),
                              customFormField(
                                context: context,
                                controller: phoneController,
                                type: TextInputType.number,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'من فضلك ادخل رقم هاتفك';
                                  }
                                  return null;
                                },
                                label: 'رقم الهاتف',
                                onTap: () {
                                  cubit.tabOnFormField(true,false);
                                },
                                prefix: Icon(
                                    Icons.phone, color: cubit.phoneSelected
                                    ? theme.primaryColor
                                    : Colors.grey),
                              ),
                              SizedBox(height: screenWidth * .02),
                              customFormField(
                                context: context,
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'من فضلك ادخل البريد الألكتروني';
                                  }
                                  return null;
                                },
                                label: 'البريد الألكتروني',
                                onTap: () {
                                  cubit.tabOnFormField(false,true);
                                },
                                prefix: Icon(Icons.email_rounded,
                                    color: cubit.emailSelected ? theme
                                        .primaryColor : Colors.grey),
                              ),
                              SizedBox(height: screenWidth * .02),
                              customFormField(
                                context: context,
                                obscureText: cubit.obscurePassword,
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                validate: (String? value) {
                                  if (value!.length < 8) {
                                    return 'يجب الا تقل كلمة المرور عن 8 احرف';
                                  }
                                  return null;
                                },
                                label: 'كلمة المرور',
                                onTap: () {
                                  cubit.tabOnFormField(false,false);
                                },
                                prefix: Icon(Icons.lock,
                                    color: cubit.passwordSelected ? theme
                                        .primaryColor : Colors.grey),
                                suffix: IconButton(
                                  onPressed: () {
                                    cubit.changePasswordVisible();
                                  },
                                  icon: Icon(
                                    cubit.obscurePassword ? CupertinoIcons
                                        .eye_slash_fill : CupertinoIcons
                                        .eye_fill,
                                    color: cubit.passwordSelected ? theme
                                        .primaryColor : Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(height: screenWidth * .02),
                              usedButton(
                                width: screenWidth * .9,
                                paddingSize: 20.0,
                                text: "أنشئ حسابك",
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    cubit.signUp(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name:nameController.text,
                                      phone:phoneController.text,
                                    );
                                  }
                                },
                                context: context,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenWidth * .02),
                        InkWell(
                          onTap: () {
                            cubit.signUpWithGoogle();
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
                              "لديك حساب بالفعل؟",
                              style: font.copyWith(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                            TextButton(
                              onPressed: () {
                                get_x.Get.back();
                              },
                              child: Text(
                                "سجل دخولك",
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
        }
    );
  }
}