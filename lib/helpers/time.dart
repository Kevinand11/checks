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

	// TODO: replace hardcoded date with saved date in shared prefs
	static bool isSavingsDay(DateTime date) => date.isAfter(DateTime(2020,3,11)) && date.isBefore(DateTime.now());
}
