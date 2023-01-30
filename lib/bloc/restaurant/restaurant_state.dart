part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantFailed extends RestaurantState {
  final String e;

  const RestaurantFailed(this.e);

  @override
  List<Object> get props => [e];
}

class RestaurantLoaded extends RestaurantState {
  final List<RestaurantModel> restaurants;

  const RestaurantLoaded(this.restaurants);

  @override
  List<Object> get props => restaurants;
}
