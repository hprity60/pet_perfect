import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/screens/Food/components/product_item.dart';
import 'package:pet_perfect_app/screens/components/side_bar.dart';
import 'package:pet_perfect_app/screens/components/default_search_box.dart';
import 'package:pet_perfect_app/shop/bloc/shop_bloc.dart';
import 'package:pet_perfect_app/shop/bloc/shop_event.dart';
import 'package:pet_perfect_app/shop/bloc/shop_state.dart';
import 'package:pet_perfect_app/shop/models/shop.dart';
import 'package:pet_perfect_app/shop/view/shopping_cart.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key key, this.shopItem}) : super(key: key);

  final ShopItem shopItem;
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<ShopItem> _cartItems = [];
  // int _quantity = 1;
  bool _itemselected = false;
  bool loadingData = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopBloc, ShopState>(
      listener: (context, state) {},
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          print("product detail is $state");
          if (state is ItemAddingCartState) {
            loadingData = false;
            _cartItems = state.cartItems;
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Pet Perfect",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              elevation: 0,
              backgroundColor: kPrimaryColor,
            ),
            backgroundColor: kPrimaryColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: displayHeight(context) * 99,
                    width: double.infinity,
                    decoration: kBackgroundBoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          DefaultSearchBox(
                            hintText: 'Search for product',
                            color: Color(0xFFEEEEEE),
                            
                          ),
                        SizedBox(height: 16),
                          Container(
                            height: fitToHeight(270, context),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        widget.shopItem.imageUrl))),
                          ),
                          Text(
                            widget.shopItem.title,
                            // 'Wild Earth Clean Protein Formula Vegan Adult Dry Dog Food - All Breeds',
                            style: kHeading18.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '\$${widget.shopItem.price}',
                            style: kHeading14,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Sizes',
                                textAlign: TextAlign.center,
                                style: kHeading14,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 24,
                                width: 38,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Color(0xFFD2D2D2),
                                          width: 0.5)),
                                  child: Text(
                                    '1 kg',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              SizedBox(
                                height: 24,
                                width: 38,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Color(0xFFD2D2D2),
                                          width: 0.5)),
                                  child: Text(
                                    '2 kg',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              SizedBox(
                                height: 24,
                                width: 38,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Color(0xFF000000),
                                          width: 0.5)),
                                  child: Text(
                                    '3 kg',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Spacer(),

                              Column(
                                children: [
                                  Text(
                                'Quantity',
                                textAlign: TextAlign.center,
                                style: kHeading14,
                              ),

                              Row(
                                children: [
                                  IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  if (widget.shopItem.quantity > 0)
                                    setState(() {
                                      widget.shopItem.quantity--;
                                      // calculateTotalAmount();
                                    });
                                },
                              ),
                              SizedBox(
                                height: 20,
                                width: 30,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 0.5)),
                                  child: Text(
                                    widget.shopItem.quantity.toString(),
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    widget.shopItem.quantity++;
                                    // calculateTotalAmount();
                                  });
                                },
                              ),
                                ],
                              ),
                                ],
                              ),
                              
                            ],
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              width: double.infinity,
                              child: FlatButton(
                                  color: Colors.black,
                                  onPressed: () {
                                    if (_itemselected == false) {
                                      ShopItem cartItem = ShopItem(
                                        imageUrl: widget.shopItem.imageUrl,
                                        price: widget.shopItem.price,
                                        quantity: widget.shopItem.quantity,
                                        title: widget.shopItem.title,
                                      );

                                      print(cartItem.quantity);
                                      _cartItems.add(cartItem);

                                      // if (state is ItemAddingCartState) {
                                      //   state.cartData.shopItems.add(cartItem);

                                      //   state.cartData.shopItems
                                      //       .forEach((element) {
                                      //     print(element.quantity);
                                      //   });
                                      // }

                                      ///Adding list of cartItems to ItemAddedCartState
                                      BlocProvider.of<ShopBloc>(context).add(
                                          ItemAddedCartEvent(
                                              cartItems: _cartItems));

                                      setState(() {
                                        _itemselected = true;
                                      });
                                    } else
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  BlocProvider.value(
                                                      value: BlocProvider.of<
                                                          ShopBloc>(context),
                                                      child: ShoppingCart())));
                                  },
                                  child: Text(
                                    _itemselected
                                        ? 'Go to Cart'
                                        : 'Add to Cart',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Similiar products",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 22),
                          // Expanded(
                          //   child: GridView.count(
                          //     crossAxisCount: 2,
                          //     childAspectRatio: .82,
                          //     // crossAxisSpacing: 10,
                          //     // mainAxisSpacing: 10,
                          //     children: [
                          //       ProductItem(
                          //         press: () {
                          //           Navigator.push(
                          //               context,
                          //               MaterialPageRoute(
                          //                   builder: (context) =>
                          //                       ProductDetail()));
                          //         },
                          //         productImage: 'assets/images/product1.png',
                          //         title:
                          //             'Wild Earth Clean Protein Formula Vegan Adult Dry Dog Food - All Breeds',
                          //         price: 1500,
                          //       ),
                          //       ProductItem(
                          //         press: () {},
                          //         productImage: 'assets/images/product2.png',
                          //         title:
                          //             'Royal Canin Maxi Breed Adult Dry Dog Food - All Breeds',
                          //         price: 1500,
                          //       ),
                          //       ProductItem(
                          //         press: () {},
                          //         productImage: 'assets/images/product3.png',
                          //         title:
                          //             'Wild Earth Clean Protein Formula Vegan Adult Dry Dog Food - All Breeds',
                          //         price: 1500,
                          //       ),
                          //       ProductItem(
                          //         press: () {},
                          //         productImage: 'assets/images/product4.png',
                          //         title:
                          //             'Royal Canin Maxi Breed Adult Dry Dog Food - All Breeds',
                          //         price: 1500,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SizeLists extends StatelessWidget {
  const SizeLists({
    Key key,
    this.size,
    this.color,
  }) : super(key: key);
  final int size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) * .035,
      width: displayWidth(context) * 0.13,
      child: Container(
        alignment: Alignment.center,
        decoration: kBox5Decoration(color: kSecondaryColor)
            .copyWith(border: Border.all(color: color, width: 0.5)),
        child: Text(
          '${size} kg',
          style: kHeading14,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
