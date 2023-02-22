import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';
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

    var snapshot = await ref.where('participants', arrayContains: userEmail).get();  
    userGroups =[...userGroups, ...snapshot.docs.map((doc) => doc.data())];
   
    notifyListeners();
  }

  void createGroup(Group newGroup) async{
    Uuid uuid = const Uuid();
    String groupId = uuid.v1();
    
    newGroup.id = groupId;
    userGroups.add(newGroup);

    final Map<String,dynamic> body = newGroup.toJson();
    body["amount"] =  '${body["amount"]}';

    await groupsCollection.doc(groupId).set(body);   
    notifyListeners();
  }

  void leaveGroup(Group group)async {
    userGroups.remove(group);
    group.participants.remove(user);
    
    final Map<String,dynamic> body = group.toJson();
    body["amount"] =  '${body["amount"]}';

    await groupsCollection.doc(group.id).set(body);   

  }


}
