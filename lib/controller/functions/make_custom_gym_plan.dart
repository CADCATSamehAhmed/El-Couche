import '../../consts/cache_helper.dart';
import '../../model/plan_model.dart';

Future<PlanModel> makeCustomGymPlan({
  required int workOutGoal,
  required int workoutDays,
}) async {

  String setsNumber;
  String repsNumber;
  int restTimeBetweenSets;
  List fun2Output = await fun2(workoutDays);
  if (workOutGoal == 0 ){
    setsNumber= '3-4';
    repsNumber= '12-15';
    restTimeBetweenSets= 90;
  }
  else if (workOutGoal == 1 ){
    setsNumber= '3-4';
    repsNumber= '8-12';
    restTimeBetweenSets= 120;
  }
  else{
    setsNumber= '2-3';
    repsNumber= '6-12';
    restTimeBetweenSets= 90;
  }
  CacheHelper.saveData(key: 'startDate',value: DateTime.now().weekday);
  return PlanModel(
      planName: 'PPL',
      daysPerWeek: fun2Output[0],
      exercisesPerDay: fun2Output[1],
      setsNumber: setsNumber,
      repsNumber: repsNumber,
      restTimeBetweenSets: restTimeBetweenSets,
      workoutDays: fun2Output[2]
  );
}

Future<List> fun2(int workoutDays)
async{
  int day;
  int exercisesPerDay;
  List<String> workoutDaysList;
  if (workoutDays > 3 && workoutDays <= 5){
    day=5;
    exercisesPerDay= 7;
    workoutDaysList= ['push1','pull1','legs','rest','push2','pull2','rest'];
  }
  else if (workoutDays > 5){
    day=6;
    exercisesPerDay= 6;
    workoutDaysList= ['push1','pull1','legs','rest','push2','pull2','legs'];
  }
  else{
    day=3;
    exercisesPerDay= 7;
    workoutDaysList= ['push1','rest','pull1','rest','legs','rest','rest'];
  }
  return [day,exercisesPerDay,workoutDaysList];
}