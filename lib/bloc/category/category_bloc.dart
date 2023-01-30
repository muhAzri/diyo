import 'package:bloc/bloc.dart';
import 'package:diyo/models/category_model.dart';
import 'package:diyo/services/category_service.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<GetCategoriesEvent>((event, emit) async {
      try {
        emit(CategoryLoading());

        final categories = await CategoryService().getCategories();

        emit(
          CategoryLoaded(categories),
        );
      } catch (e) {
        emit(
          CategoryFailed(e.toString()),
        );
      }
    });
  }
}
