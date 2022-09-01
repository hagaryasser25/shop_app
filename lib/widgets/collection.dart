import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app/screens/feeds.dart';

import '../inner_screens.dart/collection_feeds.dart';

class CollectionWidget extends StatelessWidget {
  CollectionWidget({Key key, this.index}) : super(key: key);

  final int index;
  List<Map<String, Object>> collections = [
    {'collectionName': 'Dresses', 'collectionImage': 'assets/images/dress.jpg'},
    {
      'collectionName': 'Tops',
      'collectionImage': 'assets/images/blouse.jpg'
    },
    {'collectionName': 'Shirts', 'collectionImage': 'assets/images/shirt.jpg'},
    {
      'collectionName': 'Jackets',
      'collectionImage': 'assets/images/jacket.png'
    },
    {'collectionName': 'Pants', 'collectionImage': 'assets/images/Pants.jpg'}
  ];

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: new DecorationImage(
                    image:
                        new AssetImage(collections[index]['collectionImage']),
                    fit: BoxFit.fill,
                  )),
              child: InkWell(
                onTap: () {
                   Navigator.of(context).pushNamed(CollectionFeeds.routeName,
                   arguments:'${collections[index]['collectionName']}'
                   );
                  
                },
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20),
          child: Text(collections[index]['collectionName'],
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
