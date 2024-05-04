import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../utils/utils.dart';

class ListCategoryCards extends StatelessWidget {
  const ListCategoryCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
			child: ListView.builder(
				itemCount: CategoriesOptions.categories.length,
				itemBuilder:(context, index) => CategoryCard(category: CategoriesOptions.categories[index])),
		);
  }
}

class CategoryCard extends StatelessWidget {
	final String category;
  const CategoryCard({
    super.key, required this.category,
  });

  @override
  Widget build(BuildContext context) {
		final expensesProvider = Provider.of<ExpensesProvider>(context);
    return Container(
			height: 90,
			padding: const EdgeInsets.symmetric(vertical: 3.0),
			child: Card(
				color: CategoriesOptions.categoryColorMap[category],
					child: ListTile(
						leading: Icon(CategoriesOptions.categoryIconMap[category], color: Colors.black),
						title: Text(category, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
						trailing: Text("${expensesProvider.getTotalByCategoryAmount(category)}€",style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
					),
			),
		);
  }
}