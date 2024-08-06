import 'package:amazon_clone/features/admin/admin_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'constatns/bottom_bar.dart';
import 'features/auth/screens/auth_screen.dart';
import 'features/auth/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) => init());
    super.initState();
  }

  init() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    await authService.getUserData(context);
    Navigator.of(context).pushReplacementNamed(userProvider.user.token.isEmpty
        ? AuthScreen.routeName
        : userProvider.user.type == "user"
            ? BottomBar.routeName
            : AdminScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
