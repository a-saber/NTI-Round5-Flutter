import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nti5/core/network/api_helper.dart';
import 'package:nti5/core/utils/app_assets.dart';
import 'package:nti5/core/utils/app_colors.dart';
import 'package:nti5/core/widgets/custom_btn.dart';
import 'package:nti5/core/widgets/custom_text_field.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final title = TextEditingController();
  final desc = TextEditingController();
  final formKey = GlobalKey<FormState>();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        title: Text('Add Task'),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children:
              [
                SizedBox(height: 45.h,),
                GestureDetector(
                  onTap: pickImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Builder(
                      builder: (context) {
                        if(image == null){
                          return Image.asset(AppAssets.flag,
                            height: 207.h,
                            width: 260.w,
                            fit: BoxFit.cover,
                          );
                        }
                        else{
                          return Image.file(
                            File(image!.path),
                            height: 207.h,
                            width: 260.w,
                            fit: BoxFit.cover,
                          );
                        }
                      }
                    ),
                  ),
                ),
                SizedBox(height: 30.h,),
                CustomTextField(
                  controller: title,
                  hint: 'Title',
                  validator: (String? value){
                    if(value == null || value.isEmpty == true){
                      return 'This field is required';
                    }
                    return null;
                  },

                ),
                SizedBox(height: 15.h,),
                CustomTextField(
                  controller: desc,
                  hint: 'Description',
                ),
                SizedBox(height: 15.h,),
                CustomBTN(text: 'Add Task', onPressed: onAddTaskPressed)

              ],
            ),
          ),
        ),
      ),
    );
  }
  onAddTaskPressed() async{
    if(formKey.currentState?.validate() == true){
      var result = await APIHelper.addTask(
        title: title.text,
        description: desc.text,
        image: image
      );
      result.fold(
          (errorMsg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errorMsg, style: TextStyle(color: AppColors.white),),
            backgroundColor: AppColors.error,
          )),
          (successMsg){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(successMsg, style: TextStyle(color: AppColors.white),),
              backgroundColor: AppColors.primary,
            ));
            Navigator.pop(context);
          }
      );
    }
  }

  pickImage ()async{
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {

    });
  }
}
