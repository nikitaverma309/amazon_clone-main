import 'package:amazon_clone/features/accounts/widget/top_buttons.dart';
import 'package:flutter/material.dart';

import '../../../constatns/global_varibales.dart';
import '../widget/below_app_bar.dart';
import '../widget/orders.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: [
        BelowAppBar(),
      //  SizedBox(height: 10),
        TopButtons(),
        SizedBox(height: 20),
       Orders(),
      ],
    ),

    );
  }
}
