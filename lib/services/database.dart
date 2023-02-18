import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tfg_app/models/expenditure.dart';

class DatabaseService{
	final CollectionReference expensesCollection = FirebaseFirestore.instance.collection('expenditures');
	final CollectionReference objetivesCollection = FirebaseFirestore.instance.collection('objetives');

	final CollectionReference groupsCollection = FirebaseFirestore.instance.collection('groups');


	Future<void> addExpenditure(Expenditure expenditure) async{
			await expensesCollection.doc().set(expenditure);
	}

	Future<void> updateExpenditure(Expenditure expenditure) async{
		await expensesCollection.doc(expenditure.id).set(expenditure);
	}

	Future<void> deleteExpenditure(Expenditure expenditure) async{
		await expensesCollection.doc(expenditure.id).delete();
	}
	
}