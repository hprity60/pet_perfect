import 'package:equatable/equatable.dart';
import 'package:pet_perfect_app/shop/models/shop.dart';

// part of 'info_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class ShopPageInitializedEvent extends ShopEvent {}

class ItemAddingCartEvent extends ShopEvent {
  List<ShopItem> cartItems;
  ItemAddingCartEvent({this.cartItems});
}

class ItemAddedCartEvent extends ShopEvent {
  List<ShopItem> cartItems;
  ItemAddedCartEvent({this.cartItems});
}

class ItemDeleteCartEvent extends ShopEvent {
  int index;
  List<ShopItem> cartItems;
  ItemDeleteCartEvent({this.index,this.cartItems});
}
