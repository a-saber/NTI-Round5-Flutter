import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti5/core/network/api_helper.dart';
import 'package:nti5/core/utils/app_colors.dart';
import 'package:nti5/features/auth/data/models/login_response_model.dart';
import 'package:nti5/features/auth/data/models/user_model.dart';
import 'package:nti5/features/home/views/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}
class LoginViewState extends State<LoginView>{
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  bool passwordSecure = true;

  bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children:
                [
                  TextFormField(
                    controller: emailController,
                    validator: (String? value){
                      //RegEx
                      // RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      // bool result = emailRegex.hasMatch(value??'');
                      // return result? null: 'Enter Valid Email';

                      if(value == null || value.isEmpty == true){
                        return 'This field is required';
                      }
                      else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    onFieldSubmitted: (value){
                      print('onFieldSubmitted $value');
                    },

                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    // onChanged: (value){
                    //   print('onChanged $value');
                    //   // formKey.currentState?.validate();
                    // },
                    validator: (String? value){
                      // regex
                      RegExp passwordRegex = RegExp(r'^[\w]{6,}$');
                      bool result = passwordRegex.hasMatch(value??'');
                      return result? null: 'Password must contain A-Z, a-z, 0-9 and at least 6 characters';
                      // if(value == null || value.isEmpty == true){
                      //   return 'This field is required';
                      // }
                      // else if(value.length < 6){
                      //   return 'Password must be at least 6 characters';
                      // }
                      // else {
                      //   return null;
                      // }
                    },
                    obscureText: passwordSecure,
                    // obscuringCharacter: '*',
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: (){
                            passwordSecure = !passwordSecure;
                            setState(() {

                            });
                            print(passwordSecure);
                          }, icon: Icon(Icons.remove_red_eye_outlined)),
                        hintText: 'Password'
                    ),
                  ),

                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: login, child: Text('login')),
                  SizedBox(height: 20,),
                  if(isLoading)
                    CircularProgressIndicator(color: AppColors.primary,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void login() async{
    if(formKey.currentState?.validate() == true){
      setState(() {
        isLoading = true;
      });
      var result = await APIHelper.login(username: emailController.text, password: passwordController.text);
      result.fold(
          (String error){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(error, style: TextStyle(color: AppColors.white),),
              backgroundColor: AppColors.error,
            ));
          },
          (UserModel userModel){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Login successfully\n Welcome ${userModel.username}', style: TextStyle(color: AppColors.white),),
              backgroundColor: AppColors.primary,
            ));
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context)=> HomeView(userModel: userModel,)),
                (r)=> false
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    }
  }
}
