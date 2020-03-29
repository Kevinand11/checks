import 'package:checks/helpers/colors.dart';
import 'package:checks/helpers/time.dart';
import 'package:checks/providers/dates_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeWidgets{
	static HeaderStyle buildHeadersStyle() => HeaderStyle(
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

	static DaysOfWeekStyle buildDaysOfWeekStyle() => DaysOfWeekStyle(
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

	static Widget _baseBuilder(BuildContext context, DateTime date, { List<Widget> children }) => Time.isSavingsDay(context, date) ? Stack(children: children) : Text('');

	static Widget dayBuilder(BuildContext context, DateTime date, List<dynamic> events) => _baseBuilder(context, date,
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
			_markerBuilder(context, date)
		]
	);

	static Widget selectedDayBuilder(BuildContext context, DateTime date, List<dynamic> events) =>  _baseBuilder(context, date,
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
			_markerBuilder(context, date)
		]
	);

	static Widget todayDayBuilder(BuildContext context, DateTime date, List<dynamic> events) =>  _baseBuilder(context, date,
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
			_markerBuilder(context, date)
		]
	);

	static Widget _markerBuilder(BuildContext context,DateTime date) => Positioned(
		right: 1,
		bottom: 1,
		child: AnimatedContainer(
			duration: Duration(milliseconds: 300),
			alignment: Alignment.center,
			width: 20,
			height: 20,
			child: Icon(
				Provider.of<DateProvider>(context).hasDate(date) ? Icons.check : Icons.close,
				color: Provider.of<DateProvider>(context).hasDate(date) ? Colors.lightGreen[200] :  Colors.red[200]
			)
		)
	);
}