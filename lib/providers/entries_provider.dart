import 'package:checks/helpers/toast.dart';
import 'package:checks/models/entry.dart';
import 'package:flutter/material.dart';

class EntryProvider with ChangeNotifier {
	List<Entry> _selectedEntries = [];
	bool _selectMode = false;

	List<Entry> get selectedEntries => this._selectedEntries;

	bool get selectMode => this._selectMode;

	int get selectedCount => this._selectedEntries.length;

	bool get hasOneSelected => this._selectedEntries.length == 1;

	bool hasSelected(Entry entry) => this._selectedEntries.contains(entry);

	void _setSelectMode(bool mode) => this._selectMode = mode;

	void alterInSelected(Entry entry) => this.hasSelected(entry) ? this._removeSelected(entry) : this._addSelected(entry);

	void _addSelected(Entry entry){
		this._setSelectMode(true);
		this._selectedEntries.add(entry);
		notifyListeners();
	}

	void deleteSelected() async {
		List<int> ids = this.selectedEntries.map((Entry entry) => entry.id).toList();
		await Entry.deleteMany(ids);
		this.selectedEntries.removeWhere((Entry entry) => ids.contains(entry.id));
		if(this.selectedCount == 0) this._setSelectMode(false);
		notifyListeners();
		Toast.info('${ids.length} ${ids.length > 1 ? 'entries' : 'entry'} deleted successfully!');
	}

	void _removeSelected(Entry entry){
		if(this.hasOneSelected) this._setSelectMode(false);
		this._selectedEntries.remove(entry);
		notifyListeners();
	}

	void clearSelected(){
		this._setSelectMode(false);
		this._selectedEntries = [];
		notifyListeners();
	}
}
