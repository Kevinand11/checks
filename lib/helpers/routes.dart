import 'package:checks/pages/date.dart';
import 'package:checks/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:checks/pages/home.dart';

class Router {
	static Widget getRoute(String route, Map<String, dynamic> arguments) {
		switch (route) {
		case Routes.Home:
			return HomePage();
		case Routes.Settings:
			return SettingsPage();
		case Routes.Date:
			return DatePage(date: arguments['date']);
		default:
			return HomePage();
		}
	}
}

class Routes {
	static const String Home = 'Home';
	static const String Settings = 'Settings';
	static const String Date = 'Date';
}
