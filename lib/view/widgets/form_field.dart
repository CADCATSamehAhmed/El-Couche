import 'package:flutter/material.dart';
import '../../consts/variable.dart';

Widget defaultFormField({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?)? validate,
  required String label,
  double radius = 9.0,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      cursorColor: Theme.of(context).primaryColor,
      textAlign: TextAlign.start,
      validator: validate,
      style: font.copyWith(color: Theme.of(context).primaryColor, fontSize: 17.0),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.withOpacity(.1),
        hintText: label,
        hintStyle: font.copyWith(color: Colors.grey, fontSize: 15.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color:Colors.grey.withOpacity(.1),),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
        ),
      ),
    );

Widget customFormField({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType type,
  bool obscureText = false,
  required String? Function(String?)? validate,
  required void Function()? onTap,
  required String label,
  required Widget prefix,
  Widget? suffix,
  double radius = 9.0,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: obscureText,
      cursorColor: Theme.of(context).primaryColor,
      textAlign: TextAlign.start,
      validator: validate,
      onTap: onTap,
      style: font.copyWith(color: Theme.of(context).primaryColor, fontSize: 17.0),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: prefix,
        suffixIcon: suffix,
        hintText: label,
        hintStyle: font.copyWith(color: Colors.grey, fontSize: 15.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color:Colors.grey.withOpacity(.1),),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
        ),
      ),
    );

//default input form field
Widget editFormField({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  Function(String val)? onChanged,
  required String? Function(String? val)? validate,
  required String? label,
}) =>
    TextFormField(
      autofocus: true,
      controller: controller,
      keyboardType: type,
      cursorColor: Theme.of(context).primaryColor,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validate,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0),
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );