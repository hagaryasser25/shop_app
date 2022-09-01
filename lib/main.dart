import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/inner_screens.dart/collection_feeds.dart';
import 'package:shop_app/inner_screens.dart/product_details.dart';
import 'package:shop_app/inner_screens.dart/upload_product.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/dark_theme_provider.dart';
import 'package:shop_app/provider/fav_provider.dart';
import 'package:shop_app/provider/products_provider.dart';
import 'package:shop_app/screens/auth/login.dart';
import 'package:shop_app/screens/auth/sign_up.dart';
import 'package:shop_app/screens/bottom_bar.dart';
import 'package:shop_app/screens/cart.dart';
import 'package:shop_app/screens/landing_page.dart';

import 'consts/theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePrefrences.getTheme();
  }

  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator()
                )
              )
            );
          }
          else if(snapshot.hasError){
              return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error occured'),
                )
              )
            );
          }
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) {
                  return themeChangeProvider;
                }),
                ChangeNotifierProvider(create: (_) {
                  return ProductProvider();
                }),
                ChangeNotifierProvider(create: (_) {
                  return CartProvider();
                }),
                ChangeNotifierProvider(create: (_) {
                  return FavProvider();
                }),
              ],
              child: Consumer<DarkThemeProvider>(
                  builder: (context, themeData, child) {
                return MaterialApp(
                  title: 'Flutter Demo',
                  theme:
                      Styles.themeData(themeChangeProvider.darkTheme, context),
                  home: LandingPage(),
                  routes: {
                    CollectionFeeds.routeName: (ctx) => CollectionFeeds(),
                    ProductDetails.routeName: (ctx) => ProductDetails(),
                    LoginScreen.routeName: (ctx) => LoginScreen(),
                    SignUpScreen.routeName: (ctx) => SignUpScreen(),
                    BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
                    UploadProductForm.routeName: (ctx) => UploadProductForm(),
                  },
                );
              }));
        });
  }
}
