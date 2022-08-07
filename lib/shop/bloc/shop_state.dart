import 'package:equatable/equatable.dart';
import 'package:pet_perfect_app/shop/models/shop.dart';

// part of 'info_bloc.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopPageLoadingState extends ShopState {}

class ShopPageLoadedState extends ShopState {
  final ShopData shopData;
  ShopData cartData;
  ShopPageLoadedState({this.shopData, this.cartData});
}

class ItemAddingCartState extends ShopState {
  ShopData cartData;
  List<ShopItem> cartItems;
  ItemAddingCartState({this.cartData, this.cartItems});
}

class ItemAddedCartState extends ShopState {
  List<ShopItem> cartItems;
  ItemAddedCartState({this.cartItems});
}

class ItemDeletingCartState extends ShopState {
  List<ShopItem> cartItems;
  ItemDeletingCartState({this.cartItems});
}
