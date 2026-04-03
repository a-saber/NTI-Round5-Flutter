import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti5/features/home/data/models/task_model.dart';

import '../../../core/network/api_helper.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_btn.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/image_manager.dart';

class UpdateTaskView extends StatefulWidget {
  const UpdateTaskView({super.key, required this.taskModel});
  final TaskModel taskModel;
  @override
  State<UpdateTaskView> createState() => _UpdateTaskViewState();
}

class _UpdateTaskViewState extends State<UpdateTaskView> {
  final title = TextEditingController();
  final desc = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? imagePath;

  @override
  void initState() {
    super.initState();
    title.text = widget.taskModel.title??'';
    desc.text = widget.taskModel.description??'';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        title: Text('Update Task'),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: ImageManager(
                      unselectedImageBuilder: Image.asset(AppAssets.flag,
                        height: 207.h,
                        width: 260.w,
                        fit: BoxFit.cover,
                      ),
                      networkImageBuilder: widget.taskModel.imagePath ==null?
                      null:
                      Image.network(widget.taskModel.imagePath!,
                        height: 207.h,
                        width: 260.w,
                        fit: BoxFit.cover,
                      ),
                      selectedImageBuilder: (String path){
                        imagePath = path;
                        return Image.file(
                          File(path),
                          height: 207.h,
                          width: 260.w,
                          fit: BoxFit.cover,
                        );
                      }
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
                CustomBTN(text: 'Update Task', onPressed: onUpdateTaskPressed)

              ],
            ),
          ),
        ),
      ),
    );
  }

  onUpdateTaskPressed() async{
    if(formKey.currentState?.validate() == true){
      var result = await APIHelper.updateTask(
        id: widget.taskModel.id??0,
          title: title.text,
          description: desc.text,
          imagePath: imagePath
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

}
