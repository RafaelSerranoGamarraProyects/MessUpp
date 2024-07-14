import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:messup/models/models.dart';

class UsersProvider extends ChangeNotifier {

  final String _baseAuthUrl = "identitytoolkit.googleapis.com";
  final String _firebaseToken = "AIzaSyAhMbulLyAp5Wgwu9KK4zzW0Q62DJ55lQk";
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('user');


  final storage = const FlutterSecureStorage();
  
  bool getUserFirstTime = false;
  String _userEmail = "";
  User? userLogged;

  String get user => _userEmail;
  

  set user( String value){
    _userEmail = value;
    notifyListeners();
  }


  UsersProvider();

  void getLoggedUser() async{    
    final ref = usersCollection.withConverter(
      fromFirestore: User.fromFirestore,
      toFirestore: (User requestedUser, _) => requestedUser.toFirestore(),
    );
    
    var snapshot = await ref.where('email', isEqualTo: _userEmail).get();  
    var users = snapshot.docs.map((doc) => doc.data());

    if (user.isEmpty) {
      userLogged = User(email: "rafael.serrano@gmail.com", password: "Bargas_16");
    } else {
      userLogged = users.first;
    }
    getUserFirstTime = true;
    notifyListeners();

  }

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
    await storage.delete(key: 'email');

  }

  Future<String> readToken() async {
    return await storage.read(key: 'email') ?? '' ;
  }

  void createUser(User user) async {
    final Map<String,dynamic> body = user.toJson();
    await usersCollection.doc().set(body);
  }

    void addExpenditure(Expenditure expenditure) async {

    
    notifyListeners();
  } 

}
