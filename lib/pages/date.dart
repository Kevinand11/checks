import 'package:checks/helpers/colors.dart';
import 'package:checks/models/entry.dart';
import 'package:checks/providers/entries_provider.dart';
import 'package:checks/widgets/date_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatePage extends StatefulWidget {
	final DateTime date;
	DatePage({Key key, this.date}) : super(key: key);

	@override
	_DatePageState createState() => _DatePageState(date: date);
}

class _DatePageState extends State<DatePage> {
	final DateTime date;
	Entry editEntry, newEntry;
	List<Entry> _entries = [];
	EntryProvider provider;
	TextEditingController newTitleController, newPriceController, newDescriptionController, editTitleController, editPriceController, editDescriptionController;

	_DatePageState({this.date});

	void fetchEntries(DateTime date) async {
		List<Entry> entries = await Entry.allonDate(date);
		setState(() => this._entries = entries);
	}

	@override
	void initState() {
		super.initState();
		this.fetchEntries(this.date);
		this.enableNewControllers();
	}

	@override
	void didChangeDependencies() {
		super.didChangeDependencies();
		this.provider = Provider.of<EntryProvider>(context);
	}

	void enableNewControllers(){
		newTitleController = TextEditingController()..addListener(onNewTitleChanged);
		newPriceController = TextEditingController()..addListener(onNewPriceChanged);
		newDescriptionController = TextEditingController()..addListener(onNewDescriptionChanged);
	}

	void enableEditControllers(){
		editTitleController = TextEditingController(text: editEntry.title)..addListener(onEditTitleChanged);
		editPriceController = TextEditingController(text: editEntry.price.toString())..addListener(onEditPriceChanged);
		editDescriptionController = TextEditingController(text: editEntry.description)..addListener(onEditDescriptionChanged);
	}

	void disposeControllers(){
		newTitleController.removeListener(onNewTitleChanged);
		newTitleController.dispose();
		newPriceController.removeListener(onNewPriceChanged);
		newPriceController.dispose();
		newDescriptionController.removeListener(onNewDescriptionChanged);
		newDescriptionController.dispose();
		editTitleController?.removeListener(onEditTitleChanged);
		editTitleController?.dispose();
		editPriceController?.removeListener(onEditPriceChanged);
		editPriceController?.dispose();
		editDescriptionController?.removeListener(onEditDescriptionChanged);
		editDescriptionController?.dispose();
	}

	void deleteEntries(List<int> ids) => setState(() => this._entries.removeWhere((Entry entry) => ids.contains(entry.id)));

	@override
	void dispose() {
		this.disposeControllers();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) => Scaffold(
		appBar: provider.selectMode ? DateWidgets.selectedAppBar(provider, this.deleteEntries) : DateWidgets.unSelectedAppBar(date, _newEntry),
		body: this._entries.length > 0 ? ListView.builder(
			itemCount: this._entries.length,
			itemBuilder: _entryBuilder,
		) : Container(
			alignment: Alignment.center,
			child: Text('No entries. Click the + button \nabove to add entries', textAlign: TextAlign.center,style: TextStyle(
				fontSize: 18,
				color: Colors.grey[600]
			)),
		),
	);

	Widget _entryBuilder(BuildContext context, int index){
		Entry entry = this._entries[index];
		return InkWell(
			onTap: () => provider.selectMode ? provider.alterInSelected(entry) : _editEntry(index, entry),
			onLongPress: () => provider.selectMode ? (){} : provider.alterInSelected(entry),
			child: Container(
				color: provider.hasSelected(entry) ? MyColors.Primary.withAlpha(200) : MyColors.White,
				child: Padding(
					padding: const EdgeInsets.all(16),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: <Widget>[
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Text(entry.title, style: TextStyle(
										fontSize: 18,
										color: provider.hasSelected(entry) ? MyColors.White : MyColors.Black,
									)),
									Text('- ${entry.price}', style: TextStyle(
										fontWeight: FontWeight.bold,
										fontSize: 18,
										color: MyColors.Error
									))
								],
							),
							SizedBox(height: 8),
							if(entry.description != null && entry.description.isNotEmpty) Text(entry.description, style: TextStyle(
								fontSize: 15,
								color: provider.hasSelected(entry) ? MyColors.White : MyColors.Black,
							))
						],
					),
				),
			),
		);
	}

	void _newEntry(){
		setState(() => newEntry = Entry(date: this.date));
		this.enableNewControllers();
		showDialog(context: context, builder: (BuildContext context) => _buildNewEntry(), barrierDismissible: false);
	}

	void _editEntry(int index, Entry entry){
		setState(() => editEntry = entry);
		this.enableEditControllers();
		showDialog(context: context, builder:(BuildContext context) => _buildEditEntry(index), barrierDismissible: false);
	}

	Widget _buildNewEntry() =>  AlertDialog(
		title: Text('Create Entry', style: TextStyle(color: Colors.white)),
		backgroundColor: MyColors.Primary_Dark,
		contentTextStyle: TextStyle(color: Colors.white),
		content: Column(
			mainAxisSize: MainAxisSize.min,
			children: <Widget>[
				DateWidgets.buildTitleField(newTitleController),
				DateWidgets.buildPriceField(newPriceController),
				DateWidgets.buildDescriptionField(newDescriptionController),
			],
		),
		actions: <Widget>[
			Row(
				mainAxisAlignment: MainAxisAlignment.end,
				children: <Widget>[
					FlatButton(
						child: Text('Cancel', style: TextStyle(color: Colors.white)),
						onPressed: () => Navigator.pop(context),
					),
					FlatButton(
						child: Text('Save', style: TextStyle(color: Colors.white)),
						onPressed: (){
							newEntry.save();
							setState(() => this._entries.add(newEntry.copy()));
							Navigator.pop(context);
						},
					)
				],
			)
		],
	);

	Widget _buildEditEntry(int index) => AlertDialog(
		title: Text('Edit Entry', style: TextStyle(color: Colors.white)),
		backgroundColor: MyColors.Primary_Dark,
		contentTextStyle: TextStyle(color: Colors.white),
		content: Column(
			mainAxisSize: MainAxisSize.min,
			children: <Widget>[
				DateWidgets.buildTitleField(editTitleController),
				DateWidgets.buildPriceField(editPriceController),
				DateWidgets.buildDescriptionField(editDescriptionController),
			],
		),
		actions: <Widget>[
			Row(
				mainAxisAlignment: MainAxisAlignment.end,
				children: <Widget>[
					FlatButton(
						child: Text('Cancel', style: TextStyle(color: Colors.white)),
						onPressed: () => Navigator.pop(context),
					),
					FlatButton(
						child: Text('Save', style: TextStyle(color: Colors.white)),
						onPressed: (){
							editEntry.save();
							setState(() => this._entries[index] = editEntry.copy());
							Navigator.pop(context);
						},
					)
				],
			)
		],
	);

	void onNewTitleChanged() => this.newEntry.title = newTitleController.text;
	void onNewPriceChanged() => this.newEntry.price = int.tryParse(newPriceController.text) ?? 0;
	void onNewDescriptionChanged() => this.newEntry.description = newDescriptionController.text;
	void onEditTitleChanged() => this.editEntry.title = editTitleController.text;
	void onEditPriceChanged() => this.editEntry.price = int.tryParse(editPriceController.text) ?? 0;
	void onEditDescriptionChanged() => this.editEntry.description = editDescriptionController.text;
}