import 'package:coach/consts/variable.dart';
import 'package:coach/controller/home/home_cubit.dart';
import 'package:coach/controller/home/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    HomeCubit cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          return GNav(
            rippleColor: Colors.grey.shade800, // tab button ripple color when pressed
            hoverColor: Colors.grey.shade700, // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(color: theme.primaryColor, width: 1), // tab button border
            tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
            curve: Curves.easeOutExpo, // tab animation curves
            duration: const Duration(milliseconds: 900), // tab animation duration
            gap: 8, // the tab button gap between icon and text 
            color: Colors.grey.shade500, // unselected icon color
            activeColor: theme.primaryColor, // selected icon and text color
            iconSize: 24, // tab button icon size
            tabBackgroundColor: theme.primaryColorLight.withOpacity(.5), // selected tab background color
            padding: EdgeInsets.symmetric(horizontal: screenWidth*.1, vertical: 6), // navigation bar padding
            tabs: const [
              GButton(
                icon: Icons.home_rounded,
              ),
              GButton(
                icon: Icons.explore,
              ),
              GButton(
                icon: Icons.settings_rounded,
              )
            ],
            selectedIndex: cubit.currentIndex,
            onTabChange: (value) => cubit.changeBottomNavBarIndex(value),
          );
        }
    );
  }
}