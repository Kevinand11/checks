import 'package:checks/models/model.dart';

class Entry extends Model{
	static const _tableName = 'entries';
	int id, price;
	String title, description;
	DateTime date;

	Entry({this.id, this.price, this.title, this.description, this.date}){
		DateTime _now =  DateTime.now();
		if (this.date == null) this.date = DateTime(_now.year,_now.month,_now.day);
	}

	String toString() => 'Entry ${this.id} - ${this.title}(${this.price})';

	factory Entry.fromMap(Map<String,dynamic> map){
		return Entry(
			id: map['id'] ?? null,
			price: map['price'] ?? null,
			title: map['title'] ?? null,
			description: map['description'] ?? null,
			date: DateTime(map['year'] ?? null, map['month'] ?? null, map['day'] ?? null),
		);
	}

	Entry copy(){
		return Entry(
			id: this.id,
			price: this.price,
			title: this.title,
			description: this.description,
			date: this.date,
		);
	}

	fromMap(Map map){
		this.id =  map['id'] ?? null;
		this.price = map['price'] ?? null;
		this.title = map['title'] ?? null;
		this.description = map['description'] ?? null;
		this.date = DateTime(map['year'] ?? null, map['month'] ?? null, map['day'] ?? null);
	}

	Map<String,dynamic> toMap() => {
		'id': this.id,
		'price': this.price,
		'title': this.title,
		'description': this.description,
		'year': this.date.year,
		'month': this.date.month,
		'day': this.date.day,
	};

	static Future<Entry> create(Map<String, dynamic> entry) async {
		if (!entry.containsKey('title') || !entry.containsKey('price') || !entry.containsKey('description') || !entry.containsKey('date')) throw Error();
		entry['year'] = (entry['date'] as DateTime).year;
		entry['month'] = (entry['date'] as DateTime).month;
		entry['day'] = (entry['date'] as DateTime).day;
		entry.remove('date');
		Map<String,dynamic> details = await Model.create(_tableName, entry);
		return details != null ? Entry.fromMap(details) : null;
	}

	static Future<Entry> find(int id) async {
		Map<String, dynamic> details = await Model.getById(_tableName, id);
		return details != null ? Entry.fromMap(details) : null;
	}

	static Future<List<Entry>> all() async {
		List<Map<String,dynamic>> entries = await Model.getAll(_tableName);
		return entries.map((entry) => Entry.fromMap(entry)).toList();
	}

	static Future<List<DateTime>> uniqueDates() async {
		List<Map<String,dynamic>> entries = await Model.getUnique(_tableName,['year','month','day']);
		return entries.map((entry) => DateTime(entry['year'],entry['month'],entry['day'],13).toUtc()).toList();
	}

	static Future<List<Entry>> allonDate(DateTime date) async {
		Map<String, dynamic> fields = {
			'year': date.year,
			'month': date.month,
			'day': date.day,
		};
		List<Map<String,dynamic>> entries = await Model.getBy(_tableName, fields);
		return entries.map((entry) => Entry.fromMap(entry)).toList();
	}

	Future<void> save() async {
		Map<String,dynamic> details = this.id != null ? await Model.update(_tableName, this.id, this.toMap()): await Model.create(_tableName, this.toMap());
		return details != null ? true : false;
	}

	Future<void> update(Map<String,dynamic> map) async {
		Map<String,dynamic> details = await Model.update(_tableName, this.id, map);
		this.fromMap(details);
	}

	Future<bool> delete() async => await Model.delete(_tableName, this.id ?? 0);

	static Future<int> deleteMany(List<int> ids) async => await Model.deleteMany(_tableName, ids);
}
