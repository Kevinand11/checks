import 'package:checks/helpers/time.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
	SettingsPage({Key key}) : super(key: key);

	@override
	_SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
	final String title = 'Settings';
	DateTime startDate = DateTime.now();

	@override
	Widget build(BuildContext context) => Scaffold(
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
									Text('${Time.months[startDate.month]} ${startDate.day}', style: TextStyle(
										fontSize: 15
									)),
									FlatButton(
										child: Text('Change', style: TextStyle(
											fontSize: 11,
											color: Colors.blue[500]
										)),
										onPressed: () async {
											DateTime date = await getDatePicker(context);
											setState(() => startDate = date);
											// TODO: save this date to shared prefs
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

	Future<DateTime> getDatePicker(BuildContext context) async => showDatePicker(
		context: context,
		initialDate: DateTime.now(),
		firstDate: DateTime(2000,1,1),
		lastDate: DateTime.now()
	);
}
