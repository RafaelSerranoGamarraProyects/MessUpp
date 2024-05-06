import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../theme/custom_styles.dart';


class GroupItem extends StatefulWidget {
	final Group userGroup;
  const GroupItem({
    super.key, required this.userGroup,
  });

  @override
  State<GroupItem> createState() => _GroupItemState();
}

class _GroupItemState extends State<GroupItem> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
				Card(
					color: Colors.white,
					child: ListTile(
						trailing: const Icon(Icons.keyboard_arrow_right_outlined,color: AppTheme.textColorSecundary, size: 30),
						title: Text(widget.userGroup.name,style: const TextStyle(color: AppTheme.textColorSecundary, fontSize: 20),),
						onTap: () => Navigator.pushReplacementNamed(context, 'group_details', arguments: widget.userGroup),
					),
				)
      ],
    );
  }
}