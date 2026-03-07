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
      home: ProfileTask(),
    );
  }
}

class ProfileTask extends StatelessWidget {
  const ProfileTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: Icon(Icons.arrow_back_ios_new, color: Colors.blue,),
        title: Text('Profile', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          Icon(Icons.settings, color: Colors.blue)
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children:
            [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  image: DecorationImage(
                      image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/9/91/Pizza-3007395.jpg'),
                    fit: BoxFit.cover
                  )
                ),
              ),
              SizedBox(height: 20,),
              Text('Ahmed Saber', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 25
              ),),
              SizedBox(height: 5,),
              Text('Active since 2 days', style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                  fontSize: 15
              ),),
              SizedBox(height: 5,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                onPressed: (){
                  print('Button pressed');
                },
                child: Text('BTN 1')
              ),
              SizedBox(height: 5,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Info')
              ),
              SizedBox(height: 5,),
              CustomInfoSection(
                icon: Icons.email,
                title: 'Email',
                value: 'gHv0g@example.com',
              ),
              SizedBox(height: 5,),
              CustomInfoSection(
                icon: Icons.phone,
                title: 'Phone',
                value: '0123456789',
              ),
              SizedBox(height: 5,),
              CustomInfoSection(
                icon: Icons.location_on_outlined,
                title: 'Location',
                value: 'Egypt',
              ),

          
            ],
          ),
        ),
      ),
    );
  }
}
class CustomInfoSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const CustomInfoSection({super.key,
    required this.icon,
    required this.title,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)
          )
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children:
        [
          Icon(icon, size: 30, color: Colors.white,),
          SizedBox(width: 10,),
          Text(title, style: TextStyle(color: Colors.white),),
          Spacer(),
          Text(value)
        ],
      ),
    );
  }
}



class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi'),
        actions: [
          Icon(Icons.check)
        ],
      ),
      body: Column(
        children:
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
            [
              DefaultCircle(),
              DefaultCircle(),
              DefaultCircle(),
            ],
          ),
          SizedBox(height: 100,),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey,
              )
            ),
            child: Row(
              children:
              [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue,
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: 
                  [
                    Text('Hi'),
                    Text('Ahmed'),
                  ],
                ),
                Spacer(),
                Icon(Icons.check)
              ],
            ),
          )
        ],
      ),
    );
  }
}
class DefaultCircle extends StatelessWidget {
  const DefaultCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle
      ),
      child: Center(child: Text('A')),
    );
  }
}


class Test01 extends StatelessWidget{
  const Test01({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
