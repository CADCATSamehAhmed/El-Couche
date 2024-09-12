String getAppModeS (int mode)  {
  switch(mode){
    case 0:
      return "النظام";
    case 1:
      return "الساطع";
    case 2:
      return "المظلم";
    default:
      return "النظام";
  }
}
String getAppLanguageS (String s)  {
  switch(s){
    case 'ar':
      return "العربية";
    case 'en':
      return "الأنجليزية";
    default:
      return "العربية";
  }
}

String getTodayExerciseName(String t){
  if(t == 'push1' || t == 'push2'){
    return 'النهاردة عندك تمرينة صدر وتراي';
  }
  else if(t == 'pull1' || t == 'pull2'){
    return 'هتلعب النهاردة ظهر وباي ياوحش';
  }
  else if(t == 'push2'){
    return 'النهاردة هتتمرن صدر وتراي يابطل';
  }
  else if(t == 'pull2'){
    return 'عندك النهاردة ظهر وباي ياكوتش';
  }
  else if(t == 'legs'){
    return 'عندك تمرينة رجلين النهاردة';
  }
  else{
    return "ابسط ياعم النهاردة راحة";
 }
}