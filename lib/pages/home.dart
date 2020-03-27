import 'package:checks/helpers/colors.dart';
import 'package:checks/helpers/routes.dart';
import 'package:checks/helpers/time.dart';
import 'package:checks/models/entry.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
	@override
	_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
	final String title = 'CHECKS';
	CalendarController _calendarController = CalendarController();
	List<DateTime> _dates = [];

	fetchDates() async {
		List<DateTime> dates = await Entry.uniqueDates();
		setState(() => this._dates = dates);
	}

	@override
	void initState(){
		super.initState();
		fetchDates();
	}

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
		body: Column(
			children: <Widget>[
				SizedBox(height: 16),
				_buildTableCalendar()
			],
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
		headerStyle: _buildHeadersStyle(),
		daysOfWeekStyle: _buildDaysOfWeekStyle(),
		builders: CalendarBuilders(
			dayBuilder: _dayBuilder,
			selectedDayBuilder: _selectedDayBuilder,
			todayDayBuilder: _todayDayBuilder
		)
	);

	HeaderStyle _buildHeadersStyle() => HeaderStyle(
		centerHeaderTitle: true,
		titleTextStyle: TextStyle(
			fontWeight: FontWeight.bold,
			fontSize: 15
		),
		formatButtonVisible: false,
		formatButtonShowsNext: false,
		formatButtonTextStyle: TextStyle(
			color: Colors.white,
			fontSize: 14
		),
		formatButtonDecoration: BoxDecoration(
			color: MyColors.Accent,
			borderRadius: BorderRadius.circular(8),
		)
	);

	DaysOfWeekStyle _buildDaysOfWeekStyle() => DaysOfWeekStyle(
		weekendStyle: TextStyle(
			color: MyColors.Accent,
			fontSize: 15,
			fontWeight: FontWeight.bold
		),
		weekdayStyle: TextStyle(
			color: Colors.black,
			fontSize: 15,
			fontWeight: FontWeight.bold
		),
	);

	Widget _baseBuilder(BuildContext context, DateTime date, { List<Widget> children }) => Time.isSavingsDay(context, date) ? Stack(children: children) : Text('');

	Widget _dayBuilder(BuildContext context, DateTime date, List<dynamic> events) => _baseBuilder(context, date,
		children: [
			Container(
				alignment: Alignment.center,
				margin: EdgeInsets.all(4),
				decoration: BoxDecoration(
					borderRadius: BorderRadius.all(Radius.circular(50)),
					color: Colors.white,
				),
				width: 100,
				height: 100,
				child: Text('${date.day}', style: TextStyle(
					color: Time.isWeekend(date) ? MyColors.Accent : Colors.black
				)),
			),
			_markerBuilder(date)
		]
	);

	Widget _selectedDayBuilder(BuildContext context, DateTime date, List<dynamic> events) =>  _baseBuilder(context, date,
		children: [
			Container(
				alignment: Alignment.center,
				margin: EdgeInsets.all(4),
				decoration: BoxDecoration(
					borderRadius: BorderRadius.all(Radius.circular(50)),
					color: Colors.blue[200],
				),
				width: 100,
				height: 100,
				child: Text('${date.day}', style: TextStyle(
					color: Colors.white
				)),
			),
			_markerBuilder(date)
		]
	);

	Widget _todayDayBuilder(BuildContext context, DateTime date, List<dynamic> events) =>  _baseBuilder(context, date,
		children: [
			Container(
				alignment: Alignment.center,
				margin: EdgeInsets.all(4),
				decoration: BoxDecoration(
					borderRadius: BorderRadius.all(Radius.circular(50)),
					color: Colors.green[200],
				),
				width: 100,
				height: 100,
				child: Text('${date.day}', style: TextStyle(
					color: Colors.white
				)),
			),
			_markerBuilder(date)
		]
	);

	Widget _markerBuilder(DateTime date) => Positioned(
		right: 1,
		bottom: 1,
		child: AnimatedContainer(
			duration: Duration(milliseconds: 300),
			alignment: Alignment.center,
			width: 20,
			height: 20,
			child: Icon(
				_dates.contains(date) ? Icons.check : Icons.close,
				color: _dates.contains(date) ? Colors.lightGreen[200] :  Colors.red[200]
			)
		)
	);
}
