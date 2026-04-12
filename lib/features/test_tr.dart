import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nti5/features/auth/views/login_view.dart';
import 'package:nti5/features/auth/views/register_view.dart';

import '../core/translation/translation_keys.dart';

class TestTr extends StatelessWidget {
  const TestTr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationKeys.hello.tr),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          TextButton(onPressed: (){
            Get.updateLocale(Locale('ar'));

            }, child: Text('To AR')
          ),
          TextButton(onPressed: (){
            Get.updateLocale(Locale('en'));
            },
            child: Text('To EN')
          ),

          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (contex)=> LoginView()));
            },
            child: Text('To Login')
          ),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (contex)=> RegisterView()));
            },
            child: Text('To Register')
          ),



        ],
      ),
    );
  }
}
