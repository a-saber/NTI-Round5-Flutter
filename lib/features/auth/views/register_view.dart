import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nti5/core/widgets/image_manager.dart';
import 'package:nti5/features/auth/cubits/register/register_cubit.dart';
import 'package:nti5/features/auth/cubits/register/register_state.dart';
import 'package:nti5/features/auth/views/login_view.dart';

import '../../../core/translation/translation_keys.dart';
import '../../../core/utils/app_colors.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> RegisterCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(TranslationKeys.register.tr),
        ),
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state){
            if(state is RegisterError){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error, style: TextStyle(color: AppColors.white),),
                backgroundColor: AppColors.error,
              ));
            }
            else if(state is RegisterSuccess){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Register successfully', style: TextStyle(color: AppColors.white),),
                backgroundColor: AppColors.primary,
              ));
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context)=> LoginView()),
                      (r)=> false
              );
            }
          },
          builder: (context, state){
            var cubit = RegisterCubit.get(context);
            return SafeArea(
              child: Padding(
                padding: REdgeInsets.all(20.0),
                child: Form(
                  key: cubit.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children:
                      [

                        ImageManager(
                          unselectedImageBuilder: Icon(Icons.image, size: 50,),
                          onImageSelected: (path)=> cubit.imagePath = path,
                          selectedImageBuilder: (String imagePath){
                            return SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.file(File(imagePath), fit: BoxFit.contain,)
                            );
                          }
                        ),
                        SizedBox(height: 40,),

                        TextFormField(
                          controller: cubit.emailController,
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
                          controller: cubit.passwordController,
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
                          obscureText: cubit.passwordSecure,
                          // obscuringCharacter: '*',
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: cubit.changePasswordVisibility,
                                  icon: Icon(Icons.remove_red_eye_outlined)
                              ),
                              hintText: 'Password'
                          ),
                        ),

                        SizedBox(height: 20,),

                        ElevatedButton(
                          onPressed: state is RegisterLoading?
                          null: cubit.register,
                            child: Text(TranslationKeys.register.tr),
                        ),
                        SizedBox(height: 20,),
                        if(state is RegisterLoading)
                          CircularProgressIndicator(color: AppColors.primary,)
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      )
    );
  }
}
