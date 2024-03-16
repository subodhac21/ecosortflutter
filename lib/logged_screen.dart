import "package:ecosort/home_screen.dart";
import "package:ecosort/main.dart";
import "package:ecosort/pages/camera_page.dart";
import "package:ecosort/pages/home_page.dart";
import "package:ecosort/provider/login_provider.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";


class LoggedScreen extends StatefulWidget {
  LoggedScreen({super.key});

  @override
  State<LoggedScreen> createState() => _LoggedScreenState();
}

class _LoggedScreenState extends State<LoggedScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final ThemeData theme = Theme.of(context);
    return  Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.amber,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.camera_sharp)),
              label: 'Take photo',
            ),
            NavigationDestination(
              icon: Badge(
                label: Text('2'),
                child: Icon(Icons.emoji_events),
              ),
              label: 'Achievements',
            ),
          ],
        ),
        appBar: AppBar(
          title: const Text('EcoSort-Waste Classification'),
          backgroundColor: const Color.fromRGBO(75,147,233, 1.0),
        ),
        drawer: Drawer(
          child:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<LoginProvider>(
                  builder: (context, value, child){
                    String? username = value.username;
                    return  Text("Hello $username");

                  },
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  MyApp()),
                    );
                  },
                  child: const Text("Logout"),
                ),

              ],
            ),
          ),
        ),
        body:  <Widget>[
          /// Home page
         const Homepage(),

          /// Notifications page

          const MyCamera(),
          /// Messages page
          Container(
            child: const Text("Achievements"),
          ),
        ][currentPageIndex],
    );
  }
}
