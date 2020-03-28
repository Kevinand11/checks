import 'package:checks/models/entry.dart';
import 'package:flutter/material.dart';

class EntryProvider with ChangeNotifier {
	List<Entry> _selectedEntries = [];
	bool _mode = false;

	List<Entry> get selectedEntries => this._selectedEntries;

	bool get mode => this._mode;

	int get count => this._selectedEntries.length;

	bool get hasOne => this._selectedEntries.length == 1;

	bool has(Entry entry) => this._selectedEntries.contains(entry);

	void _setMode(bool mode) => this._mode = mode;

	void add(Entry entry){
		this._setMode(true);
		this._selectedEntries.add(entry);
		notifyListeners();
	}

	void remove(Entry entry){
		if(this.hasOne) this._setMode(false);
		this._selectedEntries.remove(entry);
		notifyListeners();
	}

	void clear(){
		this._setMode(false);;
		this._selectedEntries = [];
		notifyListeners();
	}
}
