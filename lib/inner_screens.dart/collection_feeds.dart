import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/my_icons.dart';
import 'package:shop_app/widgets/feeds_products.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/product.dart';
import '../provider/products_provider.dart';

class CollectionFeeds extends StatelessWidget {
  CollectionFeeds({Key key, String arguments}) : super(key: key);

  static const routeName = '/collectionFeeds';

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context , listen: false);
    final collectionName = ModalRoute.of(context).settings.arguments as String;
    print(collectionName);

    final productList = productsProvider.findByCollection(collectionName);
    return Scaffold(
        body: Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
              'Feeds',
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
                    onTap: () {},
                    child: Container(
                        child: Icon(MyAppIcons.cart,
                            color: HexColor('#959595'), size: 22))),
              ),
            ),
          ),
        ]),
        Expanded(
          child: StaggeredGridView.countBuilder(
            padding: EdgeInsets.only(
              top: 20,
              left: 15,
              right: 15,
              bottom: 15,
            ),
            crossAxisCount: 6,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                  value: productList[index], child: FeedsProducts());
            },
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(3, index.isEven ? 5 : 5),
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 5.0,
          ),
        ),
      ],
    ));
  }
}
