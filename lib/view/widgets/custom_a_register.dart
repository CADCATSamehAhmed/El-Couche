import 'package:flutter/material.dart';
import '../../consts/variable.dart';
import 'button.dart';
import 'form_field.dart';

Widget customARegister({
  required String welcome,
  required String hi,
  required BuildContext context,
  required ThemeData theme,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required void Function()? emailOnTap,
  required void Function()? passwordOnTap,
  required Color emailPrefixIConColor,
  required Color passwordPrefixIConColor,
  required Widget? passwordSuffix,
  required bool obscureText,
  required String registerButtonTitle,
  required void Function()? submitOnPressed,
  bool hasSizedBoxAtBottom = true,
  bool hasForgetPassword = true,
  Widget forgetPassword =const SizedBox(),
}){
  return Column(
    children: [
      Text(
        welcome,
        style: font.copyWith(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: theme.primaryColor),
      ),
      Text(
        hi,
        style:
        font.copyWith(fontSize: 13.0, color: Colors.white),
      ),
      SizedBox(height: screenWidth*.02),
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
        onTap: emailOnTap,
        prefix: Icon(Icons.email_rounded,color:emailPrefixIConColor),
      ),
      SizedBox(height: screenWidth*.02),
      customFormField(
        context: context,
        obscureText: obscureText,
        controller: passwordController,
        type: TextInputType.visiblePassword,
        validate: (String? value) {
          if (value!.length < 8) {
            return 'يجب الا تقل كلمة المرور عن 8 احرف';
          }
          return null;
        },
        label: 'كلمة المرور',
        onTap: passwordOnTap,
        prefix: Icon(Icons.lock,color:passwordPrefixIConColor),
        suffix: passwordSuffix,
      ),
      SizedBox(height: screenWidth*.02),
      usedButton(
        width: screenWidth*.9,
        paddingSize: 20.0,
        text: registerButtonTitle,
        onPressed: submitOnPressed,
        context: context,
      ),
      if(hasSizedBoxAtBottom)SizedBox(height: screenWidth*.02),
      if(hasForgetPassword)forgetPassword
    ],
  );
}