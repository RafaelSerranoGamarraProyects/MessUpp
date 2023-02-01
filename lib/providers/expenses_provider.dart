import 'dart:async';
import 'package:flutter/widgets.dart';
import '../helpers/debouncer.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class ExpensesProvider extends ChangeNotifier {

  final String _baseUrl = '192.168.1.228:5000';

  List<Expenditure> monthlyExpenses = [];
  


  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Expenditure>> _suggestionStreamContoller = StreamController.broadcast();
  Stream<List<Expenditure>> get suggestionStream => _suggestionStreamContoller.stream;

  ExpensesProvider() {
    getMonthlyExpenses();
  }

  Future<String> _getJsonData(String endpoint) async {
    final url = Uri.http(_baseUrl,endpoint);

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }
  
  void getMonthlyExpenses() async{
    final jsonData = await _getJsonData('/expenses/getMonthlyExpenses/2023-01-17');
    final List<Expenditure> expensesList = MonthlyExpensesResponse().expenditureListFromJson(jsonData);
    monthlyExpenses = [...monthlyExpenses, ...expensesList];
    notifyListeners();
  }
  double getTotalSpend(){
    double total = 0;
    for (var expenditure in monthlyExpenses) {
      total = total + expenditure.amount;
    }
    return total;
  }




/*   Future<List<Expenditure>> searchExpenses(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie');

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  } */

 /*  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      // print('Tenemos valor a buscar: $value');
      final results = await searchMovies(value);
      _suggestionStreamContoller.add(results);
    }; 

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301)).then((_) => timer.cancel());
  }*/
}
