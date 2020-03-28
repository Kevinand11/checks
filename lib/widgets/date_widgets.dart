import 'package:checks/helpers/time.dart';
import 'package:checks/helpers/toast.dart';
import 'package:checks/models/entry.dart';
import 'package:checks/providers/entries_provider.dart';
import 'package:flutter/material.dart';

class DateWidgets{
	static Widget buildTitleField(TextEditingController controller) => TextField(
		style: TextStyle(color: Colors.white),
		keyboardType: TextInputType.text,
		controller: controller,
		decoration: InputDecoration(
			border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
			hintText: 'Title',
			hintStyle: TextStyle(color: Colors.grey[300]),
		),
	);

	static Widget buildPriceField(TextEditingController controller) => TextField(
		style: TextStyle(color: Colors.white),
		keyboardType: TextInputType.number,
		controller: controller,
		decoration: InputDecoration(
			border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
			hintText: 'Price',
			hintStyle: TextStyle(color: Colors.grey[300]),
		),
	);

	static Widget buildDescriptionField(TextEditingController controller) => TextField(
		style: TextStyle(color: Colors.white),
		controller: controller,
		minLines: 2,
		maxLines: 100,
		keyboardType: TextInputType.text,
		decoration: InputDecoration(
			border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
			hintText: 'Description. Totally optional',
			hintStyle: TextStyle(color: Colors.grey[300]),
		),
	);

	static AppBar unSelectedAppBar(DateTime date, Function newEntry) => AppBar(
		centerTitle: false,
		title: Text('${Time.days[date.weekday]}, ${Time.months[date.month]} ${date.day}'),
		actions: <Widget>[
			IconButton(
				icon: Icon(Icons.add),
				onPressed: newEntry,
			)
		],
	);

	static AppBar selectedAppBar(EntryProvider provider) => AppBar(
		centerTitle: false,
		leading: IconButton(
			icon: Icon(Icons.close),
			onPressed: provider.clear
		),
		title: Text('${provider.count} selected'),
		actions: <Widget>[
			if(provider.hasOne) IconButton(
				icon: Icon(Icons.edit),
				onPressed: (){},
			),
			IconButton(
				icon: Icon(Icons.delete),
				onPressed: (){
					List<int> ids = provider.selectedEntries.map((Entry entry) => entry.id).toList();
					Entry.deleteMany(ids);
					Toast.info('${ids.length} ${ids.length > 1 ? 'entries' : 'entry'} deleted successfully!');
				},
			)
		],
	);
}