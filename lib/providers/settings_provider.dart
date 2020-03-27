import 'package:checks/helpers/shared_prefs.dart';
import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier{
	DateTime _startDate;

	SettingsProvider(){
		this._startDate = DateTime(2000,1,1);
		_getStartDate();
	}

	_getStartDate() async {
		String date = await SharedPrefs.getString(Keys.startDate);
		if(date != null) {
			this._startDate = DateTime.parse(date);
			notifyListeners();
		}
	}

	DateTime get startDate => _startDate;

	setStartDate(DateTime date){
		this._startDate = date;
		notifyListeners();
		SharedPrefs.setString(Keys.startDate, date.toIso8601String());
	}
}