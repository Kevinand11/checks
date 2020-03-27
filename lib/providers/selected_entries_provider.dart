import 'package:checks/models/entry.dart';
import 'package:flutter/material.dart';

class SelectedEntryProvider with ChangeNotifier {
	List<Entry> _selectedEntries = [];

	List<Entry> get selectedEntries => this._selectedEntries;

	int get count => this._selectedEntries.length;

	bool get isEmpty => this._selectedEntries.length == 0;

	bool get hasOne => this._selectedEntries.length == 1;

	bool has(Entry entry) => this._selectedEntries.contains(entry);

	void add(Entry entry){
		this._selectedEntries.add(entry);
		notifyListeners();
	}

	void remove(Entry entry){
		this._selectedEntries.remove(entry);
		this.notifyListeners();
	}

	void clear(){
		this._selectedEntries = [];
		this.notifyListeners();
	}
}
