import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:tfg_app/utils/utils.dart';
import '../helpers/debouncer.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class ExpensesProvider extends ChangeNotifier {

  late User _user;

  final String _baseUrl = '192.168.1.228:5000';
  final String _baseCloudinaryUrl = "https://api.cloudinary.com/v1_1/dtdvvx265/image/upload";

  File? newPictureFile;
  Expenditure? selectedExpenditure;
  bool isSaving = false;
  double totalPreviousMonth = -1;

  List<Expenditure> monthlyExpenses = [];
  List<CategoryData> spentByCategoryList = [];
  

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Expenditure>> _suggestionStreamContoller = StreamController.broadcast();
  Stream<List<Expenditure>> get suggestionStream => _suggestionStreamContoller.stream;

  User get user=> _user;

  set user (User value){
    _user = value;
    notifyListeners();
  }

  ExpensesProvider(User user){
    user = user;

    getMonthlyExpenses(user.id);
    getTotalByCategory(user.id);
    getTotalSpendLastMonth(user.id);
      
  }

  Future<String> _getJsonData(String endpoint) async {
    final url = Uri.http(_baseUrl,endpoint);
    final response = await http.get(url);
    return response.body;
  }
  
  //INITIALIZING METHODS

  void getMonthlyExpenses(String userId) async{
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    final jsonData = await _getJsonData('/expenses/getMonthlyExpenses/$formattedDate/$userId');
    final List<Expenditure> expensesList = MonthlyExpensesResponse().expenditureListFromJson(jsonData);
    monthlyExpenses = [...monthlyExpenses, ...expensesList];
    notifyListeners();
  }
  
   void getTotalByCategory(String userId) async{
    var listCategories = CategoriesOptions.categories;
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    
    for (var category in listCategories) {
      var jsonString = await _getJsonData('/expenses/getTotalExpensesByCategory/$formattedDate/$userId/$category');
      GetSpentByCategoryResponse resultOfRequest = getSpentByCategoryResponseFromJson(jsonString);
      spentByCategoryList.add(CategoryData(resultOfRequest.category, resultOfRequest.total ));
    }
    notifyListeners();
  }


  // CRUD Methods

  void addExpenditure(Expenditure expenditure, String date) async {
    monthlyExpenses.add(expenditure);

    final Map<String,dynamic> body = expenditure.toJson();
    body["amount"] =  '${body["amount"]}';

    final url = Uri.http(_baseUrl,'/expenses/createExpenditure');
    await http.post(url, body: body);
    
    for (var categoryData in spentByCategoryList) {
      if(categoryData.category == expenditure.category) categoryData.amount += expenditure.amount;
    }
    
    notifyListeners();
  }

  void updateExpenditure() async {
    isSaving = true;
    notifyListeners();
 
    final Map<String,dynamic> body = selectedExpenditure!.toJson();
    body["amount"] =  '${body["amount"]}';
    print(body);
    final url = Uri.http(_baseUrl,'/expenses/updateExpenditure/${selectedExpenditure!.id}');
    await http.put(url, body: body);

    isSaving = false;
    notifyListeners();

  }


  //AUXILIARY METHODS

  double getTotalSpend(){
    double total = 0;
    for (var expenditure in monthlyExpenses) {
      total = total + expenditure.amount;
    }
    return total;
  }

  void updateSelectedImage(String path){
    selectedExpenditure!.image = path;
    newPictureFile = File.fromUri( Uri(path: path));
    notifyListeners();
  }

  double getAmountByCategory(String category){
    var result = 0.00;
    for (var categoryData in spentByCategoryList) {
      if(categoryData.category == category) result = categoryData.amount;
    }
    return result;
  }


   Future<String?> uploadImage() async {
    
    if (  newPictureFile == null ) return null;

    notifyListeners();

    final url = Uri.parse('$_baseCloudinaryUrl?upload_preset=ml_default');

    final imageUploadRequest = http.MultipartRequest('POST', url );

    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      //ALGO SALIO MAL
      return null;
    }

    newPictureFile = null;

    final decodedData = json.decode( resp.body );
    return decodedData['secure_url'];

  }

  void getTotalSpendLastMonth(String userId)  async {
    double total = 0.00;
    final now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    var lastMonthDate = now.subtract(const Duration(days: 31));
    String formattedDate = formatter.format(lastMonthDate);

    final jsonData = await _getJsonData('/expenses/getMonthlyExpenses/$formattedDate/$userId');
    final List<Expenditure> expensesList = MonthlyExpensesResponse().expenditureListFromJson(jsonData);
    
    for (var expenditure in expensesList) {
      total = total + expenditure.amount;
    }
    totalPreviousMonth = total;
    notifyListeners();
  }

}
