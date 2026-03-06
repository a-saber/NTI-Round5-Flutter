import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // design 1st screen
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          leading: Icon(Icons.add),
          title: Text('Welcome'),
          actions: [
            Icon(Icons.search),
            Icon(Icons.check),
            Text('Btn')
          ],
        ),
        body: Container(
          color: Colors.blue,
          child: SizedBox(
            height: double.infinity,
            child: Row(
              children: [
              Text(
                  'Hello World 1',
                  style: TextStyle(
                    fontSize: 15.5,
                    color: Colors.pink,
                    fontWeight: FontWeight.w900
                  ),
                ),
                Text(
                  'Hello World 2',
                  style: TextStyle(
                    fontSize: 15.5,
                    color: Colors.pink,
                    fontWeight: FontWeight.w900
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
