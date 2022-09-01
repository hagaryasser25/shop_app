import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 60),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/cart3.png'),
          )),
        ),
        Text(
          'Empty Basket',
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 10,
          ),
          child: Center(
            child: Text(
              'Your basket is still empty, browse the \n     attractive promos from ForHer',
              style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontSize: 17,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 70,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.height * 0.5, height: MediaQuery.of(context).size.height * 0.07),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: HexColor('#F96F5F'),
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
              child: Text('Shopping Now'),
              onPressed: () {
                
              },
            ),
          ),
        ),
      ],
    );
  }
}
