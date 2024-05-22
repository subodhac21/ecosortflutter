import 'dart:convert';

import 'package:flutter/material.dart';
import "dart:io";
import "dart:math";
import 'package:ecosort/provider/resources/api.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;


class SignupProvider with ChangeNotifier{
  bool _loading = false;
  bool _loginStatus = false;
  bool _userError = false;
  bool _passError = false;
  bool _emailError = false;
  bool? _credentials;
  int? _userId;
  int? get userId => _userId;
  bool? get loginStatus => _loginStatus;
  bool? get userError => _userError;
  bool? get passError => _passError;
  bool? get emailError => _emailError;
  bool? get loading => _loading;
  bool? get credentials => _credentials;
  String? _username = "";
  String? get username => _username;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }
  void resetUser(){
    _userId = null;
    _username = null;
    _loginStatus = false;
  }

  Future<void> checkLogin(String username, String email,  String password) async {

    setLoading(true);

    final client = http.Client();
    String apiLink = Api().loginApi();

    try {
      var url = Uri.http(apiLink, 'register/');
      var response = await http.post(url, body: {'username': username,'email': email, 'password': password});
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (data['message'] == "Register successful") {
          _username = username;
          _loginStatus = true;
          _userId = data["user_id"];
          setLoading(false);
        }

      }
      if(response.statusCode == 400) {
        if (data.containsKey("username")) {
          if (data['username'][0] ==
              "A user with that username already exists.") {
            // _loginStatus = false;
            setLoading(false);
            _credentials = false;
          }
          else {
            _credentials = true;
            setLoading(false);
          }
        }
        else{
          _credentials = true;
          setLoading(false);
        }
        if (data.containsKey("email")) {
          if (data['email'][0] == "Enter a valid email address.") {
            // _loginStatus = false;
            setLoading(false);
            _emailError = true;
          }
          else {
            _emailError = false;
            setLoading(false);
          }
        }
        else{
          _emailError = false;
          setLoading(false);
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
        // print("error");

      }
    } on SocketException catch (e) {
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