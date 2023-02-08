import 'dart:async';
import 'package:flutter/widgets.dart';
import '../helpers/debouncer.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class UsersProvider extends ChangeNotifier {

  final String _baseUrl = '192.168.1.228:5000';

  User _user = User(age: 0, dni: '', email: '', id: '', name: '',
	 password: '', profileImage: '', surname: '', telephoneNumber: 0,);

  User get user => _user;

  set user( User value){
    _user = value;
    notifyListeners();
  }

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Expenditure>> _suggestionStreamContoller = StreamController.broadcast();
  Stream<List<Expenditure>> get suggestionStream => _suggestionStreamContoller.stream;

  UsersProvider();

  Future<String> _getJsonData(String endpoint) async {
    final url = Uri.http(_baseUrl,endpoint);

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }
  

  Future<String> _postJsonData(String endpoint, Map<String,dynamic> body) async {
    final url = Uri.http(_baseUrl,endpoint);

    // Await the http get response, then decode the json-formatted response.
    final response = await http.post(url, body: body);
    return response.body;
  }


  void login(String email, String password) async{
		final requestBody = {
			"email" : email,
			"password" : password
		};
    final jsonData = await _postJsonData('/users/login',requestBody);
    final User userLogged = userFromJson(jsonData);
    user = userLogged;
  
  }
}
