// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:amazon_clone/constatns/error_handling.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constatns/global_varibales.dart';
import '../../../constatns/utils.dart';
import '../../../models/user_model.dart';
import '../../home/screens/home_screen.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {

    try {
      User user = User(
        id: "",
        name: name,
        email: email,
        password: password,
        address: "",
        type: "",
        token: "",
        cart: []
      );
      var res = await http.post(Uri.parse("$baseUrl/api/signup"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      log(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            "Account created Successfully",
          );
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        "Something went wrong",
      );
    }
  }

  void loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {

    try {
      var res = await http.post(Uri.parse("$baseUrl/api/login"),
          body: jsonEncode({
            "email": email,
            "password": password,
          }),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      log(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);

          await prefs.setString("x-auth-token", jsonDecode(res.body)["token"]);

          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        "Account created Successfully",
      );
    }
  }


  // get user data
  Future<void> getUserData(
      BuildContext context,
      ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(
        Uri.parse('$baseUrl/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      ).timeout(const Duration(seconds: 10));

      bool response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$baseUrl/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    }on TimeoutException{
      showSnackBar(context,"Slow Internet connection detected");
    } catch (e) {
      log(e.toString());
    }
  }

}
