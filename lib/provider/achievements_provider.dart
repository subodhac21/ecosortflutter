import 'dart:convert';

import 'package:ecosort/provider/resources/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:io";

class AchievementsProvider with ChangeNotifier{
  // bool _loading = false;
  // setLoading(bool value){
  //   _loading = value;
  //   notifyListeners();
  // }

  List _allData = [];
  List get allData => _allData;
  bool hasLoadedData = false;
  Future<void> getAllAchievementsById(int Id) async{
    String apiLink = Api().loginApi();
    final client = http.Client();
    // setLoading(true);
    try{
      var url = Uri.http(apiLink, 'allachieveById/');
      var response = await http.post(url, body: {"user_id": "$Id"});
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _allData = data;
        hasLoadedData = true;
        notifyListeners();
      }
    }
    on SocketException catch (e) {
      // Handle SocketException
      // print("error");


    } on http.ClientException catch (e) {
      // Handle http.ClientException
      // print("error");


    } finally {
      client.close(); //// Close the client when done
    }
  }
}