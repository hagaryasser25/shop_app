import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/fav_provider.dart';
import 'package:shop_app/widgets/cart_empty.dart';
import 'package:shop_app/widgets/cart_full.dart';

import '../widgets/wishlist_empty.dart';
import '../widgets/wishlist_full.dart';

class Wishlist extends StatelessWidget {
  Wishlist({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavProvider>(context);
    return favProvider.getFavItems.isEmpty
        ? Scaffold(body: WishlistEmpty())
        : Scaffold(
            body: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 35, left: 14),
                          child: InkWell(
                            child: Icon(Icons.arrow_back_ios_rounded,
                                size: 18.0, color: HexColor('#959595')),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: Text(
                          'Wishlist',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 35,
                          right: 20,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: Align(
                            child: InkWell(
                                borderRadius: BorderRadius.circular(16.0),
                                onTap: () {
                                  favProvider.clearFav();
                                },
                                child: Container(
                                    child: Icon(Icons.delete,
                                        color: HexColor('#959595'), size: 22))),
                          ),
                        ),
                      ),
                    ]),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: favProvider.getFavItems.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return ChangeNotifierProvider.value(
                          value: favProvider.getFavItems.values.toList()[index],
                          child: WishlistFull());
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
