import 'package:checks/models/entry.dart';
import 'package:flutter/material.dart';

class DateProvider with ChangeNotifier {
	List<DateTime> _setDates = [];

	DateProvider(){
		this._fetchDates();
	}

	_fetchDates() async {
		this._setDates = await Entry.uniqueDates();
		notifyListeners();
	}

	bool hasDate(DateTime date) => this._setDates.contains(DateTime(date.year,date.month,date.day));
}