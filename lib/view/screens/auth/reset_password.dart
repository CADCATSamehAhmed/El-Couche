import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../consts/variable.dart';
import '../../../controller/registration/reg_cubit.dart';
import '../../../controller/registration/reg_states.dart';
import '../../widgets/button.dart';
import '../../widgets/form_field.dart';

class RestPasswordScreen extends StatelessWidget {
  const RestPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    ThemeData theme = Theme.of(context);
    var cubit = RegCubit.get(context);
    return BlocConsumer<RegCubit, RegStates>(
        listener: (context, state) {
          if(state is LoginLoadingState){
            cubit.showLoadingDialog(context);
          }
          else if(state is LoginSuccessState){
            Get.offAllNamed('home');
          }
          else if(state is ErrorWrongPasswordState){
            Get.snackbar("wrong-password", "Wrong password provided for that user");
          }
          else if(state is ErrorUserNotFoundState){
            Get.snackbar("user-not-found", "No user found for that email");
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/b2.gif'),fit: BoxFit.fill)
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: Text(
                    "ادخل كلمة المرور الجديدة",
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
                          "اقتربنا من الإنتهاء! أنشأ كلمة مررور جديدة لحساب BodyBoost خاصتك للحفاظ على امان حسابك .تذكر ان تصنع كلمة مرور قوية وفريدة",
                          style: font.copyWith(fontSize: 20, color: Colors.grey),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          "كلمة المرور الجديدة",
                          style: font.copyWith(fontSize: 23, color: Colors.black),
                        ),
                        customFormField(
                          context: context,
                          obscureText: cubit.obscurePassword,
                          controller: newPasswordController,
                          type: TextInputType.visiblePassword,
                          validate: (String? value) {
                            if (value!.length < 8) {
                              return 'يجب الا تقل كلمة المرور عن 8 احرف';
                            }
                            return null;
                          },
                          label: "كلمة المرور الجديدة",
                          onTap: (){
                            cubit.tabOnFormField(false,true);
                          },
                          prefix: Icon(Icons.lock,color:cubit.passwordSelected?theme.primaryColor:Colors.grey,),
                          suffix: IconButton(
                            onPressed: (){
                              cubit.changePasswordVisible();
                            },
                            icon: Icon(
                              cubit.obscurePassword
                                  ?CupertinoIcons.eye_slash_fill
                                  :CupertinoIcons.eye_fill,
                              color:cubit.passwordSelected?theme.primaryColor:Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "اكد كلمة المرور",
                          style: font.copyWith(fontSize: 23, color: Colors.black),
                        ),
                        customFormField(
                          context: context,
                          obscureText: cubit.obscurePassword,
                          controller: confirmPasswordController,
                          type: TextInputType.visiblePassword,
                          validate: (String? value) {
                            if (value!.length < 8) {
                              return 'يجب الا تقل كلمة المرور عن 8 احرف';
                            }
                            return null;
                          },
                          label: 'اكد كلمة المرور',
                          onTap: (){
                            cubit.tabOnFormField(false,false);
                          },
                          prefix: Icon(Icons.lock,color:cubit.passwordSelected?theme.primaryColor:Colors.grey,),
                          suffix: IconButton(
                            onPressed: (){
                              cubit.changePasswordVisible();
                            },
                            icon: Icon(
                              cubit.obscurePassword
                                  ?CupertinoIcons.eye_slash_fill
                                  :CupertinoIcons.eye_fill,
                              color:cubit.passwordSelected?theme.primaryColor:Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                bottomSheet: usedButton(
                  width: screenWidth * .9,
                  paddingSize: 20.0,
                  text: "احفظ كلمة المرور",
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {

                    }
                  },
                  context: context,),
              ),
            ),
          );
        }
    );
  }
}
