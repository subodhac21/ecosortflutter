import 'dart:async';
import 'dart:math';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ecosort/provider/blog_list_provider.dart';
import 'package:ecosort/provider/blog_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ecosort/after_login.dart';
import 'package:ecosort/home_screen.dart';
import 'package:ecosort/logged_screen.dart';
import 'package:ecosort/pages/feedback_page.dart';
import 'package:ecosort/pages/garbage_card.dart';
import 'package:ecosort/provider/achievements_provider.dart';
import 'package:ecosort/provider/add_waste_provider.dart';
import 'package:ecosort/provider/campaign_provider.dart';
import 'package:ecosort/provider/check_waste_provider.dart';
import 'package:ecosort/provider/login_provider.dart';
import 'package:ecosort/provider/signup_provider.dart';
import 'package:ecosort/provider/user_provider.dart';
import 'package:ecosort/provider/wastes_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){

  Provider.debugCheckInvalidValueType = null;
  runApp( MyApp());
}


class MainLogo extends StatefulWidget{
  const MainLogo({super.key});

  @override
  State<MainLogo> createState() => _MainLogoState();
}

class _MainLogoState extends State<MainLogo> {
  @override
  void initState() {

    super.initState();

    Future.delayed(

      Duration(seconds: 3),

          () {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(builder: (context) => MyApp()),

        );

      },

    );

  }
  @override
  Widget build(BuildContext context) {

    return AnimatedSplashScreen(
      splashIconSize: 400,
      duration: 3000,
      backgroundColor: Colors.white,
      splash: Image.asset('assets/icons/Eco1.png'),
      nextScreen: const AfterLogin(),
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}

class MyApp extends StatelessWidget {

   MyApp({super.key});

  Widget pushedWidget = const HomeScreen();

  @override
  Widget build(BuildContext context) {


    return  MultiProvider(
          providers: [
            //
            ChangeNotifierProvider(create: (context) => LoginProvider()),
            ChangeNotifierProvider(create: (context) => AchievementsProvider()),
            ChangeNotifierProvider(create: (context) => UserProvider()),
            // ChangeNotifierProvider(create: (context) => AddWasteProvider()),
            // ChangeNotifierProvider(create: (context) => CheckWasteProvider()),
            ChangeNotifierProvider(create: (context) => WastesProvider()),
            ChangeNotifierProvider(create: (context) => SignupProvider()),
            ChangeNotifierProvider(create: (context) => CampaignProvider()),
            ChangeNotifierProvider(create: (context) => BlogProvider()),
            ChangeNotifierProvider(create: (context) => BlogListProvider()),
            Provider(create: (context) => CheckWasteProvider()),
            Provider(create: (context) => AddWasteProvider()),



          ],
          builder: (context, child){
            //final add_waste_provider = Provider.of<AddWasteProvider>(context);

            return MaterialApp(
                theme: ThemeData(
                    brightness: Brightness.light,
                    primaryColor: const Color.fromRGBO(75,147,233, 1.0),
                    primarySwatch: Colors.green,
                  appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.white),
                    color: Color.fromRGBO(107,125,92, 1.0), //<-- SEE HERE
                  ),
                ),
            debugShowCheckedModeBanner: false,
              // home: const AfterLogin()
              home: const MainLogo(),
            );
          },
        // ChangeNotifierProvider(
        //     create: (_) => LoginProvider(),


        );


  }
}
