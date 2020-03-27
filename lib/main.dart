import 'package:checks/providers/selected_entries_provider.dart';
import 'package:checks/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:checks/helpers/routes.dart' show Router, Routes;
import 'package:provider/provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
	@override
	Widget build(BuildContext context) => MultiProvider(
		providers: [
			ChangeNotifierProvider(create: (BuildContext context) => SettingsProvider()),
			ChangeNotifierProvider(create: (BuildContext context) => SelectedEntryProvider()),
		],
		child: MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'Checks',
			theme: ThemeData(
				primaryColor: Color(0xff008ab5),
				accentColor: Color(0xfffa0a4c),
				fontFamily: 'Poppins'
			),
			initialRoute: Routes.Home,
			onGenerateRoute: _generateRoutes(),
		),
	);

	RouteFactory _generateRoutes() => (settings) => MaterialPageRoute(
		builder: (context) => Router.getRoute(settings.name, settings.arguments)
	);
}
