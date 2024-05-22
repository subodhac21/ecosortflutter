import "package:ecosort/home_screen.dart";
import "package:ecosort/main.dart";
import "package:ecosort/pages/achievements.dart";
import "package:ecosort/pages/blog_list.dart";
import "package:ecosort/pages/camera_page.dart";
import "package:ecosort/pages/campaign_list.dart";
import "package:ecosort/pages/home_page.dart";
import "package:ecosort/provider/login_provider.dart";
import "package:ecosort/provider/signup_provider.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";
import "after_login.dart";


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
    final signProvider = Provider.of<SignupProvider>(context);
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

              icon: Icon(Icons.home_outlined, color: Color.fromRGBO(107,125,92, 1.0),),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.camera_sharp, color: Color.fromRGBO(107,125,92, 1.0),)),
              label: 'Take photo',
            ),
            NavigationDestination(
              icon: Badge(
                // label: Text('2'),
                child: Icon(Icons.emoji_events, color: Color.fromRGBO(107,125,92, 1.0),),
              ),
              label: 'Achievements',
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Increment',
        onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context)=>  CampaignList())
          );
        },
        child: const Icon(Icons.campaign, color: Colors.white, size: 28),
      ),
        appBar: AppBar(
          title: const Text('EcoSort-Waste Classification', style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          /// Header of the Drawer
          Material(
            color: const Color.fromRGBO(107,125,92, 1.0),
            child: InkWell(

            child: Container(
            padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: 24
          ),
          child:  Column(
            children: [
            const CircleAvatar(
            radius: 52,
            backgroundImage: NetworkImage(
          'https://cdn3.vectorstock.com/i/1000x1000/30/97/flat-business-man-user-profile-avatar-icon-vector-4333097.jpg'
          ),
          ),
          const SizedBox(height: 12,),
            Text('${loginProvider.username ?? signProvider.username}',
            style: const TextStyle(
            fontSize: 28,
            color: Colors.white
          ),),
      ElevatedButton(
                  onPressed: (){
                    loginProvider.resetUser();
                    signProvider.resetUser();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AfterLogin()),
                    );
                  },
                  child: const Text("Logout"),
                ),

    ],
    ),
    ),
    ),
    ),

    Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            leading: const Icon(Icons.home), title: const Text("Blog Content"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const BlogList()));
            },
          ),
        ],
      ),
    )

    /// Header Menu items

    ],
    ),),),
        body:  <Widget>[
          /// Home page
          Homepage(),

          /// Notifications page

           MyCamera(
            voidCallback: (){
              setState(() {
                currentPageIndex = 2  ;
              });
            }
          ),
          /// Messages page
         const Achievements(),
        ][currentPageIndex],
    );
  }
}
