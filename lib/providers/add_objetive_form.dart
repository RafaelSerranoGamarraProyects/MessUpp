import 'package:flutter/material.dart';


class AddObjetiveFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String description = '';
  double amount = 0;

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