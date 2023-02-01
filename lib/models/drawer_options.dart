import 'package:flutter/material.dart';

class DrawerOptions{
	List<DrawerOption> options = [
		DrawerOption(name: "Gastos Y Objetivos", icon: Icons.track_changes_outlined, route: "spendsAndObjetives"),
		DrawerOption(name: "Grupos", icon: Icons.people_outline, route: "groups"),
		DrawerOption(name: "Pagos Pendientes", icon: Icons.send_outlined, route: "debts"),
		DrawerOption(name: "Ajustes", icon: Icons.settings, route: "settings"),
	];
}

class DrawerOption{
	final String name;
	final IconData icon;
	final String route;
	
	DrawerOption({required this.name,required this.icon,required this.route});
}