import 'package:flutter/material.dart';

class ReturnToButton extends StatelessWidget {
  const ReturnToButton({
    super.key, required this.route
  });

	final String route;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.popAndPushNamed(context, 'groups');
      }, 
      icon: const Icon( Icons.arrow_back, size: 26, color: Colors.white ),
    );
  }
}
