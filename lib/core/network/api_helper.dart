import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class APIHelper{
  static final _dio = Dio( BaseOptions(
      baseUrl: 'https://ntitodo-production-779a.up.railway.app/api/'
  ));

  static Future<Either<String, Map<String, dynamic>>> login({
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
      var successResponse = loginResponse.data as Map<String, dynamic>;
      return Right(successResponse);
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

}