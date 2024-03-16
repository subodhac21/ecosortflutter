import "dart:convert";
import "dart:io";
import "dart:math";
import 'package:ecosort/provider/resources/api.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class AddWasteProvider with ChangeNotifier{

  File? _savedImage;
  File? get savedImage => _savedImage;

  void saveTheImageLocal(File image){
    _savedImage = image;
    // notifyListeners();
  }
  Future<void> addWastes(String name, String description, File imageFile, int userId, String username)async{
    print(userId.toString());
    String apiLink = Api().loginApi();
    var url = Uri.parse("http://"+apiLink + "/add_waste/");
    // Create multipart request
    var request = http.MultipartRequest('POST', url);

    // Add image file to request
    var image = await http.MultipartFile.fromPath('image', imageFile.path);
    request.files.add(image);

    // Add other form fields if needed
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['category'] = "biodegradable";
    request.fields['user_id'] = userId.toString();
    request.fields['username'] = username;

    // Send request
    var response = await request.send();
    print(response);
    // Check if request was successful
    if (response.statusCode == 201) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image: ${response.reasonPhrase}');
    }
  }
}