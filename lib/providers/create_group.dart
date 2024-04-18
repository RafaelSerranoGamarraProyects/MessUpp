import 'package:flutter/material.dart';


class CreateGroupProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

	String _name = "";
  String get name => _name;
  
  set name( String value){
    _name = value;
    notifyListeners();
  }
	List<String> participants = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

  
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void updateParticipants(List<String> participants) {
		this.participants = participants;
		notifyListeners();
	}

}