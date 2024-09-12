import 'package:cached_network_image/cached_network_image.dart';
import 'package:coach/view/screens/home_bodies/training/inside_training.dart';
import 'package:coach/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coach/controller/home/home_cubit.dart';
import 'package:coach/controller/home/home_states.dart';
import 'package:get/get.dart';
import '../../../../consts/variable.dart';
import '../../../../model/exercise_model.dart';
import '../../../widgets/exercise_card.dart';

class InsideWorkOutScreen extends StatelessWidget {
  final WorkOutListModel model;
  final List<ExerciseModel> list;
  const InsideWorkOutScreen({super.key,required this.model, required this.list});

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context);
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            body:CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: screenHeight*.2,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image(
                      image: CachedNetworkImageProvider(model.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back,color: theme.primaryColorLight,),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(model.title,style: font.copyWith(color: theme.primaryColorDark,fontSize: 25,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context,index)=> ExerciseCard(exercise: list[index], index: index,),
                    childCount: list.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: usedButton(
                        text: 'start',
                        context: context,
                        onPressed: (){Get.to(InsideTrainingScreen(list: list,));}
                      ),
                    ),
                  ),
              ],
            ),
          );
        }
    );
  }
}