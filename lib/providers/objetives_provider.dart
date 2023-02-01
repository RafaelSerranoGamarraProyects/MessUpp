import 'dart:async';
import 'package:flutter/widgets.dart';
import '../helpers/debouncer.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class ObjetivesProvider extends ChangeNotifier {

  final String _baseUrl = '192.168.1.228:5000';

  Objetive monthlyObjetive  = Objetive(
    id: "", date: DateTime.now(), amount: 0, description: "no-description", isAchived: false);


  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Expenditure>> _suggestionStreamContoller = StreamController.broadcast();
  Stream<List<Expenditure>> get suggestionStream => _suggestionStreamContoller.stream;

  ObjetivesProvider() {
    getMonthlyObjetive();
  }

  Future<String> _getJsonData(String endpoint) async {
    final url = Uri.http(_baseUrl,endpoint);

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }
  
  void getMonthlyObjetive() async{
    final jsonData = await _getJsonData('/objetives/getMonthlyObjetive/2023-01-17');
    final Objetive objetive = objetiveFromJson(jsonData);
    monthlyObjetive  = objetive;
    notifyListeners();
  }




/*   Future<List<Expenditure>> searchExpenses(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie');

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  } */

}
