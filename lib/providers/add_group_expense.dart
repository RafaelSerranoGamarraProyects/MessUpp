import 'package:Messup/models/monetary_transaction.dart';
import 'package:Messup/models/transaction_beneficiary.dart';
import 'package:flutter/material.dart';


class CreateGroupExpenseProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

	double _amount = 0;
	double get amount => _amount;

	String _name = "";
  String get name => _name;

	String _payer = "";
  String get payer => _payer;

	List<String> _beneficiaries = [];
  List<String> get beneficiaries => _beneficiaries;
  
  set name( String value){
    _name = value;
    notifyListeners();
  }

	set beneficiaries(List<String> value) {
		_beneficiaries = value;
		notifyListeners();
	}

	set amount(double value) {
		_amount = value;
		notifyListeners();
	}

	set payer(String value) {
		_payer = value;
		notifyListeners();
	}

  bool isValidForm() {
		final validFields = (payer != "" && amount != 0 && name != "" && beneficiaries.isEmpty == false);
    return validFields;
  }

  MonetaryTransaction createTransaction() {
		return  MonetaryTransaction(name: name, payer: payer, beneficiaries: beneficiaries, amount: amount);
	}

  void updateBeneficiaries(TransactionBeneficiary participant) {
		if (beneficiaries.contains(participant.name) && participant.isBeneficiary == false) {
			beneficiaries.remove(participant.name);
		}
		if(!beneficiaries.contains(participant.name) && participant.isBeneficiary == true) {
			beneficiaries.add(participant.name);
		}

	}
}