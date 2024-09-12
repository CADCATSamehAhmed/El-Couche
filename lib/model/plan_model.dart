class PlanModel {
  late String planName;
  late int daysPerWeek;
  late int exercisesPerDay;
  late String setsNumber;
  late String repsNumber;
  late int restTimeBetweenSets;
  late List<dynamic> workoutDays;

  PlanModel({
    required this.planName,
    required this.daysPerWeek,
    required this.exercisesPerDay,
    required this.setsNumber,
    required this.repsNumber,
    required this.restTimeBetweenSets,
    required this.workoutDays,
  });

  PlanModel.fromJson(Map<String,dynamic>?json,{data}){
    planName=json!['planName']??'PPL';
    daysPerWeek=json['daysPerWeek']??0;
    exercisesPerDay=json['exercisesPerDay']??0;
    setsNumber=json['setsNumber']??'3-4';
    repsNumber=json['repsNumber']??'10-12';
    restTimeBetweenSets=json['restTimeBetweenSets']??120;
    workoutDays=json['workoutDays']??[];
  }
  Map<String,dynamic> toMap() {
    return{
      'planName': planName,
      'daysPerWeek':daysPerWeek,
      'exercisesPerDay':exercisesPerDay,
      'setsNumber':setsNumber,
      'repsNumber':repsNumber,
      'restTimeBetweenSets':restTimeBetweenSets,
      'workoutDays':workoutDays,
    };
  }
}