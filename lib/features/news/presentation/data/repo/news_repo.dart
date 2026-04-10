import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nti5/core/network/api_helper.dart';
import 'package:nti5/features/news/presentation/data/models/news_model.dart';

class NewsRepo{
  Future<Either<String, List<ArticleModel>>> fetchNews()async{
    try {
      var response = await NewsAPIHelper.dio.get(
        'everything',
        queryParameters: {
          'q': 's',
          'apiKey': '836086f05b344448a16dd41ee51c6320'
        }
         );

      var result = FetchNewsResponseModel.fromJson(response.data as Map<String, dynamic>);
      if(result.status == 'ok'){
        return right(result.articles ?? []);
      }
      return left('Something went wrong');
    } catch (e) {
      if (e is DioException) {
        var errorResponse = e.response?.data as Map<String, dynamic>;
        return Left(errorResponse['message'] ?? 'Unknown error');
      } else {
        print(e.toString());
        return Left('An Error occurred.\nTry again later');
      }
    }

  }


}
