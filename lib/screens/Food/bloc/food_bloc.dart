import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect_app/repositories/api_repository.dart';
import 'package:pet_perfect_app/screens/Food/bloc/food_event.dart';
import 'package:pet_perfect_app/screens/Food/bloc/food_state.dart';
import 'package:pet_perfect_app/screens/Food/models/food.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  ApiRepository apiRepository = ApiRepository();
  FoodBloc() : super(FoodInitialState()) {
    // add(FoodInitializedEvent());
    add(GetRefillFoodDataEvent());
  }

  FoodState get initialState {
    return FoodInitialState();
  }

  @override
  Stream<FoodState> mapEventToState(FoodEvent event) async* {
    if (event is FoodInitializedEvent) {
      yield FoodInitialState();
    }

    if (event is GetFoodDataEvent) {
      yield FoodDataLoadingState();
      try {
        FoodData foodData = await apiRepository.getFoodData();
        FoodData suggestedFoodData = await apiRepository.getSuggestedFoodData();
        yield FoodDataLoadedState(foodData, suggestedFoodData);
        print("food data loaded");
      } catch (error) {
        yield FoodDataFailureState(error: error.message);
      }
    }
    if (event is GetRefillFoodDataEvent) {
      yield GetRefillDataLoadingState();
      try {
        RefillFood refillFood = await apiRepository.getRefillTracker();
        yield GetRefillDataLoadedState(refillFood: refillFood);
        print("refill data state");
      } catch (e) {
        yield FoodDataFailureState(error: e.message);
      }
    }
    if (event is SaveButtonPressedEvent) {
      yield FoodDataLoadedState(event.foodData, event.suggestedFoodData);
      print("SaveButtonPressedEvent");

      print('foods length: ${event.foodData.foods.length}');
    }
    if (event is AddButtonPressedEvent) {
      yield FoodDataAddedState(event.foodData, event.suggestedFoodData);

      print("AddButtonPressedEvent");
      print('foods length: ${event.foodData.foods.length}');
    }

    if (event is ReloadFoodEvent) {
      yield FoodDataDeletedState(event.foodData, event.suggestedFoodData);
    }
  }
}
