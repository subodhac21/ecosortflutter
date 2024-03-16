import 'package:ecosort/home_screen.dart';
import 'package:ecosort/logged_screen.dart';
import 'package:ecosort/provider/login_provider.dart';
import 'package:ecosort/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AfterLogin extends StatefulWidget {
  const AfterLogin({super.key});

  @override
  State<AfterLogin> createState() => _AfterLoginState();
}

class _AfterLoginState extends State<AfterLogin> {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<LoginProvider>(
      create: (_) => LoginProvider(), // Assuming your LoginProvider requires no parameters in its constructor
      builder: (context, _) {
        final loginProvider = Provider.of<LoginProvider>(context);
        if (loginProvider.loading == false && loginProvider.loginStatus == true) {
          return LoggedScreen();
        } else {
          return const HomeScreen();
        }
      },
    );

  }
}
