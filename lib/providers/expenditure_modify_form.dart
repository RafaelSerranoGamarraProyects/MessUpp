import 'package:flutter/material.dart';
import '../models/models.dart';


class ModifyExpenditureFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String date = "";
  Expenditure expenditure = Expenditure(date: DateTime.now(), amount: 0,
                              category: "", description: "", image: 'no-image', user: "");

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