import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// states
abstract class TestState{}
class InitState extends TestState{}
class CheckBoxChangeState extends TestState{}
class SwitchChangeState extends TestState{}

// cubit
class TestCubit extends Cubit<TestState>{
  TestCubit(): super(InitState());
  static TestCubit get(context) => BlocProvider.of(context);

  bool checkBox = true;
  bool switchValue = true;

  onCheckBoxChanged(bool ?value){
    if(value != null){
      checkBox = value;
    }
    emit(CheckBoxChangeState());
  }

  onSwitchChanged(value){
    switchValue = value;
    emit(SwitchChangeState());
  }

}


class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TestCubit(),
      child: Scaffold(
        body: BlocBuilder<TestCubit, TestState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hello'),
                Center(
                  child: Checkbox(
                    value: TestCubit.get(context).checkBox,
                    onChanged: TestCubit.get(context).onCheckBoxChanged
                  ),
                ),
                Center(
                  child: Switch(
                    value: TestCubit.get(context).switchValue,
                    onChanged: TestCubit.get(context).onSwitchChanged
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}

