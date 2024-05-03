import 'dart:convert';

import 'package:ecosort/provider/resources/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:io";

import 'package:provider/provider.dart';

class BlogProvider with ChangeNotifier{
  // bool _loading = false;
  // setLoading(bool value){
  //   _loading = value;
  //   notifyListeners();
  // }
  String _allData = "";
  String get allData => _allData;
  String _cat = "";
  String get cat => _cat;
  bool hasLoadedData = false;

  Future<void> getAllContent(int id) async{
    String apiLink = Api().loginApi();
    final client = http.Client();

    // setLoading(true);
    try{
      var url = Uri.http(apiLink, 'getContentByName/');
      // print(id);
      var response = await http.post(url, body: {"id": "$id"});
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _allData = data["content"];
        _cat = data['title'];
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