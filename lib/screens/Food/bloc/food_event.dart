import 'package:equatable/equatable.dart';
import 'package:pet_perfect_app/screens/Food/models/food.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();
  @override
  List<Object> get props => [];
}

class FoodInitializedEvent extends FoodEvent {
  
}

class GetFoodDataEvent extends FoodEvent {
  final String breed;
  final int age;
  GetFoodDataEvent({
    this.age,
    this.breed,
  });
}

class SaveButtonPressedEvent extends FoodEvent {
  FoodData foodData;
  FoodData suggestedFoodData;

  SaveButtonPressedEvent({this.foodData,this.suggestedFoodData,});
}


class AddButtonPressedEvent extends FoodEvent {
  FoodData foodData;
  FoodData suggestedFoodData;

  AddButtonPressedEvent({this.foodData,this.suggestedFoodData,});
}

class ReloadFoodEvent extends FoodEvent {
    FoodData foodData;
  FoodData suggestedFoodData;

  ReloadFoodEvent({this.foodData,this.suggestedFoodData,});
}


class GetRefillFoodDataEvent extends FoodEvent {}