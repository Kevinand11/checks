import 'package:checks/helpers/shared_prefs.dart';
import 'package:checks/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Time {
	static const Map<int, String> days = {
		1 : 'Monday',
		2 : 'Tuesday',
		3 : 'Wednesday',
		4 : 'Thursday',
		5 : 'Friday',
		6 : 'Saturday',
		7 : 'Sunday'
	};
	static const Map<int, String> months = {
		1 : 'January',
		2 : 'February',
		3 : 'March',
		4 : 'April',
		5 : 'May',
		6 : 'June',
		7 : 'July',
		8 : 'August',
		9 : 'September',
		10 : 'October',
		11 : 'November',
		12 : 'December'
	};
	static bool isWeekend(DateTime date) => date.weekday == 6 || date.weekday == 7;

	static bool isSavingsDay(BuildContext context, DateTime date) {
		DateTime startDate = Provider.of<SettingsProvider>(context, listen: false).startDate;
		// TODO: fix definition of todays's date in below logic
		return date.isBefore(DateTime.now()) && date.isAfter(startDate);
	}
}
