import 'package:flutter/material.dart';
import 'package:tfg_app/theme/custom_styles.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
    	width: size.width,
    	height: size.height,
    	decoration: const BoxDecoration(
    		gradient: LinearGradient(
    			colors:[ AppTheme.secondaryBlue,Color.fromRGBO(179, 229, 252, 1)],
    			begin: Alignment.topCenter,
    			end: Alignment.bottomCenter)
    	),
    );
  }
}