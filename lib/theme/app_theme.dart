import 'package:flutter/material.dart';

class AppTheme {
	static const Color primaryColor = Color.fromRGBO(13, 71, 161, 1);
	static const  Color secondaryBlue = Color.fromRGBO(30, 136, 229, 1);
	static const  Color secondaryColor = Colors.pinkAccent;
	static const Color errorColor = Colors.red;
	static final ThemeData lightTheme = ThemeData.light().copyWith(
		primaryColor: primaryColor,
		appBarTheme: const AppBarTheme(
      color: primaryColor,
      elevation: 0,
    ),
	);

}

