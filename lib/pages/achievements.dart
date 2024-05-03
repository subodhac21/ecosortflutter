import "package:ecosort/provider/achievements_provider.dart";
import "package:ecosort/provider/login_provider.dart";
import "package:ecosort/provider/signup_provider.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../provider/blog_provider.dart";
class Achievements extends StatelessWidget {
  const Achievements({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final signProvider = Provider.of<SignupProvider>(context);
     late var points = 0;
    return FutureBuilder(
      future: Provider.of<AchievementsProvider>(context, listen: false).getAllAchievementsById(loginProvider.userId ?? signProvider.userId!),
    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      else{
        final achieveProvider = Provider.of<AchievementsProvider>(context).allData;

        return SingleChildScrollView(
          child: Column(

            children: [
              Container(
                padding: const EdgeInsets.only(top: 40),
                child: const Text("Achievements", style: TextStyle(
                    fontSize: 24,
                  color: Color.fromRGBO(107,125,92, 1.0)
                ),),
              ),
              Container(
                padding: const EdgeInsets.only(top: 40),
                child:ChangeNotifierProvider<AchievementsProvider>(
                  create: (_) => AchievementsProvider(),
                  builder: (context, _) {


                    final achievementProvider = Provider.of<AchievementsProvider>(context);
                    if (!achievementProvider.hasLoadedData) {
                      // Call getAllUsers() only if data hasn't been loaded yet
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        achievementProvider.getAllAchievementsById(loginProvider.userId ?? signProvider.userId!);
                      });
                    }
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: achievementProvider.allData.length,
                      itemBuilder: (BuildContext context, int index) {
                        if(achievementProvider.allData.isEmpty){
                          return Center(
                            child:  Container(

                              child: const Text("Achievement is Empty"),
                            ),
                          );
                        }
                        else{
                          // print(achievementProvider.allData[index]['trophy']);
                          return  ListTile(
                            title: Text(achievementProvider.allData[index]['type']),
                            isThreeLine: true,
                            subtitle: Text(achievementProvider.allData[index]['description']),
                            leading:  Icon(Icons.emoji_events, color: achievementProvider.allData[index]['trophy'] =="gold" ? const Color.fromRGBO(225, 215, 0, 1) : achievementProvider.allData[index]['trophy'] =="silver" ? const Color.fromRGBO(192, 192, 192, 1) : const Color.fromRGBO(205, 127, 50, 1) ,),
                            trailing: Text("${achievementProvider.allData[index]['points']} points")
                          );
                        }

                      },
                    );
                  },
                ),
              ),

            ],
          ),
        );
      }
    }

    );
  }
}
