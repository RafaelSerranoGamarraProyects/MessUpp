import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../models/models.dart';

class ObjetivesProvider extends ChangeNotifier {

  final CollectionReference objetivesCollection = FirebaseFirestore.instance.collection('objetives');


  Objetive monthlyObjetive  = Objetive(
    date: DateTime.now(), amount: 0, description: "no-description", isAchived: false, user: "");

  String _user = "";

  String get user => _user;

  set user (String value){
    _user = value;
    notifyListeners();
  }
  
  ObjetivesProvider(String userEmail) {
    user = userEmail;
    getMonthlyObjetive(userEmail);
  }
  
  void getMonthlyObjetive(String userEmail) async{
    DateTime firstDayNextMonth = DateTime.utc(DateTime.now().year, DateTime.now().month + 1);
    DateTime lastDayPreviousMonth = DateTime.utc(DateTime.now().year, DateTime.now().month, 0);
    
    final ref = objetivesCollection.withConverter(
      fromFirestore: Objetive.fromFirestore,
      toFirestore: (Objetive objetive, _) => objetive.toFirestore(),
    );

    var snapshot = await ref.where("user", isEqualTo: userEmail).get();  
    var userObjetives = snapshot.docs.map((doc) => doc.data());
    for (var objetive in userObjetives) {
      
      if(objetive.date.isBefore(firstDayNextMonth) && objetive.date.isAfter(lastDayPreviousMonth)){
        monthlyObjetive = objetive;
      }     
    }
    notifyListeners();
  }

  void checkObjetive(double total) {
    total >= monthlyObjetive.amount 
      ? monthlyObjetive.isAchived = true
      : monthlyObjetive.isAchived = false;
    
    notifyListeners();
  }

  void addObjetive(Objetive objetive) async {
    final Map<String,dynamic> body = objetive.toJson();
    body["amount"] =  '${body["amount"]}';
    await objetivesCollection.doc().set(body);
    monthlyObjetive = objetive;
    notifyListeners();
  }

}
