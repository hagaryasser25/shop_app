import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/inner_screens.dart/upload_product.dart';
import 'package:shop_app/provider/products_provider.dart';
import 'package:shop_app/widgets/collection.dart';
import 'package:shop_app/widgets/popular_products.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final popularItems = productData.popularProducts;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Home',
        )),
        backgroundColor: HexColor('#FA8072'),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, UploadProductForm.routeName);
            },
            icon: Icon(Icons.upload)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Collections',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'RobotoMono')),
            ),
          ),
          Container(
              width: double.infinity,
              height: 140,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext ctx, int index) {
                    return CollectionWidget(index: index);
                  })),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                bottom: 20,
              ),
              child: Text('Popular Products',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'RobotoMono')),
            ),
          ),
          Container(
              width: double.infinity,
              height: 250,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularItems.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ChangeNotifierProvider.value(
                        value: popularItems[index], child: PopularProducts());
                  })),
        ],
      ),
    );
  }
}
