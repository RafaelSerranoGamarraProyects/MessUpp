import 'package:flutter/material.dart';

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
    			colors: [Color.fromRGBO(71, 18, 97, 1), Color.fromRGBO(0, 0, 0, 1)],
    			begin: Alignment.topCenter,
    			end: Alignment.bottomCenter)
    	),
    );
  }
}