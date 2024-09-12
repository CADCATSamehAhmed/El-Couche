import 'package:coach/consts/variable.dart';
import 'package:coach/model/exercise_model.dart';
import 'package:flutter/material.dart';
import '../../../../consts/local_database.dart';
import '../../../widgets/exercise_card.dart';

class CustomSearchDelegate extends SearchDelegate{

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query ='';
      }, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return
      IconButton(onPressed: (){
        close(context, null);
      }, icon: const Icon(Icons.arrow_back))
    ;
  }

  @override
  Widget buildResults(BuildContext context) {
    var theme = Theme.of(context);
    List<WorkOutListModel> matchQuery=[];
    for(var workout in workouts){
      String work = workout.title;
      if(work.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(workout);
      }
    }
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: screenWidth*.05),
      children: [
        Text(
          '${matchQuery.length} نتائج ',
          style: font.copyWith(
              color: theme.primaryColorDark,
              fontSize:22,
              fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.start,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: matchQuery.length,
          itemBuilder: (BuildContext context, int index) {
            return CollectionExerciseCard(
              workout: matchQuery[index],
            );
          },
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var theme = Theme.of(context);
    List<WorkOutListModel> matchQuery=[];
    for(var workout in workouts){
      String work = workout.title;
      if(work.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(workout);
      }
    }
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: screenWidth*.05),
      children: [
        Text(
          'most Popular Searches',
          style: font.copyWith(
              color: theme.primaryColorDark,
              fontSize:22,
              fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: screenWidth*.05,),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: matchQuery.length,
          itemBuilder: (BuildContext context, int index) {
            return CollectionExerciseCard(
              workout: matchQuery[index],
            );
          },
        ),
      ],
    );
  }

}
