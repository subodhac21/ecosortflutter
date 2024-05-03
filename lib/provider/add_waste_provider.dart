import "dart:convert";
import "dart:io";
import "dart:math";
import 'package:ecosort/provider/resources/api.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddWasteProvider with ChangeNotifier{

  File? _savedImage;
  bool _loading = false;
  bool _loading1 = false;
  File? get savedImage => _savedImage;
  String? _catName;
  String? get catName => _catName;
  bool _loaded = false;
  bool? get loaded => _loaded;
  bool? get loading => _loading;
  bool? get loading1 => _loading1;
  void setLoaded(){
    _loaded = false;
  }
  void saveTheImageLocal(File image){
    _savedImage = image;
    // notifyListeners();
  }
  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }
  setLoading1(bool value){
    _loading1 = value;
    notifyListeners();
  }

  Future<void> addWastes(String name, String description, File imageFile, int userId, String username)async{
    // print(userId.toString());
    setLoading(true);
    String apiLink = Api().loginApi();
    var url = Uri.parse("http://$apiLink/add_waste/");
    // Create multipart request
    var request = http.MultipartRequest('POST', url);

    // Add image file to request
    var image = await http.MultipartFile.fromPath('image', imageFile.path);
    request.files.add(image);

    // Add other form fields if needed
    request.fields['name'] = name;
    request.fields['description'] = description;
    // request.fields['category'] = "biodegradable";
    request.fields['user_id'] = userId.toString();
    request.fields['username'] = username;
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now).replaceAll(RegExp('/'), "-");
    // Send request
    var response = await request.send();
    var streamedResponse = await response.stream.bytesToString();
    var jsonResponse = json.decode(streamedResponse);
    if(jsonResponse['message'] == "added"){
      _catName = jsonResponse['category'];
      var url = Uri.http(apiLink, '/addAchievement/');
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

      var response = await http.post(url, body: {'date': formattedDate, 'type': _catName, "description": description, "trophy": "$cup", "points": "$points", "user": "$userId", "username": username});
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setLoading(false);
      }
    }
    // print(streamedResponse);
    // Check if request was successful
    if (response.statusCode == 201) {
      setLoading(false);

      // print('Image uploaded successfully');
    } else {
      setLoading(false);

      // print('Failed to upload image: ${response.reasonPhrase}');
    }
  }
}