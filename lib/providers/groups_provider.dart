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
  
  GroupsProvider(User user) {
    this.user = user.email;
    getGroups(user);
  }
  
  void getGroups(User user) async{
    final ref = groupsCollection.withConverter(
      fromFirestore: Group.fromFirestore,
      toFirestore: (Group group, _) => group.toFirestore(),
    );

    var snapshot = await ref.where('participants', arrayContains: user.email).get();  
    var snapShot2 = await ref.where('participants', arrayContains: user.userName).get();
    userGroups =[...userGroups, ...snapshot.docs.map((doc) => doc.data())];
    userGroups =[...userGroups, ...snapShot2.docs.map((doc) => doc.data())];
   
    userGroups.toSet();
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
