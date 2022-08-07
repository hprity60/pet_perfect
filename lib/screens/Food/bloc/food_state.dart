import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:pet_perfect_app/screens/Food/models/food.dart';

abstract class FoodState extends Equatable {
  FoodState();
  FoodData foodData;
  FoodData suggestedFoodData;
  

  @override
  List<Object> get props => [];
}

class FoodInitialState extends FoodState {}

class FoodDataLoadingState extends FoodState {}

class FoodDataLoadedState extends FoodState {
  FoodDataLoadedState(FoodData foodData, FoodData suggestedFoodData) {
    super.foodData = foodData;
    super.suggestedFoodData = suggestedFoodData;

    @override
    String toString() => 'state is : FoodDataLoadedState }';
  }
}

class FoodDataAddedState extends FoodState {
  FoodDataAddedState(FoodData foodData, FoodData suggestedFoodData) {
    super.foodData = foodData;
    super.suggestedFoodData = suggestedFoodData;
  }

  @override
  String toString() => 'state is : FoodDataAddedState }';
}

class FoodDataDeletedState extends FoodState {
  FoodDataDeletedState(FoodData foodData, FoodData suggestedFoodData) {
    super.foodData = foodData;
    super.suggestedFoodData = suggestedFoodData;
  }

  @override
  String toString() => 'state is : FoodDataAddedState }';
}

class FoodDataFailureState extends FoodState {
  final String error;

  FoodDataFailureState({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'DataFailure { error: $error }';
}

class GetRefillDataLoadingState extends FoodState {}

class GetRefillDataLoadedState extends FoodState {
  RefillFood refillFood;
  GetRefillDataLoadedState({this.refillFood});
}
