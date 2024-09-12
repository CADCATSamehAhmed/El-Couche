import 'package:coach/consts/local_database.dart';
import 'package:coach/model/exercise_model.dart';
import '../../consts/cache_helper.dart';

List<ExerciseModel> getExerciseName(String t){
  List<ExerciseModel> list=[];
  List<String> doneExercisesIds = CacheHelper.getData(key: 'doneExercisesIds')??[];
  if(t == 'push1'){
    list = push1;
  }
  else if(t == 'push2'){
    list = push2;
  }
  else if(t == 'pull1'){
    list = pull1;
  }
  else if(t == 'pull2'){
    list = pull2;
  }
  else if(t == 'legs'){
    list = legs;
  }
  else{
    list = [];
  }
  if(doneExercisesIds.isNotEmpty){
    for(int i=0;i<list.length;){
      int id = int.parse(doneExercisesIds[i]);
      if(list[i].id==id){
        list.remove(list[i]);
      }
      else{
        i++;
      }
    }
  }
  return list;
}