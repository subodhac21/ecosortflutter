import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/login_provider.dart';
import '../provider/user_provider.dart';
import '../provider/wastes_provider.dart';
import '../pages/garbage_card.dart';
import '../pages/user_card.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return FutureBuilder(
      future: Provider.of<WastesProvider>(context, listen: false).getAllWastes(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final allWastes = Provider.of<WastesProvider>(context).allData;
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 0, top: 20),
                  padding: const EdgeInsets.only(left: 20),
                  child: const Text(
                    "Friends",
                    style: TextStyle(fontSize: 25, color: Color.fromRGBO(107,125,92, 1.0)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 0),
                  height: 220,
                  child: ChangeNotifierProvider<UserProvider>(
                    create: (_) => UserProvider(),
                    builder: (context, _) {
                      final userProvider = Provider.of<UserProvider>(context);
                      if (!userProvider.hasLoadedData) {
                        // Call getAllUsers() only if data hasn't been loaded yet
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          userProvider.getAllUsers();
                        });
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: userProvider.allData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return UserCard(
                            name: userProvider.allData[index]["username"],
                            email: userProvider.allData[index]['email'],
                            imageUrl:
                            "https://cdn3.vectorstock.com/i/1000x1000/30/97/flat-business-man-user-profile-avatar-icon-vector-4333097.jpg",
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    "Waste Products",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromRGBO(107,125,92, 1.0)
                    ),
                  ),
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  shrinkWrap: true,
                  itemCount: allWastes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GarbageCard(
                      title: allWastes[index]["name"],
                      category: allWastes[index]["category"],
                      cardImage: allWastes[index]["image"],
                      supportingText: allWastes[index]["description"],
                      username: allWastes[index]["username"],
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
