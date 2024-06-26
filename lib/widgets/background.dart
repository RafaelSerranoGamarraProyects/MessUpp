import 'package:flutter/material.dart';
import 'package:messup/theme/custom_styles.dart';

class Background extends StatelessWidget {
  const Background({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
    	width: size.width,
    	height: size.height,
    	decoration: const BoxDecoration(
    		gradient: LinearGradient(
          //Color.fromRGBO(179, 229, 252, 1) --> Posible color
    			colors:[AppTheme.primaryColor, AppTheme.secondaryBlue],
    			begin: Alignment.topCenter,
    			end: Alignment.bottomCenter)
    	),
    );
  }
}