import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../helpers/debouncer.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class ExpensesProvider extends ChangeNotifier {

  final String _baseUrl = '192.168.1.228:5000';
  final String _baseCloudinaryUrl = "https://api.cloudinary.com/v1_1/dtdvvx265/image/upload";

  File? newPictureFile;
  Expenditure? selectedExpenditure;
  bool isSaving = false;

  List<Expenditure> monthlyExpenses = [];
  
  

  void addExpenditure(Expenditure expenditure, String date) async {
    monthlyExpenses.add(expenditure);

    final Map<String,dynamic> body = expenditure.toJson();
    body["amount"] =  '${body["amount"]}';

    final url = Uri.http(_baseUrl,'/expenses/createExpenditure');
    await http.post(url, body: body);

    notifyListeners();
  }

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
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    final jsonData = await _getJsonData('/expenses/getMonthlyExpenses/$formattedDate');
    final List<Expenditure> expensesList = MonthlyExpensesResponse().expenditureListFromJson(jsonData);
    monthlyExpenses = [...monthlyExpenses, ...expensesList];
    notifyListeners();
  }

  void updateExpenditure() async {
    isSaving = true;
    notifyListeners();
 
    final Map<String,dynamic> body = selectedExpenditure!.toJson();
    body["amount"] =  '${body["amount"]}';

    final url = Uri.http(_baseUrl,'/expenses/updateExpenditure');
    await http.put(url, body: body);
    isSaving = false;
    notifyListeners();
 
  }

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


   Future<String?> uploadImage() async {
    
    if (  newPictureFile == null ) return null;

    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dtdvvx265/image/upload?upload_preset=ml_default');

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

}
