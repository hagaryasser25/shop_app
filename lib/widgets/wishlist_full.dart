import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/fav_attr.dart';
import 'package:shop_app/provider/dark_theme_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../models/fav_attr.dart';
import '../provider/fav_provider.dart';

class WishlistFull extends StatefulWidget {
  const WishlistFull({Key key}) : super(key: key);

  @override
  State<WishlistFull> createState() => _WishlistFullState();
}

class _WishlistFullState extends State<WishlistFull> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final favAttr = Provider.of<FavAttr>(context);
    final favProvider = Provider.of<FavProvider>(context);

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
                      image: NetworkImage(favAttr.imageUrl),
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
                                  favAttr.title,
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
                                          favProvider.removeItem(favAttr.title);
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
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Text('${favAttr.price}\$',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: HexColor('#FA8072'))),
                              ],
                            ),
                          )),
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
