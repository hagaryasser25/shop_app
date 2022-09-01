import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class WishlistEmpty extends StatelessWidget {
  const WishlistEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Container(
          margin: EdgeInsets.only(top: 60),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/empty-wishlist.png'),
          )),
        ),
        Text(
          'Empty Wishlist',
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
              'Your wishlist is still empty, browse the \n     attractive promos from ForHer',
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
            constraints: BoxConstraints.tightFor(
                width: MediaQuery.of(context).size.height * 0.5,
                height: MediaQuery.of(context).size.height * 0.07),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: HexColor('#F96F5F'),
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
              child: Text('Shopping Now'),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
