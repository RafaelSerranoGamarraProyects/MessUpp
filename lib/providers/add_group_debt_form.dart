import 'package:flutter/material.dart';


class AddGroupDebtForm extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String payer = '';
	double amount = 0.0;
	String description = "";

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

}