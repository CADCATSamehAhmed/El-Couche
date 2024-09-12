class UserModel {
  late String uid;
  late String fullName;
  late String email;
  late String phone;
  late String image;
  late WorkOutPreference workOutPreference;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.image,
    required this.workOutPreference,
  });

  UserModel.fromJson(Map<String,dynamic>?json,{data})
  {
    uid=json!['uid'];
    fullName=json['fullName']??'dummy';
    email=json['email'];
    phone=json['phone']??'dummy';
    image=json['image'];
    workOutPreference = WorkOutPreference.fromJson(json['workOutPreference']);
  }
}

class WorkOutPreference {
  late String gender;
  late int startDay;
  late int age;
  late int height;
  late int weight;
  late int workOutDays;
  late int trainingRest;

  WorkOutPreference({
    required this.gender,
    required this.startDay,
    required this.age,
    required this.height,
    required this.weight,
    required this.workOutDays,
    required this.trainingRest,
  });

  WorkOutPreference.fromJson(Map<String,dynamic>?json,{data}){
    gender=json!['gender'];
    startDay=json['startDay'];
    age=json['age'];
    height=json['height'];
    weight=json['weight'];
    workOutDays=json['workOutDays'];
    trainingRest=json['trainingRest'];
  }
  Map<String,dynamic> toMap() {
    return{
      'gender': gender,
      'startDay': startDay,
      'age': age,
      'height': height,
      'weight': weight,
      'workOutDays': workOutDays,
      'trainingRest': trainingRest,
    };
  }
}