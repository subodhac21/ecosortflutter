import "dart:convert";
import "dart:io";
import "dart:math";
import 'package:ecosort/provider/resources/api.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import "package:shared_preferences/shared_preferences.dart";


class LoginProvider with ChangeNotifier{

  bool _loading = false;
  bool _loginStatus = false;
  bool _userError = false;
  bool _passError = false;
  bool? _credentials;
  bool? get loginStatus => _loginStatus;
  bool? get userError => _userError;
  bool? get passError => _passError;
  bool? get loading => _loading;
  bool? get credentials => _credentials;
  String _username = "";
  String? get username => _username;
  int? _userId;
  int? get userId => _userId;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> checkLogin(String username, String password) async {

    setLoading(true);

    final client = http.Client();
    String apiLink = Api().loginApi();

    try {
      var url = Uri.http(apiLink, 'login/');
      var response = await http.post(url, body: {'username': username, 'password': password});
      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        if (data['message'] == "Login successful") {
          _username = username;
          _userId = data["user_id"];
          _loginStatus = true;
          setLoading(false);
        }

      }
      if(response.statusCode == 401){
        if(data['error']=="Invalid credentials") {
          // _loginStatus = false;
          setLoading(false);
          _credentials = false;
        }

      }
      else{
        // _loginStatus = false;
        setLoading(false);
        _credentials = true;
      }

      if(response.statusCode == 400 || response.statusCode == 401) {
        if (username == "") {
          _userError = true;
          setLoading(false);
        }
        else{
          _userError = false;
          setLoading(false);

        }
        if (password == "") {
          _passError = true;
          setLoading(false);
        }
        else {
          _passError = false;
          setLoading(false);

        }
      } else {
        // Handle other status codes
        print("error");

      }
    } on SocketException catch (e) {
      // Handle SocketException
      print("error");


    } on http.ClientException catch (e) {
      // Handle http.ClientException
      print("error");


    } finally {
      client.close(); //// Close the client when done
    }

  }
}