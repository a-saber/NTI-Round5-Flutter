import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti5/features/news/presentation/manager/news_tasks/news_cubit.dart';
import 'package:nti5/features/news/presentation/manager/news_tasks/news_state.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> NewsCubit()..fetchNews(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('News'),
        ),
        body: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state){
            if(state is NewsSuccessState){
              // view tasks
              return ListView.separated(
                itemBuilder: (context, index)=> Text(NewsCubit.get(context).articles[index].title??''),
                  separatorBuilder: (context , index)=> SizedBox(height: 20,),
                  itemCount: NewsCubit.get(context).articles.length??0
              );
            }
            else if(state is NewsLoadingState){
              return CircularProgressIndicator();
            }
            else if(state is NewsErrorState){
              return Text(NewsCubit.get(context).errorMessage ??'Error');
            }
            else{
              return SizedBox();
            }
          }
        ),
      ),
    );
  }
}
