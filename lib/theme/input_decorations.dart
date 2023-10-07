import 'package:flutter/material.dart';

import 'app_theme.dart';

class InputDecorations {

  static InputDecoration formInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
  }) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.primaryColor
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.primaryColor,
            width: 2
          )
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.grey
        ),
        prefixIcon: prefixIcon != null 
          ? Icon( prefixIcon, color: AppTheme.primaryColor )
          : null
      );
  }
   static InputDecoration dateInputDecoration({
    required String labelText,
    }) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.primaryColor
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.primaryColor,
            width: 2
          )
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.grey
        ),
        icon: const Icon(Icons.date_range, color: AppTheme.primaryColor)
      );
  }

  static InputDecoration dropDownMenuInputDecoration({
    required String labelText,
    required IconData? icon
    }) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.primaryColor
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.primaryColor,
            width: 2
          )
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.grey
        ),
        icon: Icon(icon, color: AppTheme.primaryColor)
      );
  }


}