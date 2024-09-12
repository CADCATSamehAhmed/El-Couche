import 'package:coach/controller/home/home_cubit.dart';
import 'package:coach/controller/home/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coach/view/widgets/bottom_navigation_bar.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    HomeCubit cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: cubit.bodyScreens[cubit.currentIndex],
          bottomNavigationBar: const CustomBottomNavigationBar(),
        );
      }
    );
  }
}