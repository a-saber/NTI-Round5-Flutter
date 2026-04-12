abstract class RegisterState{}

class RegisterInitial extends RegisterState{}

class RegisterLoading extends RegisterState{}

class RegisterSuccess extends RegisterState{
  String message;
  RegisterSuccess(this.message);
}

class RegisterError extends RegisterState{
  String error;
  RegisterError(this.error);
}
class ChangePasswordVisibility extends RegisterState{}