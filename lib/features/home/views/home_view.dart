import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti5/core/utils/app_colors.dart';

import 'widgets/task_item_builder.dart';

class UsersCardsBuilder extends StatelessWidget {
  const UsersCardsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.primaryLight,
        child: Text('A'),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children:
              [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      UsersCardsBuilder(),
                      UsersCardsBuilder(),
                      UsersCardsBuilder(),
                      UsersCardsBuilder(),
                      UsersCardsBuilder(),
                      UsersCardsBuilder(),
                      UsersCardsBuilder(),
                      UsersCardsBuilder(),
                      UsersCardsBuilder(),
                      UsersCardsBuilder(),
                      UsersCardsBuilder(),
                      UsersCardsBuilder(),
                      UsersCardsBuilder(),
                      UsersCardsBuilder(),
                      UsersCardsBuilder(),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                TaskItemBuilder(),
                TaskItemBuilder(),
                TaskItemBuilder(),
                TaskItemBuilder(),
                TaskItemBuilder(),
                TaskItemBuilder(),
                TaskItemBuilder(),
                TaskItemBuilder(),
                TaskItemBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
