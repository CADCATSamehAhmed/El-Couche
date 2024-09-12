import 'package:coach/model/plan_model.dart';

class CustomDataModel {
  late double calories;
  late String dietPlan;
  late double water;
  late double sleepHours;
  late PlanModel customPlan;

  CustomDataModel({
    required this.customPlan,
    required this.calories,
    required this.dietPlan,
    required this.water,
    required this.sleepHours,
  });

  CustomDataModel.fromJson(Map<String,dynamic>?json,{data}){
    calories=json!['calories'];
    dietPlan=json['dietPlan'];
    water=json['water'];
    sleepHours=json['sleepHours'];
    customPlan=PlanModel.fromJson(json['customPlan']);

  }
  Map<String,dynamic> toMap() {
    return{
      'customPlan': customPlan,
      'calories':calories,
      'dietPlan':dietPlan,
      'water':water,
      'sleepHours':sleepHours,
    };
  }
}