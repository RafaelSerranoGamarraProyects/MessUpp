import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class ObjetivesProvider extends ChangeNotifier {

  final String _baseUrl = '192.168.1.228:5000';

  Objetive monthlyObjetive  = Objetive(
    date: DateTime.now(), amount: 0, description: "no-description", isAchived: false, userId: "");

  late User _userLogged;

  User get userLogged => _userLogged;

  set userLogged (User value){
    _userLogged = value;
    notifyListeners();
  }
  
  ObjetivesProvider(User user) {
    userLogged = user;
    getMonthlyObjetive(user.id);
  }



  Future<String> _getJsonData(String endpoint) async {
    final url = Uri.http(_baseUrl,endpoint);

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }
  
  void getMonthlyObjetive(String userId) async{
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    final jsonData = await _getJsonData('/objetives/getMonthlyObjetive/$formattedDate/$userId');
    final Objetive objetive = objetiveFromJson(jsonData);
    monthlyObjetive  = objetive;
    notifyListeners();
  }

  void checkObjetive(double total) {
    total >= monthlyObjetive.amount 
      ? monthlyObjetive.isAchived = true
      : monthlyObjetive.isAchived = false;
    
    notifyListeners();
  }

}
