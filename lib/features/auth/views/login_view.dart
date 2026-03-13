import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final formKey = GlobalKey<FormState>();
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
            child: Column(
              children:
              [
                TextFormField(
                  validator: (String? value){
                    //RegEx
                    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    bool result = emailRegex.hasMatch(value??'');
                    return result? null: 'Enter Valid Email';

                    // if(value == null || value.isEmpty == true){
                    //   return 'This field is required';
                    // }
                    // else if(value.contains('@') == false){
                    //   return 'Enter Valid Email';
                    // }
                    // else {
                    //   return null;
                    // }
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                TextFormField(
                  validator: (String? value){
                    if(value == null || value.isEmpty == true){
                      return 'This field is required';
                    }
                    else if(value.length < 6){
                      return 'Password must be at least 6 characters';
                    }
                    else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Password'
                  ),
                ),

                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  // validate form
                  bool? result = formKey.currentState?.validate();
                  print(result);
                  if(result == true){
                    // TODO Login API
                  }
                }, child: Text('login'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
