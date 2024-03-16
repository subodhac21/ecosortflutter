import "package:ecosort/pages/garbage_card.dart";
import "package:ecosort/pages/user_card.dart";
import "package:ecosort/provider/user_provider.dart";
import "package:ecosort/provider/wastes_provider.dart";

import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../provider/login_provider.dart";

// import "package:provider/provider.dart";

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return SingleChildScrollView(
        child: Column(children: [
      Container(
        margin: const EdgeInsets.only(bottom: 0, top: 20),
        padding: const EdgeInsets.only(left: 20),
        child: const Text(
          "Users",
          style: TextStyle(fontSize: 25, color: Colors.brown),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 0),
        height: 220,
        child: ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider(),
            builder: (context, _) {
              final userProvider = Provider.of<UserProvider>(context);
              userProvider.getAllUsers();
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: userProvider.allData.length,
                itemBuilder: (BuildContext context, int index) {
                  return UserCard(
                      name: userProvider.allData[index]["username"],
                      email: userProvider.allData[index]['email'],
                      imageUrl:
                          "https://cdn3.vectorstock.com/i/1000x1000/30/97/flat-business-man-user-profile-avatar-icon-vector-4333097.jpg");
                },
              );
            }),
      ),
      Container(
        padding: EdgeInsets.all(20),
        child: Text("Waste Products", style: TextStyle(
          fontSize: 25,
        ))
      ),
      ChangeNotifierProvider<WastesProvider>(
          create: (_) => WastesProvider(),
          builder: (context, _) {
            final wastesProvider = Provider.of<WastesProvider>(context);
            wastesProvider.getAllWastes();
            return ListView.builder(
                scrollDirection: Axis.vertical,
                primary: false,
                shrinkWrap: true,
                itemCount: wastesProvider.allData.length,
                itemBuilder: (BuildContext context, int index) {
                  return GarbageCard(
                      title: wastesProvider.allData[index]["name"],
                      category: wastesProvider.allData[index]["category"],
                      cardImage: wastesProvider.allData[index]["image"],
                      supportingText: wastesProvider.allData[index]
                          ["description"],
                      username: wastesProvider.allData[index]["username"]);
                });
          }),

      // GarbageCard(),
      // GarbageCard(),
      // GarbageCard(),
      // GarbageCard(),
      // GarbageCard(),
    ]));
  }
}
