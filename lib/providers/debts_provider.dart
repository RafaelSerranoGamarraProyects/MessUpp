import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';

class DebtsProvider extends ChangeNotifier {

  final CollectionReference debtsCollection = FirebaseFirestore.instance.collection('debts');
  List<Debt> userDebts  = [];

  String _user = "";

  String get user => _user;

  set user (String value){
    _user = value;
    notifyListeners();
  }

  
  DebtsProvider(String userEmail) {
    user = userEmail;
    getDebts(userEmail);
  }
  
  void getDebts(String userEmail) async{
    final ref = debtsCollection.withConverter(
      fromFirestore: Debt.fromFirestore,
      toFirestore: (Debt debt, _) => debt.toFirestore(),
    );

    var snapshotOrigin = await ref.where('originUser', isEqualTo: userEmail).get();  
    userDebts =[...userDebts, ...snapshotOrigin.docs.map((doc) => doc.data())];

    var snapshotDest = await ref.where('destinationUser', isEqualTo: userEmail).get();  
    userDebts =[...userDebts, ...snapshotDest.docs.map((doc) => doc.data())];
   
    userDebts.sort((a, b) {
      if(a.date.isBefore(b.date)) return -1;
      if(a.date.isAfter(b.date)) return 1;
      return 0;
     });
     
    notifyListeners();
  }

  void createDebt(Debt newDebt) async{
    Uuid uuid = const Uuid();
    String debtId = uuid.v1();
    
    newDebt.id = debtId;
    userDebts.add(newDebt);

    final Map<String,dynamic> body = newDebt.toJson();
    body["amount"] =  '${body["amount"]}';

    await debtsCollection.doc(debtId).set(body);   
    notifyListeners();
  }

  void updateDebt(Debt debt) async {
    final Map<String,dynamic> body = debt.toJson();
    body["amount"] =  '${body["amount"]}';
    await debtsCollection.doc(debt.id).update(body);

    notifyListeners();   
  }
}
