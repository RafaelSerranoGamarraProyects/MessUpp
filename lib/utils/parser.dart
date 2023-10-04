import 'package:tfg_app/models/models.dart';

class Parser {
  static List<String> parseFromListDynamicToListString(List<dynamic> list ){
    List<String> listToReturn = [];
    for (var item in list){
      var itemString = item.toString();
      listToReturn.add(itemString);
    }
    return listToReturn;
  }

	static List<MonetaryTransaction> parseToMonetaryTransactionsList(List<dynamic> list){
		List<MonetaryTransaction> listToReturn = [];

		for (var item in list ){
			final transaction = MonetaryTransaction(
				name: item["name"],
			 	payer: item["payer"],
				beneficiaries: Parser.parseFromListDynamicToListString(item["beneficiaries"]) ,
				amount: double.parse("${item["amount"]}")
			);
			listToReturn.add(transaction);
		}
		return listToReturn;
	}

}
