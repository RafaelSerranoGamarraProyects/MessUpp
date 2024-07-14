import 'package:flutter/material.dart';

class ReturnToButton extends StatelessWidget {
  const ReturnToButton({
    super.key, required this.route, this.arguments
  });

	final String route;
	final dynamic arguments;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
				if (arguments != null) {
          //Navigator.pop(context);
          //Navigator.pushReplacementNamed(context, route, arguments: arguments);
				  Navigator.popAndPushNamed(context, route, arguments: arguments);
				} else {
          //Navigator.pop(context);
          //Navigator.pushReplacementNamed(context, route);
					Navigator.popAndPushNamed(context, route);
				}
      }, 
      icon: const Icon( Icons.arrow_back, size: 26, color: Colors.white ),
    );
  }
}
