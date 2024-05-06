// To parse this JSON data, do
//
//     final expenditure = expenditureFromJson(jsonString);

import 'dart:convert';
import '../models.dart';

class MonthlyExpensesResponse{
	MonthlyExpensesResponse();
	List<Expenditure> expenditureListFromJson(String str) => List<Expenditure>.from(json.decode(str).map((x) => Expenditure.fromJson(x)));
	String expenditureToJson(List<Expenditure> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

}


