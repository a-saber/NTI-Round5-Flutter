import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti5/features/auth/cubits/register/register_state.dart';

import '../../data/repo/auth_repo.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit(): super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  AuthRepo repo = AuthRepo();
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  String? imagePath;
  bool passwordSecure = true;

  void changePasswordVisibility(){
    passwordSecure = !passwordSecure;
    emit(ChangePasswordVisibility());
  }

  register() async{
    if(formKey.currentState?.validate() == false) return;
    emit(RegisterLoading());
    var result = await repo.register(
      username: emailController.text,
      password: passwordController.text,
      imagePath: imagePath
    );
    result.fold(
        (errorMsg)=> emit(RegisterError(errorMsg)),
        (successMsg)=> emit(RegisterSuccess(successMsg))
    );


  }
}