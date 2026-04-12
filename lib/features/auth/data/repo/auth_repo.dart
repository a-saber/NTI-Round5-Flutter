import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nti5/core/network/api_helper.dart';
import 'package:nti5/core/network/api_response.dart';
import 'package:nti5/core/network/end_points.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/cache/cache_keys.dart';
import '../models/login_response_model.dart';
import '../models/user_model.dart';

class AuthRepo{

  APIHelper apiHelper = APIHelper();
  Future<Either<String, UserModel>> login(
      {required String username, required String password}) async {
    try {
      var loginResponse = await apiHelper.postRequest(
        endPoint: EndPoints.login,
        data: {'username': username, 'password': password},
      );

      if(loginResponse.status){
        // serialization
        var loginResponseModel = LoginResponseModel.fromJson(
            loginResponse.data as Map<String, dynamic>
        );

        // save tokens
        await CacheHelper.setValue(
            CacheKeys.accessToken, loginResponseModel.accessToken!);
        await CacheHelper.setValue(
            CacheKeys.refreshToken, loginResponseModel.refreshToken!);

        return Right(loginResponseModel.userModel!);
      }
      else{
        return left(loginResponse.message);
      }


    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }
}