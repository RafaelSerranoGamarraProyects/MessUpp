import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:tfg_app/utils/utils.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class ExpensesProvider extends ChangeNotifier {

  String _user = "";

  final String _baseCloudinaryUrl = "https://api.cloudinary.com/v1_1/dtdvvx265/image/upload";
  final CollectionReference expensesCollection = FirebaseFirestore.instance.collection('expenditures');

  File? newPictureFile;
  Expenditure? selectedExpenditure;
  bool isSaving = false;

  List<Expenditure> monthlyExpenses = [];
  List<CategoryData> spentByCategoryList = [];

  String get user=> _user;

  set user (String value){
    _user = value;
    notifyListeners();
  }

  ExpensesProvider(String userEmail){
    user = user;
    getMonthlyExpenses(userEmail);

    for (var category in CategoriesOptions.categories) {
      getTotalByCategory(category);
    }
  }
  
  //INITIALIZING METHODS

  void getMonthlyExpenses(String userEmail) async{
    DateTime firstDayNextMonth = DateTime.utc(DateTime.now().year, DateTime.now().month + 1);
    DateTime lastDayPreviousMonth = DateTime.utc(DateTime.now().year, DateTime.now().month, 0);
    
    final ref = expensesCollection.withConverter(
      fromFirestore: Expenditure.fromFirestore,
      toFirestore: (Expenditure expenditure, _) => expenditure.toFirestore(),
    );
    
    var snapshot = await ref.where('user', isEqualTo: userEmail).get();  
    var userExpenses = snapshot.docs.map((doc) => doc.data());
    for (var expenditure in userExpenses) {
      
      if(expenditure.date.isBefore(firstDayNextMonth) && expenditure.date.isAfter(lastDayPreviousMonth)){
        monthlyExpenses.add(expenditure);
      }     
    }  

    notifyListeners();
  }
  
  void getTotalByCategory(String category){
    var total = 0.00;
    for (var expenditure in monthlyExpenses) {
      if(expenditure.category == category) total += expenditure.amount;
    }
    spentByCategoryList.add(CategoryData( category, total ));
    notifyListeners();
  }

  double getTotalByCategoryAmount(String category){
    var total = 0.00;
    for (var expenditure in monthlyExpenses) {
      if(expenditure.category == category) total += expenditure.amount;
    }
    return total;
  }


  // CRUD Methods
  
  void addExpenditure(Expenditure expenditure) async {
    monthlyExpenses.add(expenditure);

    final Map<String,dynamic> body = expenditure.toJson();
    body["amount"] =  '${body["amount"]}';

    await expensesCollection.doc().set(body);
    
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
   
    //UPDATE
    await expensesCollection.doc(selectedExpenditure!.id).set(body);

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

}
