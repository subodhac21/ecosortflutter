import 'dart:convert';
import 'package:ecosort/logged_screen.dart';
import 'package:ecosort/pages/blog_card.dart';
import 'package:ecosort/pages/blog_content.dart';
import 'package:ecosort/pages/feedback_page.dart';
import 'package:ecosort/provider/blog_list_provider.dart';
import 'package:ecosort/provider/blog_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BlogList extends StatefulWidget {
  const BlogList({super.key});
  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  List data = [];
  bool isLoading = true;



  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
        future: Provider.of<BlogListProvider>(context, listen: false).getAllContent(),
    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
            appBar: AppBar(title: Text('Blog List'),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoggedScreen()));
                },
              ),
            ),
            body: Center(child: CircularProgressIndicator()));
      } else {
        return Scaffold(
          appBar: AppBar(title: Text('Blog List'),
          centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoggedScreen()));
              },
            ),
          ),
          body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(children: [
                  const SizedBox(height: 15),
                  ChangeNotifierProvider<BlogListProvider>(
                      create: (_) => BlogListProvider(),
                      builder: (context, _) {
                        final blogList = Provider.of<BlogListProvider>(context);
                        if (!blogList.hasLoadedData) {
                          // Call getAllUsers() only if data hasn't been loaded yet
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            blogList.getAllContent();
                          });
                        }
                        return SizedBox(
                          // height: 1000,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              primary: false,
                              shrinkWrap: true,
                              itemCount: blogList.allData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return BlogCard(
                                    image: "https://images.pexels.com/photos/262508/pexels-photo-262508.jpeg?cs=srgb&dl=pexels-pixabay-262508.jpg&fm=jpg",
                                    title: blogList.allData[index]['blog_title'],
                                    slug: blogList.allData[index]['blog_title'],
                                    desc: blogList.allData[index]['blog_content'].substring(1, 20),
                                    author:
                                    "Subodh Acharya",
                                    authorImg: "https://media.licdn.com/dms/image/D5603AQFYXLAzpogQ8g/profile-displayphoto-shrink_200_200/0/1688828441512?e=1720051200&v=beta&t=WCy7th0rMPYlDXLXi3lsGriGHR2ADDC0LvdF9E8vPus",
                                    press: () {

                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>  FeedbackPage(id: blogList.allData[index]['id'])));
                                    }
                                );
                              }
                          ),
                        );
                      }

                  )
                ]),
              )),
        );
      }
    }

    );

    }
}