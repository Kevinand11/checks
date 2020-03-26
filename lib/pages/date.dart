import 'package:checks/helpers/colors.dart';
import 'package:checks/helpers/time.dart';
import 'package:checks/helpers/toast.dart';
import 'package:checks/models/entry.dart';
import 'package:flutter/material.dart';

class DatePage extends StatefulWidget {
	final DateTime date;
	DatePage({Key key, this.date}) : super(key: key);

	@override
	_DatePageState createState() => _DatePageState(date: date);
}

class _DatePageState extends State<DatePage> {
	final DateTime date;
	List<Entry> entries = [];
	Entry editEntry, newEntry = Entry();
	TextEditingController newTitleController, newPriceController, newDescriptionController, editTitleController, editPriceController, editDescriptionController;

	_DatePageState({this.date});

	void fetchEntries(DateTime date) async {
		List<Entry> entries = await Entry.allonDate(date);
		setState(() => this.entries = entries);
	}

	@override
	void initState() {
		super.initState();
		this.fetchEntries(this.date);
		this.enableNewControllers();
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

	@override
	void dispose() {
		this.disposeControllers();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) => Scaffold(
		appBar: AppBar(
			centerTitle: false,
			title: Text('${Time.days[date.weekday]}, ${Time.months[date.month]} ${date.day}'),
			actions: <Widget>[
				IconButton(
					icon: Icon(Icons.add),
					onPressed: _newEntry,
				)
			],
		),
		body: Padding(
			padding: const EdgeInsets.symmetric(horizontal: 16),
			child: entries.length > 0 ? ListView.builder(
				itemCount: entries.length,
				itemBuilder: _entryBuilder,
			) : Container(
				alignment: Alignment.center,
				child: Text('No entries. Click the + button \nabove to add entries', textAlign: TextAlign.center,style: TextStyle(
					fontSize: 18,
					color: Colors.grey[600]
				)),
			),
		),
	);

	Widget _entryBuilder(BuildContext context, int index){
		Entry entry = entries[index];
		return InkWell(
			onTap: _showToast,
			onLongPress: () => _editEntry(index, entry),
			child: Padding(
				padding: const EdgeInsets.symmetric(vertical:16),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: <Widget>[
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: <Widget>[
								Text(entry.title, style: TextStyle(
									fontSize: 18
								)),
								Text('${entry.price}', style: TextStyle(
									fontWeight: FontWeight.bold,
									fontSize: 18
								))
							],
						),
						SizedBox(height: 8),
						if(entry.description != null && entry.description.isNotEmpty) Text(entry.description, style: TextStyle(
							fontSize: 15
						))
					],
				),
			),
		);
	}

	void _showToast() => Toast.info('Hold to edit entry');

	void _newEntry() => showDialog(context: context,builder: (BuildContext context) => _buildNewEntry(), barrierDismissible: false);

	void _editEntry(int index, Entry entry){
		setState(() => editEntry = entry);
		enableEditControllers();
		showDialog(context: context,builder:(BuildContext context) => _buildEditEntry(index),barrierDismissible: false);
	}

	Widget _buildNewEntry() =>  AlertDialog(
		title: Text('Create Entry', style: TextStyle(color: Colors.white)),
		backgroundColor: MyColors.Primary_Dark,
		contentTextStyle: TextStyle(color: Colors.white),
		content: Column(
			mainAxisSize: MainAxisSize.min,
			children: <Widget>[
				_buildTitleField(newTitleController),
				_buildPriceField(newPriceController),
				_buildDescriptionField(newDescriptionController),
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
							setState(() => this.entries.add(newEntry.copy()));
							Navigator.pop(context);
							setState(() => newEntry = Entry());
							this.enableNewControllers();
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
				_buildTitleField(editTitleController),
				_buildPriceField(editPriceController),
				_buildDescriptionField(editDescriptionController),
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
							setState(() => this.entries[index] = editEntry.copy());
							Navigator.pop(context);
						},
					)
				],
			)
		],
	);

	Widget _buildTitleField(TextEditingController controller) => TextField(
		style: TextStyle(color: Colors.white),
		keyboardType: TextInputType.text,
		controller: controller,
		decoration: InputDecoration(
			border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
			hintText: 'Title',
			hintStyle: TextStyle(color: Colors.grey[300]),
		),
	);

	Widget _buildPriceField(TextEditingController controller) => TextField(
		style: TextStyle(color: Colors.white),
		keyboardType: TextInputType.number,
		controller: controller,
		decoration: InputDecoration(
			border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
			hintText: 'Price',
			hintStyle: TextStyle(color: Colors.grey[300]),
		),
	);

	Widget _buildDescriptionField(TextEditingController controller) => TextField(
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

	void onNewTitleChanged() => this.newEntry.title = newTitleController.text;
	void onNewPriceChanged() => this.newEntry.price = int.tryParse(newPriceController.text) ?? 0;
	void onNewDescriptionChanged() => this.newEntry.description = newDescriptionController.text;
	void onEditTitleChanged() => this.editEntry.title = editTitleController.text;
	void onEditPriceChanged() => this.editEntry.price = int.tryParse(editPriceController.text) ?? 0;
	void onEditDescriptionChanged() => this.editEntry.description = editDescriptionController.text;
}