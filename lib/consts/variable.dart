import 'package:google_fonts/google_fonts.dart';

var font = GoogleFonts.mada();
late double screenHeight;
late double screenWidth;
String? uid;

List<String> muscles=['body','shoulder','chest','arms','back','abdominal','legs'];
List<String> genders = ['ذكر', 'أنثى'];
List<String> fitnessLevels = ['كسول','نشيط','رياضي'];
List<String> workOutGoals= ['فقدان الوزن', 'بناء العضلات', 'حافظ على لياقتك'];
List<String> images=['man','woman'];
List<String> userHiMessage=['صباح الخير','مساء الخير'];
List<String> trainingHiMessage =['ابدأ تمرينك الأن','استمر لقد بدأت للتو','اقتريت من إنهاء هدفك اليوم','أحسنت لقد انهيت تمارينك اليوم'];
String serverPath = 'https://firebasestorage.googleapis.com/v0/b/echo-verse-de5dc.appspot.com/o/exercises';
