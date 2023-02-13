import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_app/utils/categories_options.dart';


import '../providers/providers.dart';

class HorizontalBarChart extends StatefulWidget {
  
  const HorizontalBarChart({Key? key}) : super(key: key);

  @override
  State<HorizontalBarChart> createState() => _HorizontalBarChartState();
}

class _HorizontalBarChartState extends State<HorizontalBarChart> {
  @override
  Widget build(BuildContext context) {
    final expensesProvider = Provider.of<ExpensesProvider>(context);    
    if(expensesProvider.spentByCategoryList == []) return const CircularProgressIndicator();

    
    double maxWidth = MediaQuery.of(context).size.width - 44;
    var totalUnitNum = 0.00;
    for (int i = 0; i < expensesProvider.spentByCategoryList.length; i++) {
      totalUnitNum = totalUnitNum + expensesProvider.spentByCategoryList[i].amount;
    }

    return Container(
      height: 20,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90),),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      
      child: Row(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          for (int i = 0; i < expensesProvider.spentByCategoryList.length; i++)    
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: expensesProvider.spentByCategoryList[i].amount / totalUnitNum * maxWidth,
              height: 20,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
              child: ColoredBox(
                color: CategoriesOptions.categoryColorMap[expensesProvider.spentByCategoryList[i].category]!,
              ),  
            )
        ],
      ), 
    );
    
  }
}