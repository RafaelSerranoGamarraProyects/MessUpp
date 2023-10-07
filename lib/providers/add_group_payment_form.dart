import 'package:flutter/material.dart';


class AddGroupPaymentProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name = '';



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