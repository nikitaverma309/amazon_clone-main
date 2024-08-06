import 'package:amazon_clone/constatns/bottom_bar.dart';
import 'package:amazon_clone/features/accounts/screen/order_details.dart';
import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/admin/admin_screen.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';

import 'features/admin/screens/add_product_screen.dart';
import 'features/auth/screens/auth_screen.dart';
import 'features/home/screens/category_deals_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());

    case BottomBar.routeName:
      return MaterialPageRoute(builder: (_) => const BottomBar());

    case AdminScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AdminScreen());

    case AddProductScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddProductScreen());

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => CategoryDealsScreen(
                category: category,
              ));

    case SearchScreen.routeName:
      var query = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => SearchScreen(
                searchQuery: query,
              ));

    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(
            product: product,
          ));

    case AddressScreen.routeName:
      var amount = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => AddressScreen(
            totalAmount: amount ,
          ));

    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          builder: (_) => OrderDetailScreen(
            order: order,
          ));




    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("route not implemented "),
                ),
              ));
  }
}
