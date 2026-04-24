import '../../data/models/categories_response_model.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesIndexChanged extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  // List<CategoryModel> categories;
  // CategoriesSuccess({required this.categories});
}

class CategoriesError extends CategoriesState {
  String error;
  CategoriesError({required this.error});
}