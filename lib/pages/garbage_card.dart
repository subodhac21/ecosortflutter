import 'package:flutter/material.dart';
import "../provider/resources/api.dart";

class GarbageCard extends StatelessWidget {



  String title;
  String category;
  String cardImage;
  String supportingText;
  String username;

  GarbageCard({super.key, required this.title, required this.category, required this.cardImage, required this.supportingText, required this.username});
  @override
  Widget build(BuildContext context) {
    String apiLink = Api().loginApi();

      return Card(
          elevation: 4.0,
          child: Column(
            children: [
              ListTile(
                title: Text(title),
                subtitle: Text(category),
                trailing: Text(username),
              ),
              Container(
                height: 200.0,
                child: Ink.image(
                  image: NetworkImage("http://"+apiLink+"/static/"+cardImage),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                child: Text(supportingText),
              ),
              // ButtonBar(
              //   children: [
              //     TextButton(
              //       child: const Text('CONTACT AGENT'),
              //       onPressed: () {/* ... */},
              //     ),
              //     TextButton(
              //       child: const Text('LEARN MORE'),
              //       onPressed: () {/* ... */},
              //     )
              //   ],
              // )
            ],
          ));
    }
  }
