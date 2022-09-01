import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/cart_empty.dart';
import 'package:shop_app/widgets/cart_full.dart';

import '../provider/cart_provider.dart';

class Cart extends StatelessWidget {
  Cart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartItems.isEmpty
        ? Scaffold(body: CartEmpty())
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
                          'Cart',
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
                                  cartProvider.clearCart();
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
                    itemCount: cartProvider.getCartItems.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return ChangeNotifierProvider.value(
                          value:
                              cartProvider.getCartItems.values.toList()[index],
                          child: CartFull());
                    },
                  ),
                ),
              ],
            ),
            bottomSheet: CheckOutSection(context, cartProvider.totalAmount),
          );
  }
}

Widget CheckOutSection(BuildContext context, double subTotal) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.1,
    decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
    child: Padding(
      padding: const EdgeInsets.only(
        left: 30,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total :', style: TextStyle(color: HexColor('#959595'))),
          Text('$subTotal\$', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 50),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(
                width: MediaQuery.of(context).size.height * 0.2,
                height: MediaQuery.of(context).size.height * 0.06),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: HexColor('#F96F5F'),
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
              child: Text('Pay Now'),
              onPressed: () {},
            ),
          ),
        ],
      ),
    ),
  );
}
