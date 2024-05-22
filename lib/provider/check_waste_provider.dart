
import "dart:convert";
import "dart:io";
import "dart:math";
import 'package:ecosort/provider/resources/api.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class CheckWasteProvider with ChangeNotifier {


  bool _loading = false;
  bool? get loading => _loading;
  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  String? _catName;
  String? get catName => _catName;
  int? _points;
  int? get points => _points;

  void setCatName(String? catname){
    _catName = catName;
  }
  Future<void> checkWaste(File imageFile) async {
    setLoading(true);
    String apiLink = Api().loginApi();
    var url = Uri.parse("http://$apiLink/checkwaste/");
    // Create multipart request
    var request = http.MultipartRequest('POST', url);

    // Add image file to request
    var image = await http.MultipartFile.fromPath('image', imageFile.path);
    request.files.add(image);


    // Send request
    var response = await request.send();
    try{

      var streamedResponse = await response.stream.bytesToString();
      var jsonResponse = json.decode(streamedResponse);

      if (jsonResponse['message'] == "added") {
        _catName = jsonResponse['category'];
        var points = 0;
        var cup = "";
        switch (_catName){
          case "biological":
            points = 50;
            cup = "bronze";
          case "battery":
            points = 50;
            cup = "bronze";
          case "brown-glass":
            points = 80;
            cup = "silver";
          case "cardboard":
            points = 50;
            cup = "bronze";
          case "clothes":
            points= 50;
            cup = "bronze";
          case  "green-glass":
            points = 80;
            cup = "silver";
          case "metal":
            points = 80;
            cup = "silver";
          case "paper":
            points = 50;
            cup = "bronze";
          case "plastic":
            points = 100;
            cup = "gold";
          case "shoes":
            points = 50;
            cup = "bronze";
          case "trash":
            points = 100;
            cup = "gold";
          case "white-glass":
            cup = "silver";
            points = 80;

        }
        _points = points;
        setLoading(false);

      }
    }
    finally {
    }
    // print(_loading);
    // print(streamedResponse);
    // Check if request was successful
    if (response.statusCode == 201) {
      print('Image checked successfully');
      setLoading(false);
    } else {
      print('Failed to upload image: ${response.reasonPhrase}');
    }
  }
}