import 'dart:io';

import 'package:flutter/material.dart';

class ExpenditureImage extends StatelessWidget {

  final String url;

  const ExpenditureImage({
    super.key, 
    required this.url
  });


  @override
  Widget build(BuildContext context) {
		final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only( left: 10, right: 10, top: 10 ),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: size.height * 0.3,
        child: Container(
          decoration: const BoxDecoration(borderRadius: BorderRadius.all( Radius.circular( 45 ))),
          child: getImage(url),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.black,
    borderRadius: const BorderRadius.only( topLeft: Radius.circular( 45 ), topRight: Radius.circular(45) ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0,5)
      )
    ]
  );


  Widget getImage( String picture ) {

    if ( picture == "no-image" ) {
      return const Image(
          image: AssetImage('assets/images/no-image.jpg'),
          fit: BoxFit.cover,
        );
    }

    if ( picture.startsWith('http') ) {
      return FadeInImage(
          image: NetworkImage( url),
          placeholder: const AssetImage('assets/images/loading-gif.gif'),
          fit: BoxFit.cover,
        );
    }


    return Image.file(
      File( picture ),
      fit: BoxFit.cover,
    );
  }

}