import 'package:bloc/bloc.dart';
import 'package:diyo/models/food_model.dart';
import 'package:diyo/services/food_service.dart';
import 'package:equatable/equatable.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodInitial()) {
    on<GetFoodsEvent>((event, emit) async {
      try {
        emit(FoodLoading());

        final foods = await FoodService().getFoods();

        emit(
          FoodLoaded(foods),
        );
      } catch (e) {
        emit(FoodFailed(
          e.toString(),
        ));
      }
    });
  }
}
