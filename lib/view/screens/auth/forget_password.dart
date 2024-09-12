import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../consts/variable.dart';
import '../../../controller/registration/reg_cubit.dart';
import '../../../controller/registration/reg_states.dart';
import '../../widgets/button.dart';
import '../../widgets/form_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    ThemeData theme = Theme.of(context);
    var cubit = RegCubit.get(context);
    return BlocConsumer<RegCubit, RegStates>(
        listener: (context, state) {
          if(state is RestPasswordLoadingState){
            cubit.showLoadingDialog(context);
          }
          else if(state is RestPasswordSuccessState){
            Get.offAllNamed('home');
          }
          else if(state is ErrorInvalidEmailState){
            Get.snackbar("wrong-password", "Wrong password provided for that user");
          }
          else if(state is ErrorUserNotFoundState){
            Get.snackbar("user-not-found", "No user found for that email");
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
                title: Text(
                  "نسيت كلمة المرور",
                  style: font.copyWith(fontSize: 25, color: Colors.black),
                ),
              ),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * .05),
                  child: Column(
                    children: [
                      Text(
                        "ادخل البريد الألكتروني للحساب المراد اعادة ضبط كلمة مروره ,وسوف نرسل لك رسالة لأعادة ضبط كلمة السر",
                        style: font.copyWith(fontSize: 20, color: Colors.grey),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        "البريد الألكتروني",
                        style: font.copyWith(fontSize: 23, color: Colors.black),
                      ),
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
                        onTap: (){
                          cubit.tabOnFormField(false,true);
                        },
                        prefix: Icon(Icons.email_rounded,color:cubit.emailSelected?theme.primaryColor:Colors.grey,),
                      ),
                    ],
                  ),
                ),
              ),
              bottomSheet: usedButton(
                width: screenWidth * .9,
                paddingSize: 20.0,
                text: "إرسال رسالة إعادة الضبط",
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    cubit.forgetPassword(email: emailController.text);
                  }
                },
                context: context,
              ),
            ),
          );
        }
    );
  }
}
