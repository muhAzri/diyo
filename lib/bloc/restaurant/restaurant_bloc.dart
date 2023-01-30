import 'package:bloc/bloc.dart';
import 'package:diyo/models/restaurant_model.dart';
import 'package:diyo/services/restaurant_service.dart';
import 'package:equatable/equatable.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInitial()) {
    on<GetRestaurantEvent>((event, emit) async {
      try {
        emit(RestaurantLoading());

        final restaurants = await RestaurantService().getRestaurant();

        emit(
          RestaurantLoaded(restaurants),
        );
      } catch (e) {
        emit(RestaurantFailed(
          e.toString(),
        ));
      }
    });
  }
}
