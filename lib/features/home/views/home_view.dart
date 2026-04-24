import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti5/core/cache/cache_helper.dart';
import 'package:nti5/core/cache/cache_keys.dart';
import 'package:nti5/core/network/api_helper.dart';
import 'package:nti5/core/utils/app_colors.dart';
import 'package:nti5/features/auth/data/models/user_model.dart';
import 'package:nti5/features/auth/views/login_view.dart';
import 'package:nti5/features/home/cubit/categoris/categories_cubit.dart';
import 'package:nti5/features/home/cubit/categoris/categories_state.dart';
import 'package:nti5/features/home/data/models/task_model.dart';
import 'package:nti5/features/home/data/repo/categories_repo.dart';

import '../../add_task/views/add_task_view.dart';
import 'widgets/task_item_builder.dart';
class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> CategoriesCubit(CategoriesRepo())..getCategories(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        ),
        body: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state){
            var cubit = CategoriesCubit.get(context);
            if(state is CategoriesLoading){
              return CircularProgressIndicator();
            }
            else if (state is CategoriesError){
              return Text(state.error);
            }
            else if(cubit.categories != null){
              return Column(
                children: [
                  // Horizontal List of Categories
                  SizedBox(
                    height: 150,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(20.0),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index)=> InkWell(
                        onTap: ()=> cubit.onCategoryTapped(index),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: cubit.currentIndex == index ? AppColors.primary : Colors.grey
                            )
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children:
                            [
                              Image.network(cubit.categories![index].imagePath??"",
                              height: 50,
                              width: 50,
                              ),
                              SizedBox(height: 10,),
                              Text(cubit.categories![index].title??'')

                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index)=> SizedBox(width: 10,),
                      itemCount: cubit.categories!.length
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                        padding: EdgeInsets.all(20),
                        itemBuilder: (context, index)=> Row(
                      children: [
                        Image.network(
                          cubit.categories![cubit.currentIndex].products![index].imagePath??'',
                        height: 100,
                        width: 100,
                        ),
                        SizedBox(width: 20,),
                        Text(cubit.categories![cubit.currentIndex].products![index].name??''),
                        Text(cubit.categories![cubit.currentIndex].products![index].price.toString()),


                      ],
                    ), separatorBuilder: (context, index)=> SizedBox(height: 20,),
                        itemCount: cubit.categories![cubit.currentIndex].products!.length
                    ),
                  )
                ],
              );
            }
            else {
              return Text('data');
            }
          }
        ),
      ));
  }
}


class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;
  List<Widget> screens = [
    CategoriesView(),
    HomeView(),
    // ProfileView(),
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
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.primary,
        onPressed: ()async{
          var result = await Navigator.push(context, MaterialPageRoute(builder: (_)=> AddTaskView()));
          if(result == true){
            // fetch tasks again
          }
        }, child: Icon(Icons.add, color: AppColors.white,),),
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
            BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            // BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
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
        // title: Text(userModel.username??''),
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
        padding: REdgeInsets.symmetric(horizontal: 20),
          itemCount: tasks.length,
          itemBuilder: (context, index)=> TaskItemBuilder(task: tasks[index])),
    );
  }

  getTasks() async {
    // var result = await APIHelper.getTasks();
    // isLoading = false;
    // result.fold(
    //     (error)=>  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text(error, style: TextStyle(color: AppColors.white),),
    //       backgroundColor: AppColors.error,
    //     )),
    //     (t) => setState(() {
    //       tasks = t;
    //     })
    // );
  }

  Future getUserData() async{
    // isLoading = true;
    // var result = await APIHelper.getUserData();
    // result.fold(
    //   (error)=>  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(error, style: TextStyle(color: AppColors.white),),
    //     backgroundColor: AppColors.error,
    //     )),
    //     (userModel)=> setState(() {
    //       this.userModel = userModel;
    //     })
    // );
  }

}
