import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// states
abstract class TestState{}
class InitState extends TestState{}
class CheckBoxChangeState extends TestState{}
class SwitchChangeState extends TestState{}
class ButtonPressedState extends TestState{}
class DecorationChangedState extends TestState{}

// cubit
class TestCubit extends Cubit<TestState>{
  TestCubit(): super(InitState());
  static TestCubit get(context) => BlocProvider.of(context);

  bool checkBox = true;
  bool switchValue = true;

  bool isLoading = false;

  Color color = Colors.red;
  BoxShape shape = BoxShape.circle;

  onDecorationChanged({
    required Color color,
    required BoxShape shape
}){
    this.color = color;
    this.shape = shape;
    emit(DecorationChangedState());
  }


  onButtonPressed(){
    isLoading = !isLoading;
    emit(ButtonPressedState());
  }

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
                AnimatedContainer(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: TestCubit.get(context).color,
                    shape: TestCubit.get(context).shape
                  ),
                  duration: Duration(milliseconds: 500),
                ),
                ElevatedButton(
                    onPressed: ()=> TestCubit.get(context).onDecorationChanged(color: Colors.black, shape: BoxShape.rectangle),
                    child: Text('Change Decoration to rectangle')
                ),
                ElevatedButton(
                    onPressed: ()=> TestCubit.get(context).onDecorationChanged(color: Colors.red, shape: BoxShape.circle),
                    child: Text('Change Decoration to Circle')
                ),
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
                ),
                ElevatedButton(
                  onPressed: TestCubit.get(context).onButtonPressed,
                  child: Text('Load')
                ),

                if(TestCubit.get(context).isLoading)
                  CircularProgressIndicator(),


              ],
            );
          }
        ),
      ),
    );
  }
}

