part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryFailed extends CategoryState {
  final String e;

  const CategoryFailed(this.e);

  @override
  List<Object> get props => [e];
}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;

  const CategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}
