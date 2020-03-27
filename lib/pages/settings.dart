import 'package:checks/helpers/time.dart';
import 'package:checks/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
	SettingsPage({Key key}) : super(key: key);

	@override
	_SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
	final String title = 'Settings';

	@override
	void initState() {
		super.initState();
	}

	@override
	Widget build(BuildContext context){
		SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
		return Scaffold(
			appBar: AppBar(
				title: Text(this.title),
			),
			body: Padding(
				padding: const EdgeInsets.all(16),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: <Widget>[
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: <Widget>[
								Text('Started saving on:', style: TextStyle(
									fontSize: 18,
									fontWeight: FontWeight.bold
								)),
								Row(
									children: <Widget>[
										Text('${Time.months[settingsProvider.startDate.month]} ${settingsProvider.startDate.day}', style: TextStyle(
											fontSize: 15
										)),
										FlatButton(
											child: Text('Change', style: TextStyle(
												fontSize: 11,
												color: Colors.blue[500]
											)),
											onPressed: () async {
												DateTime date = await _getDatePicker(context);
												settingsProvider.setStartDate(date);
											}
										)
									],
								)
							],
						),
					],
				),
			)
		);
	}

	Future<DateTime> _getDatePicker(BuildContext context) async => showDatePicker(
		context: context,
		initialDate: Provider.of<SettingsProvider>(context, listen: false).startDate,
		firstDate: DateTime(2000,1,1),
		lastDate: DateTime.now()
	);
}
