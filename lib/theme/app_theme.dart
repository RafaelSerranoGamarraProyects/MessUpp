import 'package:flutter/material.dart';

class AppTheme {
	static const Color primaryColor = Color(0xFF050A30);
	static const  Color secondaryBlue = Color.fromRGBO(30, 136, 229, 1);
	static const  Color secondaryColor = Colors.pinkAccent;
	static const Color errorColor = Colors.red;
	static const Color textColorPrimary = Colors.white;
	static const Color textColorSecundary = Colors.black;
	static final ThemeData lightTheme = ThemeData.light().copyWith(
		primaryColor: primaryColor,
		appBarTheme: const AppBarTheme(
      color: primaryColor,
      elevation: 0,
    ),
	);

}

