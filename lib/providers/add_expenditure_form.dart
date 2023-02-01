import 'package:flutter/material.dart';


class AddExpenditureFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String description = '';
  String category = '';
  String amount = '';
  String date = '';
  String image = '';

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