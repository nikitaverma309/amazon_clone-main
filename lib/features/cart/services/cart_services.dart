import 'dart:convert';
import 'dart:developer';

import 'package:amazon_clone/constatns/global_varibales.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../constatns/error_handling.dart';
import '../../../constatns/utils.dart';
import '../../../models/product.dart';
import '../../../models/user_model.dart';
import '../../../providers/user_provider.dart';

class CartServices {
  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    log("remove from cart pressed");
    log('$baseUrl/api/remove-from-cart/${product.id}');
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('$baseUrl/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      log(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
         userProvider.setUserFormModel(user);
          showSnackBar(context, "Product removed from cart");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
