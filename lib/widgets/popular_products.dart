import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/my_icons.dart';
import 'package:shop_app/inner_screens.dart/product_details.dart';
import 'package:shop_app/provider/products_provider.dart';

import '../models/product.dart';
import '../provider/cart_provider.dart';

class PopularProducts extends StatelessWidget {
  PopularProducts({Key key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    final productsAttributes = Provider.of<Product>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      width: 170,
      height: 290,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, ProductDetails.routeName,
                            arguments: productsAttributes.title);
                      },
                      child: Container(
                          constraints: BoxConstraints(
                              minHeight: 100,
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.3),
                          child: Image.network(
                            productsAttributes.imageUrl,
                            fit: BoxFit.fill,
                          )),
                    )),
              ],
            ),
            Container(
                padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.only(left: 5, bottom: 2, right: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      productsAttributes.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${productsAttributes.price}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 18,
                              color: HexColor('#FA8072'),
                              fontWeight: FontWeight.w600),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap:  
                              cartProvider.getCartItems
                                      .containsKey(productsAttributes.title)
                                  ? (){}
                                  : () {
                                      cartProvider.addProductToCart(
                                          productsAttributes.title,
                                          productsAttributes.price,
                                          productsAttributes.collectionName,
                                          productsAttributes.imageUrl);
                                    },
                            
                            borderRadius: BorderRadius.circular(18.0),
                            child: Icon(
                              cartProvider.getCartItems
                                      .containsKey(productsAttributes.title)
                                  ?MaterialCommunityIcons.check_circle: MyAppIcons.cart,
                                color: HexColor('#959595')),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
