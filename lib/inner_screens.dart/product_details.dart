import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/my_colors.dart';
import 'package:shop_app/consts/my_icons.dart';
import 'package:shop_app/provider/products_provider.dart';

import '../provider/cart_provider.dart';
import '../provider/fav_provider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key key}) : super(key: key);
  static const routeName = '/productDetails';
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context, listen: false);
    final productTitle = ModalRoute.of(context).settings.arguments as String;
    final cartProvider = Provider.of<CartProvider>(context);
    final favProvider = Provider.of<FavProvider>(context);
    final productList = productData.products;
    print(productTitle);
    final prodectAtrr = productData.findByTitle(productTitle);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        body: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(color: Colors.white),
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 450.h,
                  child: Image.network(
                    prodectAtrr.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 30.h,
                  left: 15.w, //give the values according to your requirement
                  child: SizedBox.fromSize(
                    size: Size(30, 30),
                    child: ClipOval(
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.arrow_back_ios_rounded,
                                  size: 15.0), // <-- Icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 30.h,
                  right: 15.w, //give the values according to your requirement
                  child: SizedBox.fromSize(
                    size: Size(30, 30),
                    child: ClipOval(
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            favProvider.addAndRemoveFromFav(
                                productTitle,
                                prodectAtrr.price,
                                prodectAtrr.collectionName,
                                prodectAtrr.imageUrl);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.favorite,
                                  size: 15.0, color: favProvider.getFavItems.containsKey(productTitle)?Colors.red: Color.fromARGB(255, 233, 233, 233), )// <-- Icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 240.h,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(prodectAtrr.title,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text('${prodectAtrr.price}',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: HexColor('#F96F5F'),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                        'Cropped rugby shirt in soft jersey with a text print. Collar, button placket and short sleeves.',
                        style: TextStyle(
                          fontSize: 18,
                          color: HexColor('#959595'),
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.fromSize(
                    size: Size(55, 55),
                    child: ClipOval(
                      child: Material(
                        color: Color.fromARGB(255, 245, 244, 244),
                        child: InkWell(
                          onTap: cartProvider.getCartItems
                                  .containsKey(productTitle)
                              ? null
                              : () {
                                  cartProvider.addProductToCart(
                                      productTitle,
                                      prodectAtrr.price,
                                      prodectAtrr.collectionName,
                                      prodectAtrr.imageUrl);
                                },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(MyAppIcons.cart,
                                  size: 20.0, color: Colors.red),
                              // <-- Icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          width: MediaQuery.of(context).size.height * 0.3,
                          height: MediaQuery.of(context).size.height * 0.08),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: HexColor('#F96F5F'),
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        child: Text('Buy Now'),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
//Icon(Icons.arrow_back_ios_rounded,
                     // size: 18.0, color: HexColor('#959595')),
