import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/widgets/loading_indicator.dart';
import 'package:pet_perfect_app/screens/Food/bloc/food_bloc.dart';
import 'package:pet_perfect_app/screens/Food/components/filter_item.dart';
import 'package:pet_perfect_app/screens/Food/components/food_items.dart';
import 'package:pet_perfect_app/screens/Food/components/product_item.dart';
import 'package:pet_perfect_app/shop/view/product_detail.dart';
import 'package:pet_perfect_app/screens/components/side_bar.dart';
import 'package:pet_perfect_app/screens/components/default_search_box.dart';
import 'package:pet_perfect_app/shop/bloc/shop_bloc.dart';
import 'package:pet_perfect_app/shop/bloc/shop_event.dart';
import 'package:pet_perfect_app/shop/bloc/shop_state.dart';
import 'package:pet_perfect_app/shop/models/shop.dart';
import 'package:pet_perfect_app/shop/view/shopping_cart.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key key}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool loadingData = true;
  List<ShopItem> _cartItems = [];
  List<ShopItem> shopItems;
  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: 'product page');

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopBloc, ShopState>(
      listener: (context, state) {
        if (state is ShopPageLoadingState) {
          loadingData = true;
        } else if (state is ShopPageLoadedState) {
          shopItems = state.shopData.shopItems;
          _cartItems = state.cartData.shopItems;
          loadingData = false;
        }
        if (state is ItemAddedCartState) {
          _cartItems = state.cartItems;
          loadingData = false;
        }
        if (state is ItemDeletingCartState) {
          _cartItems = state.cartItems;
          loadingData = false;
        }
      },
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          print("produc page state: $state");

          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(
                "Shop",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              elevation: 0,
              backgroundColor: kPrimaryColor,
            ),
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<ShopBloc>(context),
                            child: ShoppingCart())));
              },
              child: Text(
                _cartItems.length.toString(),
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
              backgroundColor: kPrimaryColor,
            ),
            bottomNavigationBar: Container(
                height: 52,
                color: Colors.white,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _fitlterModalBottomSheet(context);
                      },
                      child: Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 52,
                          width: displayWidth(context) * 0.5,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: Text(
                            'Filter',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _sortModalBottomSheet(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 52,
                        width: displayWidth(context) * 0.5,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Text(
                          'Sort',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            body: loadingData
                ? Center(child: LoadingIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: displayHeight(context) * 6,
                              width: double.infinity,
                              decoration: kBackgroundBoxDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 290,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          // height: displayHeight(context) * 0.24,
                                          height: fitToHeight(290, context),
                                          width: displayWidth(context),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'assets/images/Banner (2).png')),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 8),
                                          child: DefaultSearchBox(
                                            hintText: 'Search for a product',
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Row(
                                              children: [
                                                FoodItem(
                                                  foodItem: 'Dry \nFood',
                                                  color: Color(0xFFEC5858),
                                                ),
                                                SizedBox(width: 8),
                                                FoodItem(
                                                  color: Color(0xFFFD8C04),
                                                  foodItem: 'Wet \nFood',
                                                ),
                                                SizedBox(width: 8),
                                                FoodItem(
                                                  color: Color(0xFFA685E2),
                                                  foodItem: 'Puppy \nFood',
                                                ),
                                                SizedBox(width: 8),
                                                FoodItem(
                                                  color: Color(0xFF93ABD3),
                                                  foodItem: 'Pet \nToys',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Center(
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0xFFEC5858)
                                              .withOpacity(0.50)),
                                      child: Text(
                                        'Specially selected for Arya',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 22),
                                  GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.82,
                                        mainAxisSpacing: 0,
                                        crossAxisSpacing: 0,
                                      ),
                                      itemCount: shopItems.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return ProductItem(
                                          addToCart: () {
                                            setState(() {
                                              _cartItems.add(shopItems[index]);
                                            });

                                            _scaffoldKey.currentState
                                                .showSnackBar(SnackBar(content: Text('Item Added To Cart'),backgroundColor: kPrimaryColor));

                                            print("added");
                                          },
                                          // productImage:
                                          //     shopItems[index].imageUrl,
                                          productImage:
                                              shopItems[index].thumbnail,
                                          price: shopItems[index].price,
                                          title: shopItems[index].title,
                                          press: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        BlocProvider.value(
                                                            value: BlocProvider
                                                                .of<ShopBloc>(
                                                                    context)
                                                              ..add(ItemAddingCartEvent(
                                                                  cartItems:
                                                                      _cartItems)),
                                                            child:
                                                                ProductDetail(
                                                              shopItem:
                                                                  shopItems[
                                                                      index],
                                                            ))));
                                          },
                                        );
                                      }),
                                  SizedBox(height: 20),
                                  SizedBox(
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0xFFEC5858)
                                              .withOpacity(0.50)),
                                      child: Text(
                                        'Care Packs',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  void _fitlterModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: displayHeight(context) * 0.43,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter By',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 15),
                  FilterItem(
                    text: 'Brand',
                  ),
                  SizedBox(height: 15),
                  FilterItem(
                    text: 'Size',
                  ),
                  SizedBox(height: 15),
                  FilterItem(
                    text: 'Products',
                  ),
                  SizedBox(height: 15),
                  FilterItem(
                    text: 'Condition',
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _sortModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: displayHeight(context) * 0.43,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sort By',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Featured',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Best Selling',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Price Hign to Low',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Price Low to Hign',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
