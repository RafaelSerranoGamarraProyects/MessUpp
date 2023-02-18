import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../models/models.dart';

class GroupsProvider extends ChangeNotifier {

  final CollectionReference groupsCollection = FirebaseFirestore.instance.collection('groups');


  List<Group> userGroups  = [];

  String _user = "";

  String get user => _user;

  set user (String value){
    _user = value;
    notifyListeners();
  }
  
  GroupsProvider(String userEmail) {
    user = userEmail;
    getGroups(userEmail);
  }
  
  void getGroups(String userEmail) async{
    final ref = groupsCollection.withConverter(
      fromFirestore: Group.fromFirestore,
      toFirestore: (Group group, _) => group.toFirestore(),
    );

    var snapshot = await ref.where("participans", arrayContains: userEmail).get();  
    userGroups =[...userGroups, ...snapshot.docs.map((doc) => doc.data())];
   
    notifyListeners();
  }

}
