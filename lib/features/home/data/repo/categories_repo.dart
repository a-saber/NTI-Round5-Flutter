import 'package:dartz/dartz.dart';
import 'package:nti5/core/network/api_helper.dart';
import 'package:nti5/core/network/api_response.dart';
import 'package:nti5/core/network/end_points.dart';
import 'package:nti5/features/home/data/models/categories_response_model.dart';

class CategoriesRepo {
  APIHelper apiHelper = APIHelper();
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      var response = await apiHelper.getRequest(
          endPoint: EndPoints.categories
      );

      if(response.status){
        var categoriesResponse = CategoriesResponseModel.fromJson(response.data as Map<String, dynamic>);
        return right(categoriesResponse.categories!);
      }
      else{
        return left(response.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }
}
