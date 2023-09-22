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
		"Alimentacion" : const Color.fromARGB(255, 178, 243, 211),
		"Ocio" : const Color.fromARGB(255, 248, 152, 184),
		"Viaje" : const Color.fromARGB(255, 169, 225, 251),
		"Compras" : const Color.fromARGB(255, 252, 233, 163)
	};

	static List<DropdownMenuItem<String>> ddMenuItemCategories = [
		const DropdownMenuItem(
      value: "Alimentacion",
      child: Row(
        children: <Widget>[
          Icon(Icons.fastfood_rounded),Text("Alimentacion"),],
       )),
			const DropdownMenuItem(
      value: "Ocio",
      child: Row(
        children: <Widget>[Icon(Icons.sports_esports_rounded),Text("Ocio"),],
			)),
			const DropdownMenuItem(
      value: "Viaje",
      child: Row(
        children: <Widget>[Icon(Icons.travel_explore_outlined),Text("Viaje"),],
			)),
		const DropdownMenuItem(
      value: "Compras",
      child: Row(
        children: <Widget>[Icon(Icons.shopping_cart_checkout_outlined),Text("Compras"),],
			)),
	];
}