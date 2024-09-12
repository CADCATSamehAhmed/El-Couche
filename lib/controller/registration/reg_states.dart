abstract class RegStates {}

class RegInitialState extends RegStates {}

//create account
class SignupLoadingState extends RegStates {}
class SignupSuccessState extends RegStates {}
class SignupErrorState extends RegStates {}

class CreateAccountLoadingState extends RegStates {}
class CreateAccountSuccessState extends RegStates {}
class CreateAccountErrorState extends RegStates {}
class ErrorWeakPasswordState extends RegStates {}
class ErrorEmailAlreadyInUseState extends RegStates {}

//login
class LoginLoadingState extends RegStates {}
class LoginSuccessState extends RegStates {}
class LoginErrorState extends RegStates {
  final String error;
  LoginErrorState(this.error);
}
class ErrorWrongPasswordState extends RegStates {}
class ErrorUserNotFoundState extends RegStates {}
//resetPassword
class RestPasswordLoadingState extends RegStates {}
class RestPasswordSuccessState extends RegStates {}
class RestPasswordErrorState extends RegStates {}
class ErrorInvalidEmailState extends RegStates {}
//show loading
class ShowLoadingDialogState extends RegStates {}

class TabOnFormFieldState extends RegStates {}
class ChangePasswordVisibleState extends RegStates {}

