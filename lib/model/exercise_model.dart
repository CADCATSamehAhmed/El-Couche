class ExerciseModel {
  late int id;
  late String title;
  late String gifImage;
  late int exerciseRep;
  ExerciseModel({
    required this.id,
    required this.title,
    required this.gifImage,
    required this.exerciseRep,
  });
  ExerciseModel.fromJson(Map<String,dynamic>?json,{data}){
    id=json!['id'];
    title=json['title'];
    gifImage=json['gifImage'];
    exerciseRep=json['exerciseRep'];
  }
  Map<String,dynamic> toMap() {
    return{
      'id': id,
      'title': title,
      'gifImage':gifImage,
      'exerciseRep':exerciseRep,
    };
  }
}

class WorkOutListModel {
  late int id;
  late String title;
  late String image;
  late String level;
  late List<ExerciseModel> list;

  WorkOutListModel({
    required this.id,
    required this.title,
    required this.image,
    required this.level,
    required this.list,
  });

}