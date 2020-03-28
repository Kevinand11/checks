import 'package:checks/models/entry.dart';
import 'package:flutter/material.dart';

class EntryProvider with ChangeNotifier {
	List<Entry> _entries = [];
	List<Entry> _selectedEntries = [];
	bool _selectMode = false;

	void fetchEntries(DateTime date) async {
		this._entries = await Entry.allonDate(date);
		notifyListeners();
	}

	void addEntry(Entry entry){
		this._entries.add(entry);
		notifyListeners();
	}

	void editEntry(int index, Entry entry){
		this._entries[index] = entry;
		notifyListeners();
	}

	List<Entry> get entries => this._entries;

	int get entryCount => this._entries.length;

	// Part about Selected entries

	List<Entry> get selectedEntries => this._selectedEntries;

	bool get selectMode => this._selectMode;

	int get selectedCount => this._selectedEntries.length;

	bool get hasOne => this._selectedEntries.length == 1;

	bool hasSelected(Entry entry) => this._selectedEntries.contains(entry);

	void _setSelectMode(bool mode) {
		this._selectMode = mode;
		notifyListeners();
	}

	void alterSelected(Entry entry) => hasSelected(entry) ? _addSelected(entry) : _removeSelected(entry);

	void _addSelected(Entry entry){
		this._setSelectMode(true);
		print(1234);
		this._selectedEntries.add(entry);
		notifyListeners();
	}

	void _removeSelected(Entry entry){
		if(this.hasOne) this._setSelectMode(false);
		print(4321);
		this._selectedEntries.remove(entry);
		notifyListeners();
	}

	void clearSelected(){
		this._setSelectMode(false);
		this._selectedEntries = [];
		notifyListeners();
	}
}
