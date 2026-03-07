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
          backgroundColor: Colors.white,
          leading: Icon(Icons.account_balance_wallet_rounded, color: Colors.grey,),
          title: Text('Welcome', style: TextStyle(color: Colors.black),),
          actions: [
            Icon(Icons.search),
            Icon(Icons.check),
            Text('Btn')
          ],
        ),
        body: Container(
          color: Colors.grey,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 50,),
              Container(
                height: 300,
                width: 100,
                // color: Colors.red,
                decoration: BoxDecoration(
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue,
                      Colors.red,
                      Colors.black,
                    ]
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 1),
                      offset: Offset(10, 0),
                      spreadRadius: 3,
                      blurRadius: 10
                    ),
                    BoxShadow(
                      color: Colors.red,
                      offset: Offset(-10, 0),
                      spreadRadius: 3,
                      blurRadius: 10
                    ),
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('data'),
                    Text('data'),
                  ],
                ),
              ),
              // Spacer(),
              SizedBox(height: 50,),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('data'),
                      Text('data'),
                    ],
                  ),
                ),
              ),


            ],
          )
        )
      ),
    );
  }
}
