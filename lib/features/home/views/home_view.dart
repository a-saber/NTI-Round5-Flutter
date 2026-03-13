import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti5/core/utils/app_colors.dart';

import 'widgets/task_item_builder.dart';

class UsersCardsBuilder extends StatelessWidget {
  const UsersCardsBuilder({super.key, required this.userName});
  final String userName;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.primaryLight,
        child: Text(userName),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> users= [
      'Ahmed',
      'Saber',
      'Mo',
      'Mo',
      'Mo',
      'Mo',
      'Mo',
      'Mo',
      'Mo',
      'Mo',
      'Mo',
      'Mo',
    ];
    List<String> tasks = [
      'Task 1',
      'Task 2',
      'Task 3',
      'Task 3',
      'Task 3',
      'Task 3',
      'Task 3',
      'Task 3',
      'Task 3',
      'Task 3',
      'Task 3',
      'Task 3',
      'Task 3',
      'Task 3',
      'Task 3',
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children:
              [
                SizedBox(height: 20,),

                // row scrollable
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: users.length,
                    itemBuilder: (context, index)=> UsersCardsBuilder(userName: users[index],)
                  )
                ),
                SizedBox(height: 20.h,),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index)=> TaskItemBuilder(title: tasks[index],),
                  itemCount: tasks.length,
                ),

                Container(
                  height: 500,
                  width: 200,
                  color: Colors.red,
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
