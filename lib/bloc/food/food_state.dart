part of 'food_bloc.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

class FoodInitial extends FoodState {}

class FoodLoading extends FoodState {}

class FoodFailed extends FoodState {
  final String e;

  const FoodFailed(this.e);

  @override
  List<Object> get props => [e];
}

class FoodLoaded extends FoodState {
  final List<FoodModel> foods;

  const FoodLoaded(this.foods);

  @override
  List<Object> get props => [foods];
}
