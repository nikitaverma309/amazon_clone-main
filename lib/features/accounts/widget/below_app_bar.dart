import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constatns/global_varibales.dart';
import '../../../providers/user_provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      decoration:  BoxDecoration(
        gradient: GlobalVariables.appBarGradient(opacity: .15),
      ),
      child: Column(
        children: [
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 18),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/amazon_in.png',
                    width: 120,
                    height: 45,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.only(right: 0),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.notifications_outlined),
                      ),
                      Icon(
                        Icons.search,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Hello, ',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w300
                    ),
                    children: [
                      TextSpan(
                        text: user.name,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16,)
        ],
      ),
    );
  }
}
