import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserModel {
  String? name;
  String? email;
  String? phone;
  int id;

  UserModel({ required this.id,  this.name, this.email, this.phone});
}
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}
class LoginViewState extends State<LoginView>{
  final formKey = GlobalKey<FormState>();

  final dateController = TextEditingController();

  final passwordController = TextEditingController();

  bool passwordSecure = true;

  List<String> cities = [
    'Cairo',
    'Alex',
    'Giza',
    'Ismailia'
  ];

  List<UserModel> users = [
    UserModel(id:1, name: 'Ahmed', email: 'T6b6y@example.com', phone: '01011111111'),
    UserModel(id:2,name: 'Saber', email: 'saber@eg.com', phone: '01216545645'),
    UserModel(id:3,name: 'Ali', email: 'nti@example.com', phone: '1635848335'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children:
              [
                TextFormField(
                  validator: (String? value){
                    //RegEx
                    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    bool result = emailRegex.hasMatch(value??'');
                    return result? null: 'Enter Valid Email';

                    // if(value == null || value.isEmpty == true){
                    //   return 'This field is required';
                    // }
                    // else if(value.contains('@') == false){
                    //   return 'Enter Valid Email';
                    // }
                    // else {
                    //   return null;
                    // }
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  onFieldSubmitted: (value){
                    print('onFieldSubmitted $value');
                  },

                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // onChanged: (value){
                  //   print('onChanged $value');
                  //   // formKey.currentState?.validate();
                  // },
                  validator: (String? value){
                    // regex
                    RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
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
                  obscureText: passwordSecure,
                  // obscuringCharacter: '*',
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: (){
                          passwordSecure = !passwordSecure;
                          setState(() {

                          });
                          print(passwordSecure);
                        }, icon: Icon(Icons.remove_red_eye_outlined)),
                      hintText: 'Password'
                  ),
                ),
                TextFormField(
                  controller: dateController,
                  // enabled: false,
                  readOnly: true,
                  onTap: ()async{
                    print('tapped');

                    DateTime? dateTime = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 30))
                    );
                    if(dateTime != null){
                      dateController.text = dateTime.toString();
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // onChanged: (value){
                  //   print('onChanged $value');
                  //   // formKey.currentState?.validate();
                  // },
                  validator: (String? value){

                    if(value == null || value.isEmpty == true){
                      return 'This field is required';
                    }
                    // else if(value.length < 6){
                    //   return 'Password must be at least 6 characters';
                    // }
                    else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Data'
                  ),
                ),

                DropdownButtonFormField<String>(
                  items: cities.map<DropdownMenuItem<String>>(
                      (String value)=> DropdownMenuItem(value: value,child: Row(
                        children: [
                          Icon(Icons.location_city),
                          SizedBox(width: 10,),
                          Text(value),
                        ],
                      ),)
                  ).toList(),
                  // [
                  //   for(int i = 0; i < cities.length; i++)
                  //   DropdownMenuItem(value: cities[i],child: Text(cities[i]),),
                  // ],
                  onChanged: (value){
                    print('new Value $value');
                  }
                ),

                SizedBox(height: 20,),
                DropdownButtonFormField<int>(
                  items: users.map(
                      (userModel)=> DropdownMenuItem(value: userModel.id,
                          child: Row(
                            children:
                            [
                              Icon(Icons.person),
                              SizedBox(width: 10,),
                              Text(userModel.email??''),
                            ],
                          ))
                  ).toList(),
                  onChanged: (userModelId){
                    print('Selected User : ${userModelId}');
                  },

                  decoration: InputDecoration(
                    hintText: 'Select User',
                  ),
                ),



                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  // validate form
                  bool? result = formKey.currentState?.validate();
                  print(result);
                  if(result == true){
                    // TODO Login API
                  }
                }, child: Text('login'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
