import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nti5/core/cache/cache_helper.dart';
import 'package:nti5/core/cache/cache_keys.dart';
import 'package:nti5/features/auth/data/models/user_model.dart';
import 'package:nti5/features/home/data/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/models/login_response_model.dart';

abstract class APIHelper{
  static final _dio = Dio( BaseOptions(
      baseUrl: 'https://ntitodo-production-779a.up.railway.app/api/'
  ));

  static Future<Either<String, UserModel>> login({
    required String username,
    required String password
}) async{


    try{
      var loginResponse = await _dio.post(
          'login',
          data: FormData.fromMap({
            'username': username,
            'password': password
          })
      );
      // serialization
      var loginResponseModel = LoginResponseModel.fromJson(loginResponse.data as Map<String, dynamic>);

      // save tokens
      await CacheHelper.setValue(CacheKeys.accessToken, loginResponseModel.accessToken!);
      await CacheHelper.setValue(CacheKeys.refreshToken, loginResponseModel.refreshToken!);

      return Right(loginResponseModel.userModel!);
    }
    catch(e){
      if(e is DioException){
        var errorResponse = e.response?.data as Map<String, dynamic>;
        return Left(errorResponse['message']?? 'Unknown error');
      }
      else{
        return Left('An Error occurred.\nTry again later');
      }
    }
  }

  static Future<Either<String,List<TaskModel>>> getTasks()async
  {
    try{
      var registerResponse = await _dio.get(
          'my_tasks',
          options: Options(
              headers: {
                'Authorization': 'Bearer ${await CacheHelper.getValue(CacheKeys.accessToken)}'
              }
          )
      );
      var tasksResponse = registerResponse.data as Map<String, dynamic>;
      List<TaskModel> tasks = [];
      for(var taskJson in tasksResponse['tasks']){
        tasks.add(TaskModel.fromJson(taskJson));
      }
      return Right(tasks);
    }
    catch(e){
      if(e is DioException){
        var errorResponse = e.response?.data as Map<String, dynamic>;
        return Left(errorResponse['message']?? 'Unknown error');
      }
      else{
        print(e.toString());
        return Left('An Error occurred.\nTry again later');
      }
    }
  }

}