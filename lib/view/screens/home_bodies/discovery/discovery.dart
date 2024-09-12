import 'package:coach/consts/local_database.dart';
import 'package:coach/view/screens/home_bodies/discovery/search.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coach/controller/home/home_cubit.dart';
import 'package:coach/controller/home/home_states.dart';
import 'package:coach/view/widgets/my_appbar.dart';
import '../../../../consts/variable.dart';
import '../../../widgets/exercise_card.dart';
import '../../../widgets/my_card.dart';

class DiscoveryScreen extends StatelessWidget {
  const DiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    HomeCubit cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: !cubit.loading,
              builder:(context)=> Scaffold(
                  appBar: myAppBar(context: context, title: "اكتشف",),
                  body:ListView(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth*.05),
                    children: [
                      SizedBox(height: screenWidth*.05,),
                      InkWell(
                        onTap: (){
                          showSearch(context: context, delegate: CustomSearchDelegate());
                        },
                        child: Container(
                          padding: EdgeInsets.all(screenWidth*.04),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.1),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.search,color: Colors.grey,),
                              SizedBox(width: 10,),
                              Text("Search workout plan ...",style: TextStyle(color: Colors.grey),)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenWidth*.05,),
                      Row(
                        children: [
                          Text(
                            'التمارين الرائجة',
                            style: font.copyWith(
                                color: theme.primaryColorDark,
                                fontSize:22,
                                fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(height: screenWidth*.05,),
                      ListView.builder(
                        cacheExtent: 5,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index)=>CollectionExerciseCard(
                          workout: workouts[index],
                        ),
                        itemCount: workouts.length,
                      ),
                    ],
                  )
              ),
              fallback: (context){
                return ListView.builder(
                  padding: EdgeInsets.all(screenWidth*.05),
                  itemBuilder: (context,index){
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: screenWidth*.03),
                      child: Row(
                        children:[
                          ShimmerCard(height: screenWidth*.3, width: screenWidth*.3,),
                          SizedBox(width: screenWidth*.03,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              ShimmerCard(height: 20, width: screenWidth*.48,),
                              SizedBox(height: screenWidth*.01,),
                              ShimmerCard(height: 15, width: screenWidth*.3,),
                            ]
                          ),
                        ]
                      ),
                    );
                  },
                  itemCount: 5,
                );
              }
          );
        }
      );
  }
}
