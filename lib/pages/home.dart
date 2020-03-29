import 'package:checks/helpers/routes.dart';
import 'package:checks/helpers/time.dart';
import 'package:checks/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
	@override
	_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
	final String title = 'CHECKS';
	CalendarController _calendarController = CalendarController();

	@override
	Widget build(BuildContext context) => Scaffold(
		appBar: AppBar(
			title: Text(this.title),
			actions: <Widget>[
				IconButton(
					icon: Icon(Icons.settings),
					onPressed: () => Navigator.pushNamed(context, Routes.Settings))
			],
		),
		body: Container(
			padding: EdgeInsets.all(4),
			child: _buildTableCalendar()
		),
	);

	@override
	void dispose() {
		super.dispose();
		_calendarController.dispose();
	}

	void _onDaySelected(DateTime day, List events) => Time.isSavingsDay(context, day) ? Navigator.pushNamed(context, Routes.Date, arguments: {'date': day}) : null;

	void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) => print('$format');

	Widget _buildTableCalendar() => TableCalendar(
		calendarController: _calendarController,
		locale: 'en_US',
		onDaySelected: _onDaySelected,
		onVisibleDaysChanged: _onVisibleDaysChanged,
		startingDayOfWeek: StartingDayOfWeek.sunday,
		headerStyle: HomeWidgets.buildHeadersStyle(),
		daysOfWeekStyle: HomeWidgets.buildDaysOfWeekStyle(),
		builders: CalendarBuilders(
			dayBuilder: HomeWidgets.dayBuilder,
			selectedDayBuilder: HomeWidgets.selectedDayBuilder,
			todayDayBuilder: HomeWidgets.todayDayBuilder
		)
	);
}
