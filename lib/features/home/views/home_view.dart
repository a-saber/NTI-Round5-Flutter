import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti5/core/cache/cache_helper.dart';
import 'package:nti5/core/cache/cache_keys.dart';
import 'package:nti5/core/network/api_helper.dart';
import 'package:nti5/core/utils/app_colors.dart';
import 'package:nti5/features/auth/data/models/user_model.dart';
import 'package:nti5/features/auth/views/login_view.dart';
import 'package:nti5/features/home/data/models/task_model.dart';

import 'widgets/task_item_builder.dart';


class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;
  List<Widget> screens = [
    HomeView(),
    ProfileView(),
    WeatherView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      // body: screens[currentIndex],
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primary,
        // backgroundColor: Colors.transparent,
        // elevation: 0,
        currentIndex: currentIndex,
          onTap: (int index){
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.sunny), label: 'Weather'),
          ]
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
    );
  }
}
class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
    );
  }
}



class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = false;
  List<TaskModel> tasks=  [];
  late UserModel userModel;
  @override
  void initState() {
    getUserData().then((v)=> getTasks());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isLoading ? null : AppBar(
        title: Text(userModel.username??''),
        actions: [
          IconButton(onPressed: ()async{
            await CacheHelper.removeValue(CacheKeys.accessToken);
            await CacheHelper.removeValue(CacheKeys.refreshToken);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginView()), (r)=> false);
            
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: isLoading ?
      const Center(child: CircularProgressIndicator(),) :
      ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index)=> TaskItemBuilder(task: tasks[index])),
    );
  }

  getTasks() async {
    var result = await APIHelper.getTasks();
    isLoading = false;
    result.fold(
        (error)=>  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error, style: TextStyle(color: AppColors.white),),
          backgroundColor: AppColors.error,
        )),
        (t) => setState(() {
          tasks = t;
        })
    );
  }

  Future getUserData() async{
    isLoading = true;
    var result = await APIHelper.getUserData();
    result.fold(
      (error)=>  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error, style: TextStyle(color: AppColors.white),),
        backgroundColor: AppColors.error,
        )),
        (userModel)=> setState(() {
          this.userModel = userModel;
        })
    );
  }

}
