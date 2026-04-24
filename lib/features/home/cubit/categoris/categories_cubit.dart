import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti5/features/home/cubit/categoris/categories_state.dart';
import 'package:nti5/features/home/data/models/categories_response_model.dart';
import 'package:nti5/features/home/data/repo/categories_repo.dart';

class CategoriesCubit extends Cubit<CategoriesState>{

  CategoriesCubit(this.repo) : super(CategoriesInitial());
  final CategoriesRepo repo;
  static CategoriesCubit get(context) => BlocProvider.of(context);
  List<CategoryModel>? categories;

  int currentIndex = 0;
  onCategoryTapped(int newIndex){
    currentIndex = newIndex;
    emit(CategoriesIndexChanged());
  }
  void getCategories()async{
    emit(CategoriesLoading());
    var result = await repo.getCategories();
    result.fold(
      (error) => emit(CategoriesError(error: error)),
      (categories) {
        this.categories = categories;
        emit(CategoriesSuccess());
      }
    );
  }
}