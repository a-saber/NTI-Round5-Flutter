import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nti5/core/utils/app_assets.dart';

import '../utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, this.prefixIconPath});
  final String? prefixIconPath;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          color: AppColors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.w200
      ),
      decoration: InputDecoration(
        hintText: 'Name',
        hintStyle: TextStyle(
            color: AppColors.hint,
            fontSize: 14.sp,
            fontWeight: FontWeight.w100
        ),
        prefixIcon: prefixIconPath == null ? null : Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(prefixIconPath!,),
        ),
        contentPadding: REdgeInsets.symmetric(horizontal: 16, vertical: 22),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
                color: Color(0xffCDCDCD),
                width: 1
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
                color: Color(0xffCDCDCD),
                width: 1
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
                color: Colors.green,
                width: 1
            )
        ),

      ),
    );
  }
}
