import 'dart:math';

import 'package:ecosort/after_login.dart';
import 'package:ecosort/home_screen.dart';
import 'package:ecosort/logged_screen.dart';
import 'package:ecosort/pages/garbage_card.dart';
import 'package:ecosort/provider/add_waste_provider.dart';
import 'package:ecosort/provider/login_provider.dart';
import 'package:ecosort/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  Provider.debugCheckInvalidValueType = null;
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  Widget pushedWidget = const HomeScreen();
  @override
  Widget build(BuildContext context) {


    return  MaterialApp(
        theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home:  MultiProvider(
        providers: [
          Provider<LoginProvider>(create: (_) => LoginProvider()),
          Provider<UserProvider>(create: (_) => UserProvider()),
          Provider<AddWasteProvider>(create: (_) => AddWasteProvider()),

        ],

      // ChangeNotifierProvider(
      //     create: (_) => LoginProvider(),
          child: const AfterLogin(),
      )
    );
  }
}
