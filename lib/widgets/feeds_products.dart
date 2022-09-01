import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/inner_screens.dart/product_details.dart';
import 'package:shop_app/models/product.dart';

class FeedsProducts extends StatefulWidget {
  @override
  const FeedsProducts({Key key}) : super(key: key);

  @override
  State<FeedsProducts> createState() => _FeedsProductsState();
}

class _FeedsProductsState extends State<FeedsProducts> {
  @override
  Widget build(BuildContext context) {
    final productsAttributes = Provider.of<Product>(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName, arguments: productsAttributes.title);
      },
      child: Container(
        // width: 300,
        //height: 400,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                        child: Image.network(
                      productsAttributes.imageUrl,
                      fit: BoxFit.fill,
                    ))),
                Badge(
                  toAnimate: true,
                  shape: BadgeShape.square,
                  badgeColor: HexColor('#FA8072'),
                  borderRadius: BorderRadius.circular(8),
                  badgeContent:
                      Text('New', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.only(left: 5,  right: 3),
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
                          'EGP ${productsAttributes.price}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 18,
                              color: HexColor('#FA8072'),
                              fontWeight: FontWeight.w600),
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
