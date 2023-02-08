import 'package:flutter/material.dart';

class CategoriesOptions{
	static List<String> categories = ["Alimentacion","Ocio","Viaje","Compras"];

	static Map<String, IconData> categoryIconMap ={
		"Alimentacion" : Icons.fastfood_rounded,
		"Ocio" : Icons.sports_esports_rounded,
		"Viaje" : Icons.travel_explore_outlined,
		"Compras" : Icons.shopping_cart_checkout_outlined
	};

		static Map<String, Color> categoryColorMap ={
		"Alimentacion" : Colors.greenAccent,
		"Ocio" : Colors.pinkAccent,
		"Viaje" : Colors.lightBlueAccent,
		"Compras" : Colors.amberAccent
	};

	static List<DropdownMenuItem<String>> ddMenuItemCategories = [
		DropdownMenuItem(
      value: "Alimentacion",
      child: Row(
        children: const <Widget>[
          Icon(Icons.fastfood_rounded),Text("Alimentacion"),],
       )),
			DropdownMenuItem(
      value: "Ocio",
      child: Row(
        children: const <Widget>[Icon(Icons.sports_esports_rounded),Text("Ocio"),],
			)),
			DropdownMenuItem(
      value: "Viaje",
      child: Row(
        children: const <Widget>[Icon(Icons.travel_explore_outlined),Text("Viaje"),],
			)),
		DropdownMenuItem(
      value: "Compras",
      child: Row(
        children: const <Widget>[Icon(Icons.shopping_cart_checkout_outlined),Text("Compras"),],
			)),
	];
}