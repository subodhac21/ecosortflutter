import 'dart:ffi';

import 'package:ecosort/pages/admin_page.dart';
import 'package:ecosort/provider/campaign_provider.dart';
import 'package:ecosort/provider/login_provider.dart';
import 'package:ecosort/provider/signup_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CampaignList extends StatefulWidget {
  @override
  State<CampaignList> createState() => _CampaignListState();
}

class _CampaignListState extends State<CampaignList> {
  List<String> todos = [];

  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final signProvider = Provider.of<SignupProvider>(context);

    final allCampaign = Provider.of<CampaignProvider>(context, listen: false);
    allCampaign.getAllCampaigns();
    return  FutureBuilder(
        future: Provider.of<CampaignProvider>(context, listen: false).getAllCampaigns(),
    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return  Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Campaigns Lists', style: TextStyle(color: Colors.white),),
              // backgroundColor: const Color.fromRGBO(75,147,233, 1.0),
            ),
            body: const Center(child: CircularProgressIndicator()));
      }
      else {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Campaigns Lists', style: TextStyle(color: Colors.white),),
          ),
          floatingActionButton: Visibility(
            visible: (loginProvider.username ?? signProvider.username) == "admin" ? true: false ,
            child: FloatingActionButton(
              backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
              tooltip: 'Increment',
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>  const AdminPage())
                );
              },
              child: const Icon(Icons.web, color: Colors.white, size: 28),
            ),

          ),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    const Text("List of Campaigns", style: TextStyle(
                        fontSize: 24,fontWeight: FontWeight.bold, color: Color.fromRGBO(107,125,92, 1.0)
                    ),),
                    const SizedBox(height: 18),
                    allCampaign.allData.isEmpty ? Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.all(12),
                      child: const Text("Data not found", style: TextStyle(fontSize: 18),),
                    ) :ListView.builder(
                      scrollDirection: Axis.vertical,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: allCampaign.allData.length,
                      itemBuilder: (BuildContext context, int index) {

                        return Container(

                          padding: const EdgeInsets.all(4),
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(

                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade600,
                                    spreadRadius: 1,
                                    blurRadius: 15,
                                    offset: const Offset(0, 15)
                                ), // no shadow color set, defaults to black
                              ]
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                // width: 400,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${index+1}."),
                                    Text("${allCampaign
                                        .allData[index]["campaign_name"]}",
                                      style: const TextStyle(
                                          fontSize: 16
                                      ),),
                                    Text("Start Date: ${allCampaign
                                        .allData[index]["start_date"]}",
                                      style: const TextStyle(
                                          fontSize: 16
                                      ),),
                                    Text("End Date: ${allCampaign
                                        .allData[index]["end_date"]}",
                                      style: const TextStyle(
                                          fontSize: 16
                                      ),),
                                    Container(
                                      child: Text("Aim: ${allCampaign
                                          .allData[index]["objective"]}",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color.fromRGBO(107,125,92, 1.0)
                                        ),),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  "${allCampaign.allData[index]["location"]}", style: const TextStyle(fontSize: 18),),
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    });

  }
}
