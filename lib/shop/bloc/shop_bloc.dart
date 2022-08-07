import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pet_perfect_app/repositories/repositories.dart';
import 'package:pet_perfect_app/shop/bloc/shop_event.dart';
import 'package:pet_perfect_app/shop/bloc/shop_state.dart';
import 'package:pet_perfect_app/shop/models/shop.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ApiRepository apiRepository = ApiRepository();

  ShopBloc() : super(ShopPageLoadingState()) {
    add(ShopPageInitializedEvent());
    // _shopEventController.stream.listen(mapEventToState);
  }

  @override
  Stream<ShopState> mapEventToState(
    ShopEvent event,
  ) async* {
    if (event is ShopPageInitializedEvent) {
      // yield ShopPageLoadingState();
      ShopData shopData = await apiRepository.getShopItems();
      ShopData cartItems = await apiRepository.getCartItems();
      yield ShopPageLoadedState(shopData: shopData, cartData: cartItems);
    }
    if (event is ItemAddingCartEvent) {
      yield ItemAddingCartState(cartItems: event.cartItems);
    }
    if (event is ItemAddedCartEvent) {
      yield ItemAddedCartState(cartItems: event.cartItems);
    }
    if (event is ItemDeleteCartEvent) {
      yield ItemDeletingCartState(cartItems: event.cartItems);
    }

  }

  
}
