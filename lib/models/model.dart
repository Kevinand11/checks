import 'package:checks/helpers/database.dart';

class Model{
	static Future<Map<String, dynamic>> create(String tableName,Map entry) async {
		Database helper = new Database();
		var db = await helper.connection;
		int id = await db.insert(tableName, entry);
		return getById(tableName, id);
	}

	static Future<Map<String, dynamic>> getById(String tableName,int id) async {
		Database helper = new Database();
		var db = await helper.connection;
		List<Map<String, dynamic>> results = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
		return results.length > 0 ? results.first : null;
	}

	static Future<List<Map<String, dynamic>>> getBy(String tableName,Map<String, dynamic> fields) async {
		String where = '';
		List values = [];
		fields.forEach((key, value){
			where += '$key = ? AND ';
			values.add(value);
		});
		where = where.substring(0, where.lastIndexOf('AND '));
		Database helper = new Database();
		var db = await helper.connection;
		List<Map<String, dynamic>> results = await db.query(tableName, where: where, whereArgs: values);
		return results;
	}

	static Future<List<Map<String, dynamic>>> getAll(String tableName) async {
		Database helper = new Database();
		var db = await helper.connection;
		return await db.query(tableName);
	}

	static Future<List<Map<String, dynamic>>> getUnique(String tableName, List<String> columns) async {
		Database helper = new Database();
		var db = await helper.connection;
		return await db.query(tableName,columns: columns, distinct: true);
	}

	static Future<Map<String, dynamic>> update(String tableName, int id, Map map) async {
		Database helper = new Database();
		var db = await helper.connection;
		int newId = await db.update(tableName, map, where: 'id = ?', whereArgs: [id]);
		return getById(tableName, newId);
	}

	static Future<bool> delete(String tableName, int id) async {
		Database helper = new Database();
		var db = await helper.connection;
		int deletedCount = await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
		return deletedCount > 0;
	}

	static Future<int> deleteMany(String tableName, List<int> ids) async {
		Database helper = new Database();
		var db = await helper.connection;
		int deletedCount = await db.delete(tableName, where: 'id IN (${ids.join(',')})');
		return deletedCount;
	}
}