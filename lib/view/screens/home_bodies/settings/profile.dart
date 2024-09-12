import 'package:coach/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../consts/variable.dart';
import '../../../../controller/home/home_cubit.dart';
import '../../../../controller/home/home_states.dart';
import '../../../widgets/form_field.dart';
import '../../../widgets/my_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    HomeCubit cubit = HomeCubit.get(context);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: theme.primaryColorLight,
      appBar: defaultAppBar(theme: theme, title: "المعلومات الشخصية",),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<HomeCubit, HomeStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        //user Image
                        SizedBox(
                          height: screenWidth*.4,
                          width: screenWidth*.4,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                height: screenWidth*.39,
                                width: screenWidth*.39,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: cubit.profileImage != null
                                        ? FileImage(cubit.profileImage!)
                                        : NetworkImage(cubit.user.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async{
                                  await cubit.pickImage();
                                },
                                icon: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: const Icon(Icons.edit,color: Colors.white,size: 20)),
                              ),
                            ],
                          ),
                        ),
                      ]
                  );
                }
              ),
              DataField(title: "الاسم".tr, data: cubit.user.fullName,isName: true,isPhone: false),
              DataField(title: "رقم الهاتف".tr, data: cubit.user.phone,isName: false,isPhone:true),
              DataField(title: "البريد الألكتروني".tr, data: cubit.user.email,icon:Icons.email,isName: false,isPhone:false),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(screenWidth*.07),
        color: theme.primaryColorLight,
        child: usedButton(
            text: "حفظ",
            context: context,
            width: screenWidth*.85,
            onPressed: ()async{
              if(cubit.profileName!=null){
                await cubit.updateUserData('fullName',cubit.profileName);
              }
              if(cubit.profilePhone!=null){
                await cubit.updateUserData('phone',cubit.profilePhone);
              }
              if(cubit.file!=null){
                await cubit.updateImage(cubit.file!);
              }
              await cubit.getUser();
              Get.back();
            }
        ),
      ),
    );
  }
}

class DataField extends StatelessWidget {
  final String title;
  final String data;
  final IconData? icon;
  final bool isName;
  final bool isPhone;
  final void Function()? fun;
  const DataField({super.key, required this.data, required this.title, this.icon, required this.isPhone, required this.isName, this.fun});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextEditingController controller = TextEditingController();
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(screenWidth*.06,screenWidth*.03,screenWidth*.06,0),
                child: Text(title,style: font.copyWith(color: theme.primaryColorDark,fontSize: 18),),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth*.06,vertical: screenWidth*.03),
                child: InkWell(
                  onTap: (isPhone || isName)
                      ?(){
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context){
                          return Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title,style: font.copyWith(color: theme.primaryColor,fontSize: 22.0)),
                                editFormField(
                                    context: context,
                                    controller: controller,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return '$title can not be empty!';
                                      }
                                      return null;
                                    },
                                    label: data,
                                    type: isName?TextInputType.text:TextInputType.number
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: (){Navigator.pop(context);},
                                        child: Text('back',style: font.copyWith(color: theme.primaryColor,fontSize: 15.0),)
                                    ),
                                    const SizedBox(width: 5,),
                                    ElevatedButton(
                                        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(theme.primaryColor)),
                                        onPressed: () async{
                                          await cubit.changeUserData(isName, controller.text);
                                          Get.back();
                                        },
                                        child: Text('save',style: font.copyWith(color: Colors.white,fontSize: 16.0),)
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                    );
                  }
                      :(){},
                  child: Container(
                    padding: EdgeInsets.all(screenWidth*.04),
                    decoration:BoxDecoration(
                        color: theme.primaryColorDark.withOpacity(.1),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Row(
                      children: [
                        if(icon!=null)Icon(icon,color: theme.primaryColorDark,size: 20,),
                        if(isPhone)Text(
                            "+20",
                            style:font.copyWith(
                              color:theme.primaryColorDark,
                              fontSize: 20,
                            )
                        ),
                        if(icon!=null || isPhone)SizedBox(width: screenWidth*.05,),
                        if(!isPhone)SizedBox(
                          width: (icon!=null)?screenWidth*.68:screenWidth*.78,
                          child: Text(
                            data,
                            maxLines: 1,
                            style:font.copyWith(color: theme.primaryColorDark,fontSize: 18),
                          ),
                        ),
                        if(isPhone)SizedBox(
                          width: screenWidth*.6,
                          child: Text(
                            data,
                            maxLines: 1,
                            style:font.copyWith(color: theme.primaryColorDark,fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}


