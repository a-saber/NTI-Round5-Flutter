import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti5/core/utils/app_colors.dart';

class TaskItemBuilder extends StatelessWidget {
  const TaskItemBuilder({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.primaryLight,
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            blurRadius: 4.r,
            spreadRadius: 0,
            color: AppColors.black2.withAlpha(60)
          )
        ]
      ),
      padding: REdgeInsets.symmetric(
        horizontal: 12,
        vertical: 13
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                style: TextStyle(
                  color: AppColors.hint,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp
                ),),
                SizedBox(height: 13.h,),
                Text('Improve my English skills by trying to speek',
                  style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp
                  ),),
              ],
            ),
          ),
          SizedBox(width: 20.w,),
          Text('11/03/2025\n05:00 PM',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.hint,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp
            ),),
        ],
      ),
    );
  }
}
