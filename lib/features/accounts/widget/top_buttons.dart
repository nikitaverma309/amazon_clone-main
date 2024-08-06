import 'package:flutter/material.dart';

import '../../../constatns/global_varibales.dart';
import '../services/accout_services.dart';
import 'account_button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        gradient: GlobalVariables.appBarGradient(opacity: 0.12),
      ),
      child: Column(

        children: [
          SizedBox(height: 10,),
          Row(
            children: [
              AccountButton(
                text: 'Your Orders',
                onTap: () {},
              ),
              AccountButton(
                text: 'Turn Seller',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              AccountButton(
                text: 'Log Out',
                onTap: () {
                 AccountServices().logOut(context);
                },
              ),
              AccountButton(
                text: 'Your Wish List',
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
