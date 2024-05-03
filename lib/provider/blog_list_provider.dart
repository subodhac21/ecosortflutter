import 'dart:convert';

import 'package:ecosort/provider/resources/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:io";

import 'package:provider/provider.dart';

class BlogListProvider with ChangeNotifier{
  // bool _loading = false;
  // setLoading(bool value){
  //   _loading = value;
  //   notifyListeners();
  // }
  List _allData = [];
  List get allData => _allData;
  String _cat = "";
  String get cat => _cat;
  bool hasLoadedData = false;

  Future<void> getAllContent() async{
    String apiLink = Api().loginApi();
    final client = http.Client();

    // setLoading(true);
    try{
      var url = Uri.http(apiLink, 'getblogs/');
      var response = await http.get(url);
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _allData = data['data'];
        // _cat = data['category_name'];
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