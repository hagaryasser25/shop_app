import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart_attr.dart';
import 'package:shop_app/provider/dark_theme_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../inner_screens.dart/product_details.dart';
import '../provider/cart_provider.dart';

class CartFull extends StatefulWidget {
  const CartFull({Key key}) : super(key: key);

  @override
  State<CartFull> createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartAttr = Provider.of<CartAttr>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.2,
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              color: Colors.transparent),
          child: Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(cartAttr.imageUrl),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  )),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 26,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  cartAttr.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 1),
                                child: Material(
                                  color: Colors.transparent,
                                  child: Align(
                                    child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        onTap: () {
                                          cartProvider.removeItem(
                                              cartAttr.title);
                                        },
                                        child: Container(
                                            child: Icon(Entypo.cross,
                                                color: Colors.red, size: 22))),
                                  ),
                                ),
                              )
                            ]),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(cartAttr.collection,
                            style: TextStyle(color: HexColor('#959595'))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${cartAttr.price}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: HexColor('#FA8072'))),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Material(
                                color: Colors.transparent,
                                child: Align(
                                  child: InkWell(
                                      borderRadius: BorderRadius.circular(16.0),
                                      onTap: cartAttr.quantity < 2
                                          ? null
                                          : () {
                                              cartProvider.reduceItemByOne(
                                                  cartAttr.title,
                                                  cartAttr.price,
                                                  cartAttr.collection,
                                                  cartAttr.imageUrl);
                                            },
                                      child: Container(
                                          child: Icon(Entypo.minus,
                                              color: HexColor('#959595'),
                                              size: 22))),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text('${cartAttr.quantity.toString()}'),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: Align(
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(16.0),
                                    onTap: () {
                                      cartProvider.addProductToCart(
                                          cartAttr.title,
                                          cartAttr.price,
                                          cartAttr.title,
                                          cartAttr.imageUrl);
                                    },
                                    child: Container(
                                        child: Icon(Entypo.plus,
                                            color: HexColor('#FA8072'),
                                            size: 22))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
