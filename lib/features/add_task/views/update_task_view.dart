import 'package:flutter/material.dart';
import 'package:nti5/features/home/data/models/task_model.dart';

class UpdateTaskView extends StatefulWidget {
  const UpdateTaskView({super.key, required this.taskModel});
  final TaskModel taskModel;
  @override
  State<UpdateTaskView> createState() => _UpdateTaskViewState();
}

class _UpdateTaskViewState extends State<UpdateTaskView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
