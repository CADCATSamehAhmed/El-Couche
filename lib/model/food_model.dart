class FoodModel {
  late String title;
  late String image;
  late String description;
  late int calories;

  FoodModel({
    required this.title,
    required this.image,
    required this.description,
    required this.calories,
  });

  FoodModel.fromJson(Map<String,dynamic>?json,{data}){
    title=json!['title'];
    image=json['image'];
    description=json['description'];
    calories=json['calories'];
  }
  Map<String,dynamic> toMap() {
    return{
      'title': title,
      'image':image,
      'description':description,
      'calories':calories,
    };
  }
}