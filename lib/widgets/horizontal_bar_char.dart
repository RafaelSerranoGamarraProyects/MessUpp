import 'package:flutter/material.dart';
import 'package:tfg_app/utils/categories_options.dart';
import 'package:tfg_app/utils/category_data.dart';

class HorizontalBarChart extends StatelessWidget {
  final List<CategoryData> data;
  const HorizontalBarChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double maxWidth = MediaQuery.of(context).size.width - 44;
    var totalUnitNum = 0.00;
    for (int i = 0; i < data.length; i++) {
      totalUnitNum = totalUnitNum + data[i].amount;
    }

    return Container(
      
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
      
      child: Row(
        children: [
          for (int i = 0; i < data.length; i++)
            Row(
              children: [
                SizedBox(
                  width: data[i].amount / totalUnitNum * maxWidth,
                  height: 16,
                  child: ColoredBox(
                    color: CategoriesOptions.categoryColorMap[data[i].category]!,
                  ),
                ),
                const SizedBox(width: 6),
              ],
            )
        ],
      ),
    );
  }
}