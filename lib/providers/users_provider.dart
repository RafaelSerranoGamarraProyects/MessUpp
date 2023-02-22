import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UsersProvider extends ChangeNotifier {

  final String _baseAuthUrl = "identitytoolkit.googleapis.com";
  final String _firebaseToken = "AIzaSyAhMbulLyAp5Wgwu9KK4zzW0Q62DJ55lQk";

  final storage = const FlutterSecureStorage();
  

  String _user = "";

  String get user => _user;

  set user( String value){
    _user = value;
    notifyListeners();
  }


  UsersProvider();

  Future<Map<String, dynamic>> login(String email, String password) async{
		final requestBody = {
			"email" : email,
			"password" : password
		};

    final uri = Uri.https(_baseAuthUrl, '/v1/accounts:signInWithPassword', { 'key' : _firebaseToken , "returnSecureToken" : "true"});

    final response = await http.post(uri, body: json.encode(requestBody));
    final Map<String, dynamic> decodedResp = json.decode(response.body);
    
    return decodedResp;
  }

  Future<Map<String, dynamic>> register(String email, String password)async {

    final Map<String, dynamic> auth = {
      "email" : email,
      "password" : password,
    };

    final uri = Uri.https(_baseAuthUrl, '/v1/accounts:signUp', { 'key' : _firebaseToken });

    final response = await http.post(uri, body: json.encode(auth));
    final Map<String, dynamic> decodedResp = json.decode(response.body);

    return decodedResp;
  }


  void logOut() async{
    await storage.delete(key: 'idToken');
  }

  Future<String> readToken()async {
    return await storage.read(key: 'email') ?? '' ;
  }

}
