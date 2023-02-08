import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:tfg_app/utils/categories_options.dart';
import 'package:tfg_app/utils/category_data.dart';
import '../helpers/debouncer.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class ObjetivesProvider extends ChangeNotifier {

  final String _baseUrl = '192.168.1.228:5000';

  Objetive monthlyObjetive  = Objetive(
    date: DateTime.now(), amount: 0, description: "no-description", isAchived: false, userId: "");

  List<CategoryData> spentByCategoryList = [];


  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Expenditure>> _suggestionStreamContoller = StreamController.broadcast();
  Stream<List<Expenditure>> get suggestionStream => _suggestionStreamContoller.stream;

  ObjetivesProvider(User user) {
    getMonthlyObjetive(user.id);
    getTotalByCategory(user.id);
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

  void getTotalByCategory(String userId) async{
    var listCategories = CategoriesOptions.categories;
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    
    for (var category in listCategories) {
      var jsonString = await _getJsonData('/objetives/getTotalExpensesByCategory/$formattedDate/$userId/$category');
      GetSpentByCategoryResponse resultOfRequest = getSpentByCategoryResponseFromJson(jsonString);
      spentByCategoryList.add(CategoryData(resultOfRequest.category, resultOfRequest.total ));

    }
    
    notifyListeners();
  }




/*   Future<List<Expenditure>> searchExpenses(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie');

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  } */

}
