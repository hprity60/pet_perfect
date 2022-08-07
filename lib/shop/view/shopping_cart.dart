import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/shop/view/checkout.dart';
import 'package:pet_perfect_app/shop/bloc/shop_bloc.dart';
import 'package:pet_perfect_app/shop/bloc/shop_event.dart';
import 'package:pet_perfect_app/shop/bloc/shop_state.dart';
import 'package:pet_perfect_app/shop/models/shop.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<ShopItem> _cartItems;
  double totalAmount = 0;

  void calculateTotalAmount(List<ShopItem> list) {
    double res = 0;
    list.forEach((element) {
      res = res + element.price * element.quantity;
    });
    totalAmount = res;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopBloc, ShopState>(
      listener: (context, state) {
        if (state is ItemAddedCartState) {
          _cartItems = state.cartItems;
        }
        if (state is ShopPageLoadedState) {
          _cartItems = state.cartData.shopItems;
        }
        if (state is ItemDeletingCartState) {
          _cartItems = state.cartItems;
        }
        if (state is ItemAddingCartState) {
          _cartItems = state.cartItems;
        }
      },
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ItemAddedCartState) {
            _cartItems = state.cartItems;
            calculateTotalAmount(_cartItems);
          }
          if (state is ShopPageLoadedState) {
            _cartItems = state.cartData.shopItems;
            calculateTotalAmount(_cartItems);
          }
          if (state is ItemDeletingCartState) {
            _cartItems = state.cartItems;
            calculateTotalAmount(_cartItems);
          }

          if (state is ItemAddingCartState) {
            _cartItems = state.cartItems;
            calculateTotalAmount(_cartItems);
          }
          print("state is : $state");
          return Scaffold(
            backgroundColor: Color(0XFFF8F5F0),
            appBar: AppBar(
              backgroundColor: Color(0XFFF8F5F0),
              title: Text(
                'Shopping Cart',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            bottomNavigationBar: Container(
              height: 68,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 8,
                      color: Color(0xFF000000).withOpacity(0.20),
                    ),
                    BoxShadow(
                      offset: Offset(0, -1),
                      blurRadius: 3,
                      color: Color(0xFF000000).withOpacity(0.20),
                    ),
                    BoxShadow(
                      offset: Offset(0, -1),
                      blurRadius: 4,
                      color: Color(0xFF000000).withOpacity(0.14),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  )),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          '\$${totalAmount.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'total amout',
                          style: GoogleFonts.poppins(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 128,
                      height: 52,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: kPrimaryColor,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Checkout(_cartItems)));
                        },
                        child: Text(
                          'Checkout',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: (_cartItems == null || _cartItems.length == 0)
                    ? Center(child: Text("Your cart is empty"))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: _cartItems.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              // CartLists(
                              //   image: _cartItems[index].imageUrl,
                              //   text: _cartItems[index].title,
                              //   price: _cartItems[index].price,
                              // ),
                              _buildCartList2(
                                image: _cartItems[index].imageUrl,
                                text: _cartItems[index].title,
                                price: _cartItems[index].price,
                                index: index,
                                state: state,
                                context: context,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        },
                      ),
              )),
            ),
          );
        },
      ),
    );
  }

  _buildCartList(
      {String image, String text, double price, int index, ShopState state}) {
    return Container(
      alignment: Alignment.center,
      // height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                  image,
                  width: 80,
                  height: 80,
                ),
                SizedBox(width: 10),
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                InkWell(
                    onTap: () {
                      setState(() {
                        if (state is ShopPageLoadedState) {
                          state.cartData.shopItems.removeAt(index);
                          calculateTotalAmount(_cartItems);
                          BlocProvider.of<ShopBloc>(context).add(
                              ItemDeleteCartEvent(
                                  cartItems: state.cartData.shopItems));

                          ///Api to save cart items

                        } else if (state is ItemAddedCartState) {
                          state.cartItems.removeAt(index);

                          calculateTotalAmount(_cartItems);
                          BlocProvider.of<ShopBloc>(context).add(
                              ItemDeleteCartEvent(cartItems: state.cartItems));
                        } else if (state is ItemDeletingCartState) {
                          state.cartItems.removeAt(index);

                          calculateTotalAmount(_cartItems);
                          BlocProvider.of<ShopBloc>(context).add(
                              ItemAddedCartEvent(cartItems: state.cartItems));
                        }
                      });
                    },
                    child: Image.asset('assets/images/cancel.png')),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (_cartItems[index].quantity > 0)
                      setState(() {
                        _cartItems[index].quantity--;
                        calculateTotalAmount(_cartItems);
                        print(_cartItems[index].quantity);
                      });
                  },
                ),
                SizedBox(
                  height: 20,
                  width: 30,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.5)),
                    child: Text(
                      _cartItems[index].quantity.toString(),
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
                      _cartItems[index].quantity++;
                      calculateTotalAmount(_cartItems);
                      print(_cartItems[index].quantity);
                    });
                  },
                ),
                Spacer(),
                Text(
                  '\$${price * _cartItems[index].quantity}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildCartList2(
      {BuildContext context,String image, String text, double price, int index, ShopState state}) {
    return Container(
      height: fitToHeight(165,context),
      width: double.infinity,
      decoration: kBox20Decoration(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ Column(
            
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: fitToHeight(displayHeight(context) * 0.12,context),
                      // width: fitToWidth(displayWidth(context) * 0.25,context),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(image)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (_cartItems[index].quantity > 0)
                              setState(() {
                                _cartItems[index].quantity--;
                                calculateTotalAmount(_cartItems);
                                print(_cartItems[index].quantity);
                              });
                          },
                        ),
                        SizedBox(
                          height: fitToHeight(20,context),
                          width: fitToWidth(30, context),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 0.5)),
                            child: Text(
                              _cartItems[index].quantity.toString(),
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
                              _cartItems[index].quantity++;
                              calculateTotalAmount(_cartItems);
                              print(_cartItems[index].quantity);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                
            ),
            SizedBox(
              width: 8,
            ),
               Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                 
                    width: fitToWidth(130, context),
                    child: Text(
                     text,
                      maxLines: 6,
                      softWrap: true,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        
                      ),
                    ),
                  ),
                ],
              ),
          
            Spacer(),
             Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            if (state is ShopPageLoadedState) {
                              state.cartData.shopItems.removeAt(index);
                              calculateTotalAmount(_cartItems);
                              BlocProvider.of<ShopBloc>(context).add(
                                  ItemDeleteCartEvent(
                                      cartItems: state.cartData.shopItems));

                              ///Api to save cart items

                            } else if (state is ItemAddedCartState) {
                              state.cartItems.removeAt(index);

                              calculateTotalAmount(_cartItems);
                              BlocProvider.of<ShopBloc>(context).add(
                                  ItemDeleteCartEvent(cartItems: state.cartItems));
                            } else if (state is ItemDeletingCartState) {
                              state.cartItems.removeAt(index);

                              calculateTotalAmount(_cartItems);
                              BlocProvider.of<ShopBloc>(context).add(
                                  ItemAddedCartEvent(cartItems: state.cartItems));
                            }
                          });
                        },
                        child: Image.asset('assets/images/cancel.png')),
                    
                    Padding(
                      padding: const EdgeInsets.only(bottom:12.0),
                      child: Text(
                        '\$${price * _cartItems[index].quantity}',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
             
            
          ],
        ),
      ),
    );
  }
}
