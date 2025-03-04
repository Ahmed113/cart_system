import 'package:cart_system/app/di.dart';
import 'package:cart_system/presentation/pages/bottom_nav_bar/bottom_nav_view.dart';
import 'package:cart_system/presentation/resources/strings_manager.dart';
import 'package:cart_system/presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';


import 'data/response/cart_item_response/cart_item_response.dart';
import 'data/response/product_response/product_response.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemResponseAdapter());
  Hive.registerAdapter(ProductResponseAdapter());
  await Hive.openBox<CartItemResponse>(StringsManager.cartHiveBox);
  /// DI
  appModuleDi();
  runApp(ScreenUtilInit(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: getAppTheme(),
      debugShowCheckedModeBanner: false,
      home: BottomNavView(),
    );
  }
}
