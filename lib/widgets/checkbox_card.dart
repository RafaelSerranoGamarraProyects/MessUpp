import 'package:flutter/material.dart';
import '../theme/custom_styles.dart';

class DebtorItem extends StatefulWidget {
  const DebtorItem({
    super.key,
  });

  @override
  State<DebtorItem> createState() => _DebtorItemState();
}

class _DebtorItemState extends State<DebtorItem> {
  @override
  Widget build(BuildContext context) {
		bool isChecked = false;
    return Card(
			color: Colors.white,
			shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
			child: Row( 
				children: [
					const Padding(
							padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 5),
							child: Text("UserName", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
					),
					const Spacer(),
    			Checkbox(
						value: isChecked,
					 	checkColor: AppTheme.primaryColor,
					 	shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
					  onChanged: (bool? value) {
       				 setState(() {
								if(value != null) isChecked = value;
        			});
      		}, 
				)
    		]
			)
		);
  }
}
