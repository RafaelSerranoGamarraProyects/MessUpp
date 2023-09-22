import 'package:flutter/material.dart';

class HeaderLoginIcon extends StatelessWidget {
  const HeaderLoginIcon({super.key});
	
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only( top: 30 ),
        child: const Icon( Icons.person_pin, color: Colors.white, size: 100 ),
      ),
    );
  }
}


class PurpleBoxLogin extends StatelessWidget {
  const PurpleBoxLogin({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBackground(),
      child: const Stack(
        children: [
          Positioned(top: 90, left: 30, child: Bubble() ),
          Positioned(top: -40, left: -30, child: Bubble() ),
          Positioned(top: -50, right: -20, child: Bubble() ),
          Positioned(bottom: -50, left: 10, child: Bubble() ),
          Positioned(bottom: 120, right: 20, child: Bubble() ),
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() => const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1)
      ]
    )
  );
}


class Bubble extends StatelessWidget {
  const Bubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }
}


class CardContainer extends StatelessWidget {

  final Widget child;

  const CardContainer({
    Key? key, 
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 30 ),
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all( 20 ),
          decoration: _createCardShape(),
          child: child,
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
       BoxShadow(
        color: Colors.black12,
        blurRadius: 15,
        offset: Offset(0, 5),
      )
    ]
  );
}