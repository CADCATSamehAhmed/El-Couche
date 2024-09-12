abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeChangeNavBarIndexState extends HomeStates {}

//get user
class GetUserLoadingState extends HomeStates {}
class GetUserSuccessState extends HomeStates {}
class GetUserErrorState extends HomeStates {
  final String error;
  GetUserErrorState(this.error);
}
//get exercise
class GetTodayExercisesLoadingState extends HomeStates {}
class GetTodayExercisesSuccessState extends HomeStates {}
class GetTodayExercisesErrorState extends HomeStates {
  final String error;
  GetTodayExercisesErrorState(this.error);
}
class GoToExerciseState extends HomeStates {}
class GoToNextExerciseState extends HomeStates {}
class BackToPreviousExerciseState extends HomeStates {}
class IncreaseTodayExercisesDoneState extends HomeStates {}

class TimerState  extends HomeStates {
  final int remainingTime; // Time remaining in seconds
  TimerState({required this.remainingTime});
}

//pick image
class PickImageSuccessState extends HomeStates {}
class PickImageErrorState extends HomeStates {}
//upload image
class UpdateImageLoadingState extends HomeStates {}
class UpdateImageSuccessState extends HomeStates {}
class UpdateImageErrorState extends HomeStates {
  final String error;
  UpdateImageErrorState(this.error);
}

//upload user Data
class ChangeUserDataLoadingState extends HomeStates {}

class UpdateUserDataLoadingState extends HomeStates {}
class UpdateUserDataSuccessState extends HomeStates {}
class UpdateUserDataErrorState extends HomeStates {
  final String error;
  UpdateUserDataErrorState(this.error);
}

class AppChangModeState extends HomeStates {}
class AppCurrentChangModeState extends HomeStates {}
class AppToggleNotificationsState extends HomeStates {}
class AppChangeLanguageState extends HomeStates {}


