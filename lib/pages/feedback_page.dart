
import 'package:ecosort/logged_screen.dart';
import 'package:ecosort/pages/blog_list.dart';
import 'package:ecosort/provider/add_waste_provider.dart';
import 'package:ecosort/provider/blog_provider.dart';
import 'package:ecosort/provider/check_waste_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';



class FeedbackPage extends StatelessWidget {
  final id;
   FeedbackPage({super.key, required this.id});


  @override
  Widget build(BuildContext context) {


    // final allCampaign = Provider.of<CheckWasteProvider>(context, listen: false);

    // print(allCampaign.catName);
    // print(allContent.length);

    // var index = 1;
    //
    // switch (type){
    //   case "biological":
    //     index = 0;
    //   case "battery":
    //     index = 1;
    //   case "brown-glass":
    //     index = 2;
    //   case "cardboard":
    //     index = 3;
    //   case "clothes":
    //     index = 4;
    //   case  "green-glass":
    //     index = 5;
    //   case "metal":
    //     index = 6;
    //   case "paper":
    //     index = 7;
    //   case "plastic":
    //     index = 8;
    //   case "shoes":
    //     index = 9;
    //   case "trash":
    //     index = 10;
    //   case "white-glass":
    //     index = 11;
    //
    // }
    // document = HtmlWidget(allContent[index]['content']);
    // final type = Provider.of<CheckWasteProvider>(context, listen: false).catName;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Blog', style: TextStyle(color: Colors.white),),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(context, 
            MaterialPageRoute(builder: (context)=> const BlogList())
            ),
          ),
        ),
        body: FutureBuilder(
          future: Provider.of<BlogProvider>(context, listen: false).getAllContent(1),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child:
              Column(
              children: [
                const Hero(
                    tag: Text("Feedback"),
                    child: Image(
                        image: NetworkImage("https://img.freepik.com/free-photo/evaluation-feedback-customer-smiley-response_53876-123011.jpg"),
                        fit: BoxFit.cover,
                        width: 200)),
                const SizedBox(height: 10),
            ChangeNotifierProvider<BlogProvider>(
    create: (_) => BlogProvider(),
    builder: (context, _) {
      final blogItem = Provider.of<BlogProvider>(context);
      if (!blogItem.hasLoadedData) {
        // Call getAllUsers() only if data hasn't been loaded yet
        WidgetsBinding.instance.addPostFrameCallback((_) {
          blogItem.getAllContent(id);
        });
      }
      final content = blogItem.allData;
      final category = blogItem.cat;
      var document = HtmlWidget(content);
                return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                backgroundImage: NetworkImage("https://media.licdn.com/dms/image/D5603AQFYXLAzpogQ8g/profile-displayphoto-shrink_200_200/0/1688828441512?e=1719446400&v=beta&t=6u55urmMyzZa98zh0Pm-NZQm1BTzf-jdCwuFyHpxttY"),
                ),

                title: const Text(
                "${"Subodh"} ${"Acharya"}",
                style:  TextStyle(
                // color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
                subtitle: Text("2024/04/27",
                style: TextStyle(
            color: Colors.grey[800],
            fontSize: 16,
            ))),

            const SizedBox(height: 10),
            Text("${category}",
            style:  const TextStyle(
            fontSize: 35, fontWeight: FontWeight.w900)),
            const SizedBox(height: 10),
            document,
            ],
            ));
            }
            )
              ],
            ));

          }})

                      );
  }

}
